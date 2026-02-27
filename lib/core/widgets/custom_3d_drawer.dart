import 'dart:math';
import 'package:flutter/material.dart';

class Custom3DDrawer extends StatefulWidget {
  final Widget drawer;
  final Widget mainScreen;
  final double drawerWidth;

  const Custom3DDrawer({
    super.key,
    required this.drawer,
    required this.mainScreen,
    this.drawerWidth = 250,
  });

  static Custom3DDrawerState? of(BuildContext context) {
    return context.findAncestorStateOfType<Custom3DDrawerState>();
  }

  @override
  Custom3DDrawerState createState() => Custom3DDrawerState();
}

class Custom3DDrawerState extends State<Custom3DDrawer>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  bool _isOpen = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOutQuad,
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void toggle() {
    if (_isOpen) {
      _animationController.reverse();
    } else {
      _animationController.forward();
    }
    setState(() {
      _isOpen = !_isOpen;
    });
  }

  void open() {
    if (!_isOpen) {
      _animationController.forward();
      setState(() {
        _isOpen = true;
      });
    }
  }

  void close() {
    if (_isOpen) {
      _animationController.reverse();
      setState(() {
        _isOpen = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        double slide = widget.drawerWidth * _animation.value;
        double scale = 1 - (_animation.value * 0.2);
        double rotation = -pi / 6 * _animation.value;

        return Stack(
          children: [
            // Drawer background/content
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Theme.of(context).primaryColor,
                    Theme.of(context).primaryColor.withBlue(255).withRed(20),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: widget.drawer,
            ),
            // Main Screen with 3D Transformation
            Transform(
              transform: Matrix4.identity()
                ..setEntry(3, 2, 0.001) // perspective
                ..translate(slide)
                ..rotateY(rotation)
                ..scale(scale),
              alignment: Alignment.centerLeft,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(_isOpen ? 20 : 0),
                  boxShadow: _isOpen
                      ? [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 40,
                            spreadRadius: 5,
                            offset: const Offset(-20, 20),
                          ),
                        ]
                      : [],
                ),
                child: GestureDetector(
                  onTap: _isOpen ? close : null,
                  behavior: HitTestBehavior.opaque,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(_isOpen ? 20 : 0),
                    child: AbsorbPointer(
                      absorbing: _isOpen,
                      child: widget.mainScreen,
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

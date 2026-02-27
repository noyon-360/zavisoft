import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/constants/app_colors.dart';
import '../controllers/app_decision_controller.dart';

class AppDecisionScreen extends StatefulWidget {
  const AppDecisionScreen({super.key});

  @override
  State<AppDecisionScreen> createState() => _AppDecisionScreenState();
}

class _AppDecisionScreenState extends State<AppDecisionScreen> {
  final _appDecisionController = Get.put(AppDecisionController());

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _appDecisionController.nextScreen();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          decoration: BoxDecoration(color: AppColors.secondaryBlue),
        ),
      ),
    );
  }
}

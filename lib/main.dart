import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zavisoft_task/core/init/app_initializer.dart';

import 'features/app/screens/app_decision_screen.dart';

void main() async {
  await AppInitializer.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: Theme.of(context),
      home: const AppDecisionScreen(),
    );
  }
}

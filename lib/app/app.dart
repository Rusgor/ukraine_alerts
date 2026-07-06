import 'theme.dart';
import 'router.dart';
import 'package:flutter/material.dart';

class UkraineAlertsApp extends StatelessWidget {
  const UkraineAlertsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Ukraine Alerts',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      routerConfig: appRouter,
    );
  }
}

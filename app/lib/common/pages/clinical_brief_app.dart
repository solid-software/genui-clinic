import 'package:clinical_brief/common/routes/app_router.dart';
import 'package:clinical_brief/theme/app_theme.dart';
import 'package:flutter/material.dart';

/// The application root.
class const ClinicalBriefApp({super.key}) extends StatelessWidget {
  /// Creates the app.
  this;

  @override
  Widget build(BuildContext context) => MaterialApp.router(
    title: 'GenUI Clinic',
    debugShowCheckedModeBanner: false,
    theme: AppTheme.light(),
    routerConfig: AppRouter.config,
  );
}

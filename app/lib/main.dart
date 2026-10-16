import 'package:clinical_brief/common/di/service_locator.dart';
import 'package:clinical_brief/common/logging/app_logger.dart';
import 'package:clinical_brief/common/pages/clinical_brief_app.dart';
import 'package:clinical_brief/common/routes/app_router.dart';
import 'package:clinical_brief/firebase/firebase_setup.dart';
import 'package:flutter/material.dart';

/// Boots Firebase, wires the services, starts the app.
Future<void> main() async {
  AppRouter.usePathUrls();
  WidgetsFlutterBinding.ensureInitialized();

  AppLogger.configure();

  await FirebaseSetup.initialize();

  ServiceLocator.configure();

  runApp(const ClinicalBriefApp());
}

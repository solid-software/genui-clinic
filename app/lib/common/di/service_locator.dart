import 'package:clinical_brief/auth/services/auth_manager.dart';
import 'package:clinical_brief/brief_composer/brief_composer.dart';
import 'package:clinical_brief/brief_composer/gen_ui_brief_composer.dart';
import 'package:clinical_brief/brief_composer/services/brief_agent_client.dart';
import 'package:clinical_brief/check_in/repository/local_patient_repository.dart';
import 'package:clinical_brief/check_in/repository/patient_repository.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Where the app looks up its collaborators.
abstract final class ServiceLocator {
  static final _locator = GetIt.instance;

  /// Registers the domain implementations. Call once, after Firebase init.
  static void configure() {
    _locator
      ..registerLazySingleton<PatientRepository>(
        () => LocalPatientRepository(SharedPreferencesAsync()),
      )
      ..registerLazySingleton(() => BriefAgentClient.forApp(Firebase.app()))
      ..registerLazySingleton(AuthManager.new)
      // A factory: each consultation keeps its own conversation with the agent.
      ..registerFactory<BriefComposer>(
        () => GenUiBriefComposer.start(get<BriefAgentClient>()),
      );
  }

  /// The registered [T].
  static T get<T extends Object>() => _locator<T>();
}

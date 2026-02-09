import 'package:get_it/get_it.dart';
import 'package:rewire/core/services/shared_preferences_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../services/firebase_service.dart';
import '../services/firestore_service.dart';

final getIt = GetIt.instance;

Future<void> setupServiceLocator() async {
  getIt.registerSingleton<FirebaseAuthService>(FirebaseAuthService());
  getIt.registerSingleton<FirestoreService>(FirestoreService());
  getIt.registerSingleton<SharedPreferencesService>(
    SharedPreferencesService(await SharedPreferences.getInstance()),
  );
}

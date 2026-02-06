import 'package:get_it/get_it.dart';
import 'package:rewire/core/services/firebase_service.dart';
import 'package:rewire/core/services/firestore_service.dart';

final getIt = GetIt.instance;

void setupServiceLocator() {
  getIt.registerSingleton<FirebaseAuthService>(FirebaseAuthService());
  getIt.registerSingleton<FirestoreService>(FirestoreService());
}

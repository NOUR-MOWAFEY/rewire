import 'package:get_it/get_it.dart';
import '../services/firebase_service.dart';
import '../services/firestore_service.dart';

final getIt = GetIt.instance;

void setupServiceLocator() {
  getIt.registerSingleton<FirebaseAuthService>(FirebaseAuthService());
  getIt.registerSingleton<FirestoreService>(FirestoreService());
}

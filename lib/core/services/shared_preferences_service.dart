import 'package:rewire/core/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  SharedPreferencesService(this._preferences);

  final SharedPreferences _preferences;

  // is first launch

  // bool isFirstLaunch() {
  //   return _preferences.getBool(StorageKeys.isFirstLaunch) ?? true;
  // }

  // Future<void> setFirstLaunchDone() async {
  //   await _preferences.setBool(StorageKeys.isFirstLaunch, false);
  // }

  // Date

  Future<void> setTodayDate() async {
    final today = _today().toIso8601String();
    await _preferences.setString(StorageKeys.storedDate, today);
  }

  DateTime? getStoredDate() {
    final stored = _preferences.getString(StorageKeys.storedDate);
    if (stored == null) return null;
    return DateTime.parse(stored);
  }

  DateTime _today() {
    final now = DateTime.now();
    return DateTime(now.year, now.month, now.day);
  }
}

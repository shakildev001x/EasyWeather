import 'package:shared_preferences/shared_preferences.dart';

class LocationStorage {
  static const _key = 'saved_location';

  static Future<void> saveLocation(String location) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_key, location);
  }

  static Future<String?> getSavedLocation() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_key);
  }
}
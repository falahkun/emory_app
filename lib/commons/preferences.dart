import 'package:emory_app/commons/preference_keys.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  final SharedPreferences preferences;

  Preferences(this.preferences);

  bool get isLoggedIn =>
      preferences.getBool(PreferenceKeys.isLoggedIn) ?? false;

  String? get accessToken => preferences.getString(PreferenceKeys.accessToken);

  String? get userEmail => preferences.getString(PreferenceKeys.userEmail);

  int? get userId => preferences.getInt(PreferenceKeys.userId);

  void setLogin() => preferences.setBool(PreferenceKeys.isLoggedIn, true);

  void logout() => preferences.clear();

  void saveAccessToken(String token) {
    preferences.setString(PreferenceKeys.accessToken, token);
  }

  void saveUserEmail(String email) {
    preferences.setString(PreferenceKeys.userEmail, email);
  }

  void saveUserId(int id) {
    preferences.setInt(PreferenceKeys.userId, id);
  }
}

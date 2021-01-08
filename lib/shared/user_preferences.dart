import 'package:shared_preferences/shared_preferences.dart';

class UserPrefrences {
  static final UserPrefrences _instance = new UserPrefrences._internal();

  UserPrefrences._internal();
  SharedPreferences _prefs;

  initPrefs() async {
    _prefs = await SharedPreferences.getInstance();
  }

  get username {
    return _prefs.getString("username") ?? '';
  }

  set username(String username) {
    _prefs.setString('username', username);
  }

  String get email {
    return _prefs.containsKey('email')? _prefs.getString('email') :'';
  }

  set email(String email) {
    _prefs.setString('email', email);
  }

  get token {
    return _prefs.getInt('token') ?? "";
  }

  set token(String token) {
    _prefs.setString('token', token);
  }

  get isLogged {
    return this.email.isNotEmpty;
  }

  factory UserPrefrences() {
    return _instance;
  }
}

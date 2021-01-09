import 'package:shared_preferences/shared_preferences.dart';

class UserPrefences {
  static final UserPrefences _instance = new UserPrefences._internal();

  UserPrefences._internal();
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

  get provider {
    return _prefs.getInt('provider') ?? "";
  }

  set provider(String provider) {
    _prefs.setString('provider', provider);
  }

  factory UserPrefences() {
    return _instance;
  }
}
import 'package:pagos_internet/const/conts.dart';
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
    return _prefs.containsKey('email') ? _prefs.getString('email') : '';
  }

  set email(String email) {
    _prefs.setString('email', email);
  }

  get phone {
    return _prefs.getString("phone") ?? '';
  }

  set phone(String phone) {
    _prefs.setString('phone', phone);
  }

  get address {
    return _prefs.getString("address") ?? '';
  }

  set address(String address) {
    _prefs.setString('address', address);
  }

  get token {
    return _prefs.getString('token') ?? "";
  }

  set token(String token) {
    _prefs.setString('token', token);
  }

  get isLogged {
    return this.email.isNotEmpty;
  }

  get provider {
    return _prefs.getString('provider') ?? "";
  }

  set provider(String provider) {
    _prefs.setString('provider', provider);
  }

  get type {
    return _prefs.getString('type') ?? "";
  }

  set type(String type) {
    _prefs.setString('type', type);
  }

  Future clear() async {
    return await _prefs.clear();
  }

  factory UserPrefences() {
    return _instance;
  }

  bool get isAdmin{
    return ADMIN_USERS.contains(_prefs.getString('email'));
  }

}

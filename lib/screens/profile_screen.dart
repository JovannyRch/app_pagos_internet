import 'package:flutter/material.dart';
import 'package:pagos_internet/const/conts.dart';
import 'package:pagos_internet/screens/auth/login_screen.dart';
import 'package:pagos_internet/shared/user_preferences.dart';

class ProfileScreen extends StatefulWidget {
  static String routeName = "/profile";
  const ProfileScreen({Key key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Size _size;
  UserPrefrences _userPrefrences = new UserPrefrences();

  @override
  Widget build(BuildContext context) {
    _size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kSecondaryColor,
        title: Text("Perfil"),
        elevation: 0,
      ),
      body: _body(),
    );
  }

  Widget _body() {
    return Container(
      height: _size.height,
      width: _size.width,
      child: SingleChildScrollView(
        child: Column(
          children: [
            _saludo(),
            _logOutButton(),
          ],
        ),
      ),
    );
  }

  Widget _saludo() {
    return Container(
      width: double.infinity,
      height: _size.height * 0.1,
      color: kSecondaryColor,
      child: Center(
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.only(left: 15.0),
          child: Text("Hola ${_userPrefrences.username}", style: TextStyle(
            fontSize: 20,
            color: Colors.white,
            
          ),
          textAlign: TextAlign.left,),
        ),
      ),
    );
  }

  Widget _logOutButton() {
    return ListTile(
      leading: Icon(Icons.exit_to_app),
      title: Text("Cerrar sesión"),
      onTap: handleLogout,
    );
  }

  void handleLogout(){
    Navigator.pushReplacementNamed(context, LoginScreen.routeName);
  }
}

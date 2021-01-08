import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/material.dart';
import 'package:pagos_internet/const/conts.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController password = new TextEditingController();
  TextEditingController username = new TextEditingController();
  BuildContext _globalContext;
  bool isCheckingUser = false;
  Size _size;

  @override
  Widget build(BuildContext context) {
    _size = MediaQuery.of(context).size;
    _globalContext = context;
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment
                  .bottomCenter, // 10% of the width, so there are ten blinds.
              colors: [
                Theme.of(context).scaffoldBackgroundColor,
                Colors.white
              ], // red to yellow
              tileMode:
                  TileMode.repeated, // repeats the gradient over the canvas
            ),
          ),
          width: double.infinity,
          child: _body(),
        ),
      ),
    );
  }

  Widget _body() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _logo(),
        _form(),
        _image(),
      ],
    );
  }

  Widget _logo() {
    return Container(
      child: Text(
        "Pagos de internet",
        style: TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.bold,
          letterSpacing: 2.0,
          color: kMainColor,
        ),
      ),
    );
  }

  Widget _image() {
    return Container(
      padding: EdgeInsets.only(top: _size.height*0.06),
      child: Image.asset(
        'assets/auth-image.png',
        width: _size.width * 0.8,
      ),
    );
  }

  Widget _input(String text, IconData icon,
      {bool isPassword = false, TextEditingController controller}) {
    return Container(
      margin: EdgeInsets.only(bottom: 14.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4.0),
      ),
      child: TextField(
        controller: controller,
        obscureText: isPassword,
        decoration: InputDecoration(
          prefixIcon: Icon(
            icon,
            color: kMainColor,
          ),
          labelText: text,
          labelStyle: TextStyle(
            color: kMainColor,
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: kMainColor),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: kMainColor),
          ),
          border: UnderlineInputBorder(
            borderSide: BorderSide(color: kMainColor),
          ),
        ),
      ),
    );
  }

  Widget _form() {
    return Container(
      margin: EdgeInsets.only(top: _size.height * 0.08),
      padding: EdgeInsets.symmetric(
        horizontal: 35.0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _authTitle(),
          SizedBox(height: 16.0),
          _input("Correo electrónico", Icons.person, controller: this.username),
          _input("Contraseña", Icons.lock,
              isPassword: true, controller: this.password),
          _loginButton(),
        ],
      ),
    );
  }

  Widget _authTitle() {
    return Text(
      "Iniciar sesión",
      style: TextStyle(
        color: kSecondaryColor,
        fontWeight: FontWeight.w700,
        fontSize: 24.0,
      ),
    );
  }

  Widget _loginButton() {
    return Container(
      width: double.infinity,
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        onPressed: !isCheckingUser ? checkInputData : null,
        color: kSecondaryColor,
        textColor: Colors.white,
        child: !isCheckingUser
            ? Text(
                "Iniciar sesión".toUpperCase(),
                style: TextStyle(fontSize: 14),
              )
            : CircularProgressIndicator(),
      ),
    );
  }

  void checkInputData() {
    if (this.password.text.isEmpty || this.username.text.isEmpty) {
      this.showInvalidAlerts();
    } else {
      this.tryLogin();
    }
  }

  void tryLogin() {
    try {
      handleLogin();
    } catch (e) {
      showLoginErrorAlert();
      setCheckingUser(false);
    }
  }

  void showLoginErrorAlert() {
    showOkAlertDialog(
        context: _globalContext, message: "Ocurrió un error al hacer el login");
  }

  void showInvalidAlerts() {
    if (this.username.text.isEmpty) {
      showOkAlertDialog(
          context: _globalContext, message: "Ingrese ]correo válido");
    } else if (this.password.text.isEmpty) {
      showOkAlertDialog(
          context: _globalContext,
          message: "La contraseña no puede estar vacía");
    }
  }

  void handleLogin() async {
    setCheckingUser(true);
    /*  AuthResponse userFromDb =
        await authService.login(username.text.trim(), password.text.trim());
    if (userFromDb == null) {
      showUserNotFoundMessage();
    } else {
      authService.storeUserInDevice(userFromDb);
      goHomeScreen(userFromDb);
    } */
    setCheckingUser(false);
  }

  void setCheckingUser(bool val) {
    setState(() {
      isCheckingUser = val;
    });
  }
}

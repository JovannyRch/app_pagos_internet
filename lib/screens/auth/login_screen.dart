import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pagos_internet/const/conts.dart';
import 'package:pagos_internet/helpers/storage.dart';
import 'package:pagos_internet/helpers/validators.dart';
import 'package:pagos_internet/models/user_model.dart';
import 'package:pagos_internet/screens/auth/login_controller.dart';
import 'package:pagos_internet/screens/auth/register_screen.dart';
import 'package:pagos_internet/screens/customer/home_customer_screen.dart';
import 'package:pagos_internet/widget/InputWidget.dart';

class LoginScreen extends StatefulWidget {
  static String routeName = "/login";
  LoginScreen({Key key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController email = new TextEditingController();
  TextEditingController password = new TextEditingController();
  BuildContext _globalContext;
  bool isCheckingUser = false;
  Size _size;

  @override
  Widget build(BuildContext context) {
    _size = MediaQuery.of(context).size;
    _globalContext = context;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(top: _size.height * 0.1),
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
        _containerLinkRegister(),
        _image(),
      ],
    );
  }

  Widget _containerLinkRegister() {
    return Container(
      child: Column(
        children: [
          SizedBox(height: 20),
          Divider(),
          Text(
            "¿No tienes cuenta?",
            style: TextStyle(
              fontSize: 16,
              color: kMainColor,
            ),
          ),
          SizedBox(height: 10),
          GestureDetector(
            onTap: handleRegisterClick,
            child: Text(
              "Crear una nueva cuenta",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: kSecondaryColor,
              ),
            ),
          )
        ],
      ),
    );
  }

  void handleRegisterClick() {
    Navigator.pushNamed(context, RegisterScreen.routeName);
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
      padding: EdgeInsets.only(top: _size.height * 0.06),
      child: Image.asset(
        'assets/auth-image.png',
        width: _size.width * 0.6,
      ),
    );
  }

  Widget _form() {
    return Form(
      key: _formKey,
      child: Container(
        margin: EdgeInsets.only(top: _size.height * 0.08),
        padding: EdgeInsets.symmetric(
          horizontal: 35.0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _authTitle(),
            SizedBox(height: 16.0),
            Input(
              text: "Correo electrónico",
              icon: Icons.email,
              controller: this.email,
              validator: emailValidator,
            ),
            Input(
              text: "Contraseña",
              icon: Icons.lock,
              controller: this.password,
              isPassword: true,
              validator: passwordValidator,
            ),
            _loginButton(),
          ],
        ),
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
    if (this.email.text.isEmpty || this.password.text.isEmpty) {
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
    if (this.password.text.isEmpty) {
      showOkAlertDialog(
          context: _globalContext, message: "Ingrese un correo válido");
    } else if (this.email.text.isEmpty) {
      showOkAlertDialog(
          context: _globalContext,
          message: "La contraseña no puede estar vacía");
    }
  }

  void handleLogin() async {
    if (_formKey.currentState.validate()) {
      setCheckingUser(true);
      UserCredential user = await signIn(email.text, password.text);
      if (user != null) {
        Usuario usuario = await Usuario.getById(user.user.email); 
        Storage.saveUser(usuario);
        Navigator.pushReplacementNamed(context, HomeCustumer.routeName);
      }
      setCheckingUser(false);
    }
  }

  void setCheckingUser(bool val) {
    setState(() {
      isCheckingUser = val;
    });
  }
}

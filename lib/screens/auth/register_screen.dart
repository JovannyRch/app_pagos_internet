import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pagos_internet/const/conts.dart';
import 'package:pagos_internet/helpers/alerts.dart';
import 'package:pagos_internet/helpers/validators.dart';
import 'package:pagos_internet/models/item_comprobante.dart';
import 'package:pagos_internet/screens/auth/login_screen.dart';
import 'package:pagos_internet/screens/customer/home_customer_screen.dart';
import 'package:pagos_internet/widget/InputWidget.dart';

class RegisterScreen extends StatefulWidget {
  static String routeName = "/register";
  RegisterScreen({Key key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController password = new TextEditingController();
  TextEditingController password2 = new TextEditingController();
  TextEditingController address = new TextEditingController();
  TextEditingController email = new TextEditingController();
  TextEditingController username = new TextEditingController();
  BuildContext _globalContext;
  bool isCheckingUser = false;
  Size _size;

  List<Item> users = <Item>[
    const Item('Android',Icon(Icons.android,color:  const Color(0xFF167F67),)),
    const Item('Flutter',Icon(Icons.flag,color:  const Color(0xFF167F67),)),
    const Item('ReactNative',Icon(Icons.format_indent_decrease,color:  const Color(0xFF167F67),)),
    const Item('iOS',Icon(Icons.mobile_screen_share,color:  const Color(0xFF167F67),)),
  ];

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
                begin: Alignment.bottomCenter,
                end: Alignment
                    .topCenter, // 10% of the width, so there are ten blinds.
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
        /*   _image(), */
        _form(),
        _containerLinkRegister(),
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
            "¿Ya tienes cuenta?",
            style: TextStyle(
              fontSize: 16,
              color: kMainColor,
            ),
          ),
          SizedBox(height: 10),
          GestureDetector(
            onTap: handleNavigationLoginClick,
            child: Text(
              "Iniciar sesión",
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

  void handleNavigationLoginClick() {
    Navigator.pop(context, LoginScreen.routeName);
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
        height: _size.height * 0.10,
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
                text: "Nombre completo",
                icon: Icons.person,
                controller: this.username),
            Input(
                text: "Domicilio completo",
                icon: Icons.pin_drop,
                controller: this.address),
            _dropDown(),
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
                isPassword: true),
            Input(
                text: "Confirme su contraseña",
                icon: Icons.lock,
                controller: this.password2,
                isPassword: true),
            _loginButton(),
          ],
        ),
      ),
    );
  }

  Widget _dropDown(){
    return DropdownButton<Item>(
            
            hint:  Text("Selecciona un proveedor"),
            isExpanded: true,
            onChanged: (Item Value) {
              /* setState(() {
                selectedUser = Value;
              }); */
            },
            items: users.map((Item user) {
              return  DropdownMenuItem<Item>(
                value: user,
                child: Container(
                  width: double.infinity,
                  child: Row(
                    children: <Widget>[
                      user.icon,
                      SizedBox(width: 10,),
                      Text(
                        user.name,
                        style:  TextStyle(color: Colors.black),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          );
  }

  Widget _authTitle() {
    return Text(
      "Registro de usuario",
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
        onPressed: !isCheckingUser ? checkInputDataOrTryRegister : null,
        color: kSecondaryColor,
        textColor: Colors.white,
        child: !isCheckingUser
            ? Text(
                "Registrarse".toUpperCase(),
                style: TextStyle(fontSize: 14),
              )
            : CircularProgressIndicator(),
      ),
    );
  }

  void checkInputDataOrTryRegister() {
    if (this.password.text.isEmpty || this.username.text.isEmpty) {
      this.showInvalidAlerts();
    } else {
      this.tryRegister();
    }
  }

  void tryRegister() {
    try {
      handleRegister();
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
    if (RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(this.email.text)) {
      showOkAlertDialog(
          context: _globalContext, message: "Ingrese un correo válido");
    } else if (this.password.text.isEmpty) {
      showOkAlertDialog(
          context: _globalContext,
          message: "La contraseña no puede estar vacía");
    }
  }

  void handleRegister() async {
    try {
      setCheckingUser(true);
      if (!_formKey.currentState.validate()) {
        return;
      } else {
        _formKey.currentState.save();
        UserCredential user = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: email.text.toLowerCase(), password: password.text)
            .catchError((onError) {
          print('ERRRRRRROOOOOOOOR');
          print(onError);
          showAlert(context, 'Algo salio mal...', onError.toString());
        });
        print(user.user.email);

        if (user != null) {
          print("El usuario fue registrado correctamente");
          /* Usuario usuario = new Usuario(
              tipoUsuario: "afiliado",
              apellidoMaterno: _apellidoMaternoController.text,
              apellidoPaterno: _apellidoPaternoController.text,
              correo: _emailController.text,
              licencia: "",
              nombre: _nameController.text,
              placa: "",
              seguro: "",
              tokenPush: tokenPush,
            );
            await usuario.save(_emailController.text); */
          await user.user.updateProfile(displayName: username.text);
          success(context, "Cuenta creada", "Su registro ha sido exitoso",
              f: () {
            Navigator.pushReplacementNamed(context, HomeCustumer.routeName);
          });
          setCheckingUser(false);
        }
      }
    } catch (e) {
      print("Error");
      print(e.toString());
      setState(() {
        setCheckingUser(false);
      });
    }
  }

  void setCheckingUser(bool val) {
    setState(() {
      isCheckingUser = val;
    });
  }
}

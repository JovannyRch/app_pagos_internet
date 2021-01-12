import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pagos_internet/const/conts.dart';
import 'package:pagos_internet/helpers/alerts.dart';
import 'package:pagos_internet/helpers/validators.dart';
import 'package:pagos_internet/models/item_proveedor_comprobante.dart';
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
  TextEditingController phone = new TextEditingController();

  BuildContext _globalContext;
  bool isCheckingUser = false;
  Size _size;
  ItemProveedor providerSelected;

  List<ItemProveedor> users = <ItemProveedor>[
    const ItemProveedor(
        'Googinet',
        Icon(
          Icons.wifi,
          color: kSecondaryColor,
        )),
    const ItemProveedor(
        'Intervala',
        Icon(
          Icons.wifi_rounded,
          color: kSecondaryColor,
        )),
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
                controller: this.address,
                ),
            _dropDown(),
            Input(
              text: "Teléfono de contacto",
              icon: Icons.phone,
              controller: this.phone,
              keyboardType: TextInputType.phone,
            ),
            Input(
              text: "Correo electrónico",
              icon: Icons.email,
              controller: this.email,
              validator: emailValidator,
              keyboardType: TextInputType.emailAddress,
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

  Widget _dropDown() {
    return DropdownButton<ItemProveedor>(
    
      hint: Text("Selecciona un proveedor"),
      isExpanded: true,
      value: providerSelected,
      
      underline: Container(
        color: kMainColor.withOpacity(0.3),
        height: 1.0,
      ),
      focusColor: kSecondaryColor,
      onChanged: (ItemProveedor value) {
        setState(() {
          providerSelected = value;
        });
      },
      items: users.map((ItemProveedor user) {
        return DropdownMenuItem<ItemProveedor>(
          value: user,
          child: Container(
            padding: EdgeInsets.only(left: 15.0),
            width: double.infinity,
            child: Row(
              children: <Widget>[
                user.icon,
                SizedBox(
                  width: 10,
                ),
                Text(
                  user.name,
                  style: TextStyle(color: Colors.black),
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
    tryRegister();
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

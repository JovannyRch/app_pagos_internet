import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:loading_button/loading_button.dart';
import 'package:pagos_internet/const/conts.dart';
import 'package:pagos_internet/helpers/alerts.dart';
import 'package:pagos_internet/helpers/storage.dart';
import 'package:pagos_internet/helpers/validators.dart';
import 'package:pagos_internet/models/item_proveedor_comprobante.dart';
import 'package:pagos_internet/models/user_model.dart';
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
          physics: BouncingScrollPhysics(),
          child: Container(
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
        /*  // _logo(),
        _image(), */
        _form(),
        _containerLinkRegister(),
        SizedBox(
          height: 80.0,
        ),
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
/* 
  Widget _image() {
    return Container(
      padding: EdgeInsets.only(top: _size.height * 0.06),
      child: Image.asset(
        'assets/auth-image.png',
        height: _size.height * 0.10,
      ),
    );
  } */

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
              controller: this.username,
              validator: valueRequired,
              textCapitalization: TextCapitalization.words,
            ),
            Input(
              text: "Domicilio completo",
              icon: Icons.pin_drop,
              controller: this.address,
              validator: valueRequired,
              textCapitalization: TextCapitalization.words,
            ),
            _dropDown(),
            Input(
              text: "Teléfono de contacto",
              icon: Icons.phone,
              controller: this.phone,
              keyboardType: TextInputType.phone,
              validator: valueRequired,
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
              validator: passwordValidator,
              isPassword: true,
            ),
            Input(
              text: "Confirme su contraseña",
              icon: Icons.lock,
              controller: this.password2,
              validator: (String value) {
                return passwordConfirmValidator(this.password.text, value);
              },
              isPassword: true,
            ),
            SizedBox(height: 15.0),
            _formSubmitButton(),
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

  Widget _formSubmitButton() {
    return Center(
      child: LoadingButton(
        onPressed: checkInputDataOrTryRegister,
        isLoading: isCheckingUser,
        decoration: BoxDecoration(
          color: kSecondaryColor,
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Text(
          "Registrarse".toUpperCase(),
          style: TextStyle(fontSize: 14),
        ),
      ),
    );
  }

  void checkInputDataOrTryRegister() {
    try {
      handleRegister();
    } catch (e) {
      showLoginErrorAlert();
    } finally {
      setCheckingUser(false);
    }
  }

  void showLoginErrorAlert() {
    showOkAlertDialog(
        context: _globalContext, message: "Ocurrió un error al hacer el login");
  }

  void handleRegister() async {
    if (_formKey.currentState.validate()) {
      if (providerSelected != null) {
        tryRegister();
      } else {
        showOkAlertDialog(
            context: context,
            title: "Datos incompletos",
            message: "Seleccione su proveedor de servicio de internet");
      }
    }
  }

  void setCheckingUser(bool val) {
    setState(() {
      isCheckingUser = val;
    });
  }

  void tryRegister() async {
    try {
      setCheckingUser(true);
      UserCredential user = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: email.text.toLowerCase().trim(), password: password.text)
          .catchError((onError) {
        showAlert(context, 'Algo salio mal...', onError.toString());
      });

      if (user != null) {
        await user.user.updateProfile(displayName: username.text);
        saveUserDetails();
      }
    } catch (e) {
      handleErrorRegister(e);
      setCheckingUser(false);
    }
  }

  void saveUserDetails() async {
    Usuario user = new Usuario(
        id: email.text.toLowerCase().trim(),
        proveedor: providerSelected.name,
        domicilioCompleto: address.text,
        username: username.text,
        telefono: phone.text);
    await Usuario.saveUser(user);
    Storage.saveUser(user);
    showSuccessRegister();
  }

  void showSuccessRegister() {
    Navigator.pushReplacementNamed(context, HomeCustumer.routeName);
    /*  success(
      context,
      "Cuenta creada",
      "Su registro ha sido exitoso",
      f: () {
       
      },
    );
    setCheckingUser(false); */
  }

  void handleErrorRegister(e) {
    Widget cancelButton = FlatButton(
      child: Text("Entendido"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    AlertDialog alert = AlertDialog(
      title: Text("Error de registro"),
      content: Text(
          "Ocurrió un error al crear el registro de usuario, por favor intente de nuevo"),
      actions: [
        cancelButton,
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
    setState(() {
      setCheckingUser(false);
    });
  }
}

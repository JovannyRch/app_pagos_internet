import 'package:flutter/material.dart';
import 'package:pagos_internet/const/conts.dart';
import 'package:pagos_internet/screens/profile_screen.dart';

class HomeCustumer extends StatefulWidget {
  static String routeName = "/customer";
  HomeCustumer({Key key}) : super(key: key);

  @override
  _HomeCustumerState createState() => _HomeCustumerState();
}

class _HomeCustumerState extends State<HomeCustumer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kSecondaryColor,
        actions: [
          _perfilButton(),
        ],
      ),
      body: Center(
        child: Text("Customer Home Screen"),
      ),
    );
  }

  Widget _perfilButton() {
    return Container(
      child: IconButton(
          icon: Icon(Icons.person), onPressed: handlePerfilButtonClick),
    );
  }

  void handlePerfilButtonClick() {
    Navigator.pushNamed(context, ProfileScreen.routeName);
  }
}

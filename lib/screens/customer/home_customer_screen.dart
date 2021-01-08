import 'package:flutter/material.dart';


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
      body: Center(child: Text("Customer Home Screen"),),
    );
  }
}
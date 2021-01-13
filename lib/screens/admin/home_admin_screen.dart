import 'package:flutter/material.dart';


class HomeAdminScreen extends StatefulWidget {
  static String routeName = "/home/admin";
  HomeAdminScreen({Key key}) : super(key: key);

  @override
  _HomeAdminScreenState createState() => _HomeAdminScreenState();
}

class _HomeAdminScreenState extends State<HomeAdminScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Adm"),
      ),
    );
  }
}
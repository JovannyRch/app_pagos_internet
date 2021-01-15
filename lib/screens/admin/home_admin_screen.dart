import 'package:flutter/material.dart';
import 'package:pagos_internet/const/conts.dart';
import 'package:pagos_internet/helpers/storage.dart';
import 'package:pagos_internet/models/user_model.dart';
import 'package:pagos_internet/screens/admin/comprobantes_admin_screen.dart';
import 'package:pagos_internet/screens/admin/usuarios_admin_screen.dart';
import 'package:pagos_internet/widget/ProfileButton.dart';

class HomeAdminScreen extends StatefulWidget {
  static String routeName = "/home/admin";
  HomeAdminScreen({Key key}) : super(key: key);

  @override
  _HomeAdminScreenState createState() => _HomeAdminScreenState();
}

class _HomeAdminScreenState extends State<HomeAdminScreen> {
  Usuario provedor = Storage.getCurrentUser();
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kSecondaryColor,
        title: Text("${provedor.username}"),
        actions: [
          ProfileButton(),
        ],
      ),
      body: _body(),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: kSecondaryColor,
        currentIndex: _selectedIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.payment),
            label: "Comprobantes",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: "Clientes",
          )
        ],
        onTap: (val) {
          setState(() {
            _selectedIndex = val;
          });
        },
      ),
    );
  }

  Widget _body() {
    return IndexedStack(
      index: _selectedIndex,
      children: [
        ComprobantesAdminScreen(),
        UsuariosAdminScreen(),
      ],
    );
  }
}

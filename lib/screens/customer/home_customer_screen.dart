import 'package:flutter/material.dart';
import 'package:pagos_internet/const/conts.dart';
import 'package:pagos_internet/screens/customer/historial_screen.dart';
import 'package:pagos_internet/screens/customer/pago_screen.dart';
import 'package:pagos_internet/screens/profile_screen.dart';
import 'package:pagos_internet/widget/ProfileButton.dart';

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
        title: Text("Pagos Internet"),
        actions: [
          ProfileButton(),
        ],
      ),
      body: _body(),
      /*   bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: kSecondaryColor,
        currentIndex: _selectedIndex,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.payment), label: "Comprobante"),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: "Historial")
        ],
         onTap: (val) {
          setState(() {
            _selectedIndex = val;
          });
        },
      ), */
    );
  }

  Widget _body() {
    return Container(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PagoScreen(),
            HistorialScreen(),
          ],
        ),
      ),
    );
  }

}

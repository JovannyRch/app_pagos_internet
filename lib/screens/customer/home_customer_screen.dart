import 'package:flutter/material.dart';
import 'package:pagos_internet/const/conts.dart';
import 'package:pagos_internet/screens/customer/historial_screen.dart';
import 'package:pagos_internet/screens/customer/pago_screen.dart';
import 'package:pagos_internet/screens/profile_screen.dart';

class HomeCustumer extends StatefulWidget {
  static String routeName = "/customer";
  HomeCustumer({Key key}) : super(key: key);

  @override
  _HomeCustumerState createState() => _HomeCustumerState();
}

class _HomeCustumerState extends State<HomeCustumer> {

 int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kSecondaryColor,
        title: Text("Pagos Internet"),
        actions: [
          _perfilButton(),
        ],
      ),
       body: IndexedStack(
        index: _selectedIndex,
        children: [
          PagoScreen(),
          HistorialScreen(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
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

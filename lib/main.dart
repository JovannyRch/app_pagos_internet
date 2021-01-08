import 'package:flutter/material.dart';
import 'package:pagos_internet/routes/routes.dart';
import 'package:pagos_internet/screens/auth/login_screen.dart';
 
void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pagos Internet',
      debugShowCheckedModeBanner: false,
      initialRoute: LoginScreen.routeName,
      routes: routes,
    );
  }
}
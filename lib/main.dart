import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:pagos_internet/routes/routes.dart';
import 'package:pagos_internet/screens/admin/home_admin_screen.dart';
import 'package:pagos_internet/screens/auth/login_screen.dart';
import 'package:pagos_internet/screens/customer/home_customer_screen.dart';
import 'package:pagos_internet/shared/user_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  UserPrefences userPrefrences= new UserPrefences();
  await userPrefrences.initPrefs();
  String initialRoute;
  if (userPrefrences.isLogged) {
    if(userPrefrences.isAdmin){
      initialRoute = HomeAdminScreen.routeName;
    }else{
      initialRoute = HomeCustumer.routeName;
    }

  } else {
    initialRoute = LoginScreen.routeName;
  }

  await Firebase.initializeApp();
  runApp(MyApp(initialRoute));
}

class MyApp extends StatelessWidget {
  final initialRoute;
  MyApp(this.initialRoute);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NetPay - Pagos de Internet',
      debugShowCheckedModeBanner: false,
      initialRoute: initialRoute,
      routes: routes,
    );
  }
}

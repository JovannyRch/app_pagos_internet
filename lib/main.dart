import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:pagos_internet/routes/routes.dart';
import 'package:pagos_internet/screens/auth/login_screen.dart';
import 'package:pagos_internet/screens/customer/home_customer_screen.dart';
import 'package:pagos_internet/shared/user_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  UserPrefrences userPrefrences = new UserPrefrences();
  await userPrefrences.initPrefs();
  print(userPrefrences.email);
  print(userPrefrences.isLogged);
  String initialRoute;
  if (userPrefrences.isLogged) {
    initialRoute = HomeCustumer.routeName;
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
      title: 'Pagos Internet',
      debugShowCheckedModeBanner: false,
      initialRoute: initialRoute,
      routes: routes,
    );
  }
}

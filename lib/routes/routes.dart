

import 'package:pagos_internet/screens/auth/login_screen.dart';
import 'package:pagos_internet/screens/auth/register_screen.dart';
import 'package:pagos_internet/screens/customer/home_customer_screen.dart';
import 'package:pagos_internet/screens/profile_screen.dart';

final routes = {
  LoginScreen.routeName: (context) => LoginScreen(),
  RegisterScreen.routeName: (context) => RegisterScreen(),
  HomeCustumer.routeName: (context) => HomeCustumer(),
  ProfileScreen.routeName: (context) => ProfileScreen(),
};
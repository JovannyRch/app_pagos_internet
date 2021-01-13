import 'package:flutter/material.dart';
import 'package:pagos_internet/screens/profile_screen.dart';


class ProfileButton extends StatelessWidget {
  const ProfileButton({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: IconButton(
          icon: Icon(Icons.person), onPressed: (){handlePerfilButtonClick(context);}),
    );
  }
  
  void handlePerfilButtonClick(BuildContext context) {
    Navigator.pushNamed(context, ProfileScreen.routeName);
  }

}
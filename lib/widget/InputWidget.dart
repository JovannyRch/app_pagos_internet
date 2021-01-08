import 'package:flutter/material.dart';
import 'package:pagos_internet/const/conts.dart';

class Input extends StatelessWidget {
  final String text;
  final IconData icon;
  final bool isPassword;
  final TextEditingController controller;
  final Function validator;
  Input(
      {@required this.text,
      @required this.icon,
      this.isPassword = false,
    @required this.controller, this.validator});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: _input(this.text, this.icon,
          isPassword: this.isPassword, controller: this.controller),
    );
  }


  Widget _input(String text, IconData icon,
      {bool isPassword = false, TextEditingController controller}) {
    return Container(
      
      margin: EdgeInsets.only(bottom: 14.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4.0),
      ),
      child: TextFormField(
        
        controller: controller,
        obscureText: isPassword,
        validator: this.validator,
        decoration: InputDecoration(
    
          prefixIcon: Icon(
            icon,
            color: kMainColor,
          ),
          labelText: text,
          labelStyle: TextStyle(
            color: kMainColor,
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: kMainColor),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: kMainColor),
          ),
          border: UnderlineInputBorder(
            borderSide: BorderSide(color: kMainColor),
          ),
        ),
        
      ),
    );
  }
}

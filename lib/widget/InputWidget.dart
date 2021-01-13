import 'package:flutter/material.dart';
import 'package:pagos_internet/const/conts.dart';

class Input extends StatelessWidget {
  final String text;
  final IconData icon;
  final bool isPassword;
  final TextEditingController controller;
  final Function validator;
  final String helperText;
  final TextInputType keyboardType;
  final TextCapitalization textCapitalization;

  Input({
    @required this.text,
    @required this.icon,
    this.isPassword = false,
    @required this.controller,
    this.validator,
    this.helperText,
    this.keyboardType = TextInputType.text,
    this.textCapitalization = TextCapitalization.none,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      child: _input(this.text, this.icon,
          isPassword: this.isPassword,
          controller: this.controller,
          helperText: this.helperText),
    );
  }

  Widget _input(
    String text,
    IconData icon, {
    bool isPassword = false,
    TextEditingController controller,
    String helperText = "",
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: 14.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4.0),
      ),
      child: TextFormField(
        textCapitalization: textCapitalization,
        controller: controller,
        obscureText: isPassword,
        validator: this.validator,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          helperText: helperText,
          prefixIcon: Icon(
            icon,
            color: kMainColor,
          ),
          labelText: text,
          labelStyle: TextStyle(
            color: kMainColor,
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: kMainColor.withOpacity(0.3)),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: kSecondaryColor),
          ),
          border: UnderlineInputBorder(
            borderSide: BorderSide(color: kMainColor),
          ),
        ),
      ),
    );
  }
}

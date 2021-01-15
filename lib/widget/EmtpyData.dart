import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pagos_internet/const/conts.dart';

class EmtpyData extends StatelessWidget {
  
  final String message;
  EmtpyData({this.message = "No se encontraron datos"});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FaIcon(
              FontAwesomeIcons.database,
              color: kMainColor.withOpacity(0.7),
            ),
            SizedBox(height: 10.0),
            Text(
              this.message,
              style: TextStyle(
                color: kMainColor.withOpacity(0.8),
              ),
            )
          ],
        ),
      ),
    );;
  }
}
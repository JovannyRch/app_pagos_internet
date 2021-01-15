import 'package:flutter/material.dart';
import 'package:pagos_internet/const/conts.dart';

class CardTitle extends StatelessWidget {
  final String title;
  CardTitle({@required this.title});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10.0),
      child: Text(
        title,
        style: TextStyle(
          color: kMainColor.withOpacity(0.7),
        ),
      ),
    );
  }
}
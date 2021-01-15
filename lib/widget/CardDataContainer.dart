import 'package:flutter/material.dart';

class CardDataContainer extends StatelessWidget {
  final Widget child;
  final double height;

  CardDataContainer({@required this.child, this.height = 180.0});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(15.0),
      margin: EdgeInsets.only(bottom: 25.0),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: child,
    );
  }
}

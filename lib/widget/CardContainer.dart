import 'package:flutter/material.dart';
import 'package:pagos_internet/const/conts.dart';

class CardContainer extends StatelessWidget {
  final Widget child;
  final double height;
  final double width;
  final EdgeInsets padding;

  CardContainer({@required this.child, this.height = 100, this.padding, this.width});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      padding: padding,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(color: kMainColor.withOpacity(0.2), offset: Offset(1,3), blurRadius: 5.0)
        ],
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: child,
    );
  }
}
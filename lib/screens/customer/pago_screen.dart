import 'package:flutter/material.dart';
import 'package:pagos_internet/const/conts.dart';
import 'package:pagos_internet/helpers/months.dart';

enum StatusPaymanent {
  PAYED,
  CHECKING,
  NOT_PAYED,
}

class PagoScreen extends StatefulWidget {
  PagoScreen({Key key}) : super(key: key);

  @override
  _PagoScreenState createState() => _PagoScreenState();
}

class _PagoScreenState extends State<PagoScreen> {
  StatusPaymanent status = StatusPaymanent.NOT_PAYED;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: _container(),
    );
  }

  Widget _container() {
    return Column(
      children: [
        _currentMonthStatus(),
        SizedBox(height: 14),
        _currentMonthLabel(),
      ],
    );
  }

  Widget _currentMonthLabel() {
    return Text(
      "${getCurrentMonth()} ${getCurrentYear()}",
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: kMainColor,
      ),
    );
  }

  Widget _currentMonthStatus() {
    return Container(
      width: 10,
      height: 10,
      margin: EdgeInsets.only(top: 20.0),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: kMainColor.withOpacity(0.6),
            offset: Offset(1, 1),
            blurRadius: 1.0,
          ),
        ],
        color: _setColorByStatus(),
      ),
    );
  } 

  Color _setColorByStatus() {
    switch (status) {
      case StatusPaymanent.CHECKING:
        return Colors.yellow;
      case StatusPaymanent.NOT_PAYED:
        return Colors.red;
      case StatusPaymanent.PAYED:
        return Colors.green;
    }
    return Colors.white;
  }
}

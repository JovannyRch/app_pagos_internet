import 'package:flutter/material.dart';
import 'package:pagos_internet/const/conts.dart';
import 'package:pagos_internet/helpers/months.dart';
import 'package:pagos_internet/models/comprobante_model.dart';
import 'package:pagos_internet/widget/CardContainer.dart';

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
  Size _size;
  
  DateTime _now;


  @override
  Widget build(BuildContext context) {
    _size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.only(top: 20, left: 20, right: 20),
      width: double.infinity,
      child: _currentMonthCard(),
    );
  }

  Widget _currentMonthCard() {
    return CardContainer(
      width: double.infinity,
      height: _size.height * 0.30,
      padding: EdgeInsets.all(30),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _titleCard(),
          SizedBox(height: 8.0),
          _currentMonthLabel(),
          SizedBox(height: 4.0),
          _rowInfoStatus(),
          SizedBox(height: 12.0),
          _actionButton(),
          
        ],
      ),
    );
  }

  Widget _actionButton() {
    if (status != StatusPaymanent.NOT_PAYED) return Container();
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        RaisedButton(
          onPressed: handleSendComprobante,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          color: kSecondaryColor,
          child: Row(
            children: [
              Text(
                "Enviar comprobante",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              SizedBox(width: 10),
              Icon(
                Icons.arrow_upward,
                color: Colors.white,
              )
            ],
          ),
        )
      ],
    );
  }

  void handleSendComprobante() {
    //TODO: Take a photo
    Comprobante comprobante = new Comprobante();
  }

  Widget _rowInfoStatus() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        _currentMonthStatus(),
        SizedBox(width: 10.0),
        _labelStatus(),
      ],
    );
  }

  Widget _labelStatus() {
    const style = TextStyle(
      color: kMainColor,
      fontSize: 17.0,
    );
    switch (status) {
      case StatusPaymanent.CHECKING:
        return Text(
          "En espera",
          style: style,
        );
      case StatusPaymanent.NOT_PAYED:
        return Text(
          "No pagado",
          style: style,
        );
      case StatusPaymanent.PAYED:
        return Text(
          "Pagado",
          style: style,
        );
      default:
        return Text("");
    }
  }

  Widget _titleCard() {
    return Container(
        child: Text(
      "Mes actual",
      style: TextStyle(
        color: kMainColor.withOpacity(0.45),
        fontSize: 20.0,
      ),
    ));
  }

  Widget _currentMonthLabel() {
    return Text(
      "${getCurrentMonth()} ${getCurrentYear()}",
      style: TextStyle(
        fontSize: 30,
        fontWeight: FontWeight.w600,
        color: kMainColor,
        letterSpacing: 1.3,
      ),
    );
  }

  Widget _cardStatusContainer() {
    return Container(
      height: 60.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        color: _getBackgroundColorByStatus(),
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
        color: _getBackgroundColorByStatus(),
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

  Color _getBackgroundColorByStatus() {
    switch (status) {
      case StatusPaymanent.CHECKING:
        return Colors.yellow;
      case StatusPaymanent.NOT_PAYED:
        return Colors.red.shade400;
      case StatusPaymanent.PAYED:
        return Colors.green;
    }
    return Colors.white;
  }
}

import 'package:flutter/material.dart';
import 'package:pagos_internet/const/conts.dart';
import 'package:pagos_internet/helpers/months.dart';
import 'package:pagos_internet/models/comprobante_model.dart';


class ComprobanteDetailScreen extends StatefulWidget {
  final Comprobante comprobante;

  ComprobanteDetailScreen({this.comprobante});

  @override
  _ComprobanteDetailScreenState createState() => _ComprobanteDetailScreenState();
}

class _ComprobanteDetailScreenState extends State<ComprobanteDetailScreen> {
  @override
  Widget build(BuildContext context) {
    String monthName = getMonthName(widget.comprobante.mes);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kSecondaryColor,
        title: Text("$monthName ${widget.comprobante.anio}"),
      ),
    );
  }
}
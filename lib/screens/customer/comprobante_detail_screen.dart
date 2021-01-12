import 'package:flutter/material.dart';
import 'package:pagos_internet/const/conts.dart';
import 'package:pagos_internet/helpers/date.dart';
import 'package:pagos_internet/helpers/months.dart';
import 'package:pagos_internet/models/comprobante_model.dart';
import 'package:pagos_internet/models/fecha_model.dart';

class ComprobanteDetailScreen extends StatefulWidget {
  final Comprobante comprobante;

  ComprobanteDetailScreen({this.comprobante});

  @override
  _ComprobanteDetailScreenState createState() =>
      _ComprobanteDetailScreenState();
}

class _ComprobanteDetailScreenState extends State<ComprobanteDetailScreen> {
  @override
  Widget build(BuildContext context) {
    String monthName = getMonthName(widget.comprobante.mes);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kSecondaryColor,
        title: Text(widget.comprobante.proveedor),
      ),
      body: _body(),
    );
  }

  Widget _body() {
    return Container(
      padding: EdgeInsets.all(15.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _provider(),
          SizedBox(height: 10.0),
          _createtAt(),
          SizedBox(height: 20.0),
          _image(),
        ],
      ),
    );
  }

  Widget _provider() {
    return Text(
      "${getMonthName(widget.comprobante.mes)} ${widget.comprobante.anio}",
      style: TextStyle(
        color: kMainColor.withOpacity(0.5),
        fontSize: 30.0,
      ),
    );
  }

  Widget _createtAt() {
    Fecha fecha = formatDate(widget.comprobante.fecha);
    return Text(
      "Enviado el: $fecha",
      style: TextStyle(
        color: kMainColor.withOpacity(0.7),
      ),
    );
  }

  Widget _image() {
    return Container(
      /* padding: EdgeInsets.all(20.0), */
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(120.0),
      ),
      child: FadeInImage.assetNetwork(
          placeholder: "assets/loader.gif", image: widget.comprobante.foto),
    );
  }
}

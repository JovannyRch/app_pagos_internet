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
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _provider(),
            SizedBox(height: 10.0),
            _createtAt(),
            SizedBox(height: 15.0),
            _rowInfoStatus(),
            SizedBox(height: 20.0),
            _image(),
          ],
        ),
      ),
    );
  }

  Widget _provider() {
    return Text(
      "${getMonthName(widget.comprobante.mes)} ${widget.comprobante.anio}",
      style: TextStyle(
        color: kMainColor.withOpacity(0.9),
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
    switch (widget.comprobante.status) {
      case "enRevision":
        return Text(
          "En revisión",
          style: style,
        );
      case "noPagado":
        return Text(
          "No pagado",
          style: style,
        );
      case "pagado":
        return Text(
          "Pagado",
          style: style,
        );
      default:
        return Text("");
    }
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
        color: getBackgroundColorByStatus(widget.comprobante.status),
      ),
    );
  }
}

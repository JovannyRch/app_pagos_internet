import 'package:flutter/material.dart';
import 'package:pagos_internet/const/conts.dart';
import 'package:pagos_internet/helpers/date.dart';
import 'package:pagos_internet/helpers/months.dart';
import 'package:pagos_internet/models/comprobante_model.dart';
import 'package:pagos_internet/models/fecha_model.dart';
import 'package:pinch_zoom/pinch_zoom.dart';

class ComprobanteDetailScreen extends StatefulWidget {
  final Comprobante comprobante;
  final bool isAdmin;

  ComprobanteDetailScreen({this.comprobante, this.isAdmin = false});

  @override
  _ComprobanteDetailScreenState createState() =>
      _ComprobanteDetailScreenState();
}

class _ComprobanteDetailScreenState extends State<ComprobanteDetailScreen> {
  bool isAproving = false;
  Size _size;
  void setIsAproving(bool val) {
    setState(() {
      isAproving = val;
    });
  }

  @override
  Widget build(BuildContext context) {
    _size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kSecondaryColor,
        title: Text(widget.comprobante.proveedor),
      ),
      body: _body(),
      floatingActionButton: _floatingActionButton(),
    );
  }

  Widget _floatingActionButton(){
    if(!this.widget.isAdmin){
      return null; 
    }
    return widget.comprobante.status == EN_REVISION
          ? isAproving
              ? null
              : FloatingActionButton(
                  onPressed: handleAprobarComprobante,
                  backgroundColor: Colors.green,
                  child: Icon(Icons.check),
                )
          : null;
  }


  void handleAprobarComprobante() async {
    setIsAproving(true);
    await this.widget.comprobante.aprobar();
    setIsAproving(false);
  }

  Widget _body() {
    if (isAproving) {
      return _waiting();
    }

    return Container(
      padding: EdgeInsets.all(15.0),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _paymentDate(),
            widget.isAdmin ? _username() : Container(),
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

  Widget _waiting() {
    return Center(
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 20.0),
            Text(
              "Aprobando comprobante",
              style: TextStyle(
                color: kMainColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _username() {
    return Container(
      margin: EdgeInsets.only(bottom: 10.0, top: 5.0),
      child: Text(
        "${widget.comprobante.username}",
        style: TextStyle(
          color: kMainColor,
          fontSize: 17.0,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _paymentDate() {
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
      "Enviado el $fecha",
      style: TextStyle(
        color: kMainColor.withOpacity(0.7),
      ),
    );
  }

  Widget _image() {
    if (widget.comprobante.foto == null) return _emptyPhoto();
    return Container(
      height: _size.height*0.5,
      width: double.infinity,
      child: PinchZoom(
        image: FadeInImage.assetNetwork(
            placeholder: "assets/loader.gif", image: widget.comprobante.foto),
        zoomedBackgroundColor: Colors.black.withOpacity(0.5),
        resetDuration: const Duration(milliseconds: 100),
        maxScale: 2.5,
      ),
    );
  }

  Widget _emptyPhoto() {
    return Container(
      child: Text("Sin foto"),
    );
  }

  Widget _rowInfoStatus() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _currentMonthStatus(),
        SizedBox(width: 10.0),
        Center(child: _labelStatus()),
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
      width: 15,
      height: 15,
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

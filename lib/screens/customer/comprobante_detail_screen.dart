
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:loading_button/loading_button.dart';
import 'package:pagos_internet/const/conts.dart';
import 'package:pagos_internet/helpers/alerts.dart';
import 'package:pagos_internet/helpers/date.dart';
import 'package:pagos_internet/models/comprobante_model.dart';
import 'package:pagos_internet/models/fecha_model.dart';
import 'package:pagos_internet/widget/CardComprobanteStatus.dart';
import 'package:pagos_internet/widget/CardDataContainer.dart';
import 'package:pagos_internet/widget/CardTitle.dart';
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

  Widget _floatingActionButton() {
    if (this.widget.isAdmin) {
      return null;
    }
    return widget.comprobante.status == EN_REVISION
        ? isAproving
            ? null
            : FloatingActionButton.extended(
                onPressed: handleAprobarComprobante,
                backgroundColor: Colors.green,
                icon: Icon(Icons.check),
                label: Text("Aprobar"),
              )
        : null;
  }

  void handleAprobarComprobante() async {
    // set up the buttons
    Widget cancelButton = FlatButton(
      child: Text("Cancelar"),
      onPressed: () {
        Navigator.of(context).pop(); 
      },
    );
    Widget continueButton = FlatButton(
      child: Text("Aprobar"),
      onPressed: () {
        Navigator.of(context).pop(); 
        aprobarComprobante();
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Confirmación"),
      content: Text(
          "¿Estás seguro de aprobar el comprobante?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  void aprobarComprobante() async {
    setIsAproving(true);
    await this.widget.comprobante.aprobar();
    setIsAproving(false);
    await success(context, "Comprobante aprobado", "El comprobante se ha aprobado con éxito");
  }

  Widget _body() {
    if (isAproving) {
      return _waiting();
    }

    return Container(
      padding: EdgeInsets.all(15.0),
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            widget.isAdmin
                ? CardDataContainer(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CardTitle(title: "Cliente"),
                        _username(),
                      ],
                    ),
                  )
                : Container(),
            CardDataContainer(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CardTitle(title: "Status"),
                  CardComprobanteStatus(
                    year: widget.comprobante.anio,
                    month: widget.comprobante.mes,
                    status: widget.comprobante.status,
                  )
                ],
              ),
            ),
            CardDataContainer(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CardTitle(title: "Foto del comprobante"),
                  _adminActions(),
                  SizedBox(height: 10.0),
                  _image(),
                  _createdAt(),
                ],
              ),
            ),
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

  Widget _createdAt() {
    if (isEmptyPhoto()) return Container();

    Fecha fecha = formatDate(widget.comprobante.fecha);
    return Container(
      margin: EdgeInsets.only(top: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            "Enviado el $fecha",
            style: TextStyle(
              color: kMainColor,
              fontSize: 10.0,
            ),
          )
        ],
      ),
    );
  }

  Widget _image() {
    if ((widget.comprobante.foto == null) || widget.comprobante.foto.isEmpty)
      return _emptyPhoto();
    return Container(
      height: _size.height * 0.5,
      width: double.infinity,
      /*  decoration: BoxDecoration(border: Border.all(color: Colors.red)), */
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
      height: 150.0,
      child: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FaIcon(
            FontAwesomeIcons.image,
            color: kMainColor.withOpacity(0.7),
          ),
          SizedBox(height: 20.0),
          Text(
            "Sin foto",
            style: TextStyle(
              color: kMainColor.withOpacity(0.7),
              fontSize: 17.0,
              letterSpacing: 1.2,
            ),
          )
        ],
      )),
    );
  }

  bool isEmptyPhoto() {
    return (widget.comprobante.foto == null) || widget.comprobante.foto.isEmpty;
  }

  bool isNotAdmin() {
    return !widget.isAdmin;
  }

  bool isNotEnChecking() {
    return widget.comprobante.status != EN_REVISION;
  }

  Widget _adminActions() {
    if (isNotAdmin() || isNotEnChecking() || isEmptyPhoto()) return Container();

    if (isAproving) {
      return Text("Aprobando");
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        LoadingButton(
          backgroundColor: Colors.green,
          isLoading: isAproving,
          onPressed: handleAprobarComprobante,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.check, color: Colors.white, size: 18.0),
              SizedBox(width: 10.0),
              Text(
                "Aprobar",
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
        )
      ],
    );
  }
}

/*

    /* Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CardTitle(title: "Detalles del comprobante"),
                  ,
            /* widget.isAdmin ? _username() : Container(),
            SizedBox(height: 10.0),
            _createdAt(),
            SizedBox(height: 15.0),
            _rowInfoStatus(),
            SizedBox(height: 20.0),
            _image(), */
                ],
              ) */

*/

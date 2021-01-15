import 'package:flutter/material.dart';
import 'package:flutter_open_whatsapp/flutter_open_whatsapp.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pagos_internet/const/conts.dart';
import 'package:pagos_internet/helpers/months.dart';
import 'package:pagos_internet/models/comprobante_model.dart';
import 'package:pagos_internet/models/user_model.dart';
import 'package:pagos_internet/screens/customer/comprobante_detail_screen.dart';
import 'package:pagos_internet/widget/CardTitle.dart';
import 'package:pagos_internet/widget/LastPayment.dart';
import 'package:url_launcher/url_launcher.dart';

class ClienteScreenDetail extends StatefulWidget {
  final Usuario cliente;
  ClienteScreenDetail({@required this.cliente});

  @override
  _ClienteScreenDetailState createState() => _ClienteScreenDetailState();
}

class _ClienteScreenDetailState extends State<ClienteScreenDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kSecondaryColor,
        title: Text("Detalles del cliente"),
      ),
      body: _body(),
      floatingActionButton: FloatingActionButton(
        onPressed: handleHistoryPayment,
        backgroundColor: kSecondaryColor,
        child: FaIcon(FontAwesomeIcons.tasks),
      ),
    );
  }

  void handleHistoryPayment(){
   /*  Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ComprobanteDetailScreen(comprobante: ,),
      ),
    ); */
  }

  Widget _body() {
    return Container(
      padding: EdgeInsets.all(10.0),
      width: double.infinity,
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _username(),
            _cardInfo(),
            LastPaymentInfo(userId: widget.cliente.id),
          ],
        ),
      ),
    );
  }

  Widget _cardInfo() {
    return Container(
      height: 180.0,
      width: double.infinity,
      padding: EdgeInsets.all(15.0),
      margin: EdgeInsets.only(bottom: 25.0),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _cardTitle("Datos de contacto"),
          _tileInfoWithIcon(Icons.phone, "${widget.cliente.telefono}",
              action: _listAction()),
          _tileInfoWithIcon(Icons.email, "${widget.cliente.id}"),
          _tileInfoWithIcon(Icons.home, "${widget.cliente.domicilioCompleto}"),
        ],
      ),
    );
  }

  Widget _listAction() {
    return Row(
      children: [
        _callAction(),
        SizedBox(width: 10.0),
        _whatsAppAction(),
      ],
    );
  }

  Widget _callAction() {
    return RaisedButton(
      onPressed: handleLaunchCall,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18.0),
      ),
      color: Colors.green,
      child: FaIcon(
        FontAwesomeIcons.phone,
        size: 20.0,
        color: Colors.white,
      ),
    );
  }

  Widget _whatsAppAction() {
    return RaisedButton(
      onPressed: handleLauchWhatsApp,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18.0),
      ),
      color: kWhatsAppColor,
      child: FaIcon(
        FontAwesomeIcons.whatsapp,
        size: 20.0,
        color: Colors.white,
      ),
    );
  }

  void handleLauchWhatsApp() {
    FlutterOpenWhatsapp.sendSingleMessage(
        formatNumber(widget.cliente.telefono), "Hello");
  }

  void handleLaunchCall() async {
    String url = "tel:${widget.cliente.telefono}";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  String formatNumber(String number) {
    if (number.startsWith("52")) {
      return number;
    } else {
      return "52$number";
    }
  }

  Widget _username() {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(bottom: 10.0),
      padding: EdgeInsets.only(left: 5.0, bottom: 5.0, top: 10.0),
      child: Text(
        "${widget.cliente.username}",
        style: TextStyle(
          fontSize: 20.0,
          fontWeight: FontWeight.w700,
          letterSpacing: 1.3,
        ),
      ),
    );
  }

  Widget _cardTitle(String title) {
    return CardTitle(title: title);
  }

  Widget _tileInfoWithIcon(IconData icon, String value, {Widget action}) {
    return Container(
      height: 30.0,
      decoration: BoxDecoration(),
      margin: EdgeInsets.only(top: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(icon, color: kSecondaryColor.withOpacity(0.8)),
          SizedBox(
            width: 15.0,
          ),
          Expanded(
            child: Text(
              "$value",
              style: TextStyle(
                fontWeight: FontWeight.w400,
                letterSpacing: 1,
                fontSize: 13.0,
              ),
            ),
          ),
          action ?? Container(),
        ],
      ),
    );
  }
}

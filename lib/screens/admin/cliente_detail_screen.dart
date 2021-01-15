import 'package:flutter/material.dart';
import 'package:pagos_internet/const/conts.dart';
import 'package:pagos_internet/models/user_model.dart';

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
    );
  }

  Widget _body() {
    return Container(
      padding: EdgeInsets.all(10.0),
      width: double.infinity,
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            _cardInfo(),
          ],
        ),
      ),
    );
  }

  Widget _cardInfo() {
    return Container(
      height: 300.0,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "${widget.cliente.username}",
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

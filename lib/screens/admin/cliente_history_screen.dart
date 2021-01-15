import 'package:flutter/material.dart';
import 'package:pagos_internet/const/conts.dart';
import 'package:pagos_internet/models/user_model.dart';
import 'package:pagos_internet/widget/ComprobantesList.dart';

class ClienteHistoryScreen extends StatefulWidget {
  final Usuario cliente;
  ClienteHistoryScreen({@required this.cliente});

  @override
  _ClienteHistoryScreenState createState() => _ClienteHistoryScreenState();
}

class _ClienteHistoryScreenState extends State<ClienteHistoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kSecondaryColor,
        title: Text(
          "Historial",
          overflow: TextOverflow.ellipsis,
        ),
      ),
      body: _body(),
    );
  }

  Widget _body(){
    return ComprobanteList(user: widget.cliente.id,);
  }
}

import 'package:flutter/material.dart';
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
      body: _body(),
    );
  }

  Widget _body(){
    return Center(child: Text("User detail screen"),);
  }
}
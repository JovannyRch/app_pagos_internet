import 'package:flutter/material.dart';
import 'package:pagos_internet/models/comprobante_model.dart';
import 'package:pagos_internet/widget/ComprobanteTile.dart';
import 'package:pagos_internet/widget/EmtpyData.dart';

class ComprobanteList extends StatefulWidget {
  final String type;
  final String user;

  ComprobanteList({this.type = "", this.user = ""});

  @override
  _ComprobanteListState createState() => _ComprobanteListState();
}

class _ComprobanteListState extends State<ComprobanteList> {
  List<Comprobante> comprobantes = [];
  bool isFetchingData = true;

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  void setIsFetchingData(bool val) {
    setState(() {
      isFetchingData = val;
    });
  }

  void fetchData() async {
    setIsFetchingData(true);
    if(this.widget.type.isNotEmpty){
      this.comprobantes = await Comprobante.getByStatus(widget.type);
    }else if(this.widget.user.isNotEmpty){
      this.comprobantes = await Comprobante.getByUser(widget.user);
    }
    setIsFetchingData(false);
  }

  @override
  Widget build(BuildContext context) {
    return _body();
  }

  Widget _body() {
    return isFetchingData ? _loading() : _columnData();
  }

  Widget _loading() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _columnData() {
    if (comprobantes.length == 0) {
      return EmtpyData();
    }

    return Container(
      width: double.infinity,
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            ...comprobantes
                .map((e) => ComprobanteTile(
                      comprobante: e,
                      isAdmin: true,
                    ))
                .toList()
          ],
        ),
      ),
    );
  }


}

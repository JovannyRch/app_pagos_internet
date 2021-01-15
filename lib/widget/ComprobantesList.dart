import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pagos_internet/const/conts.dart';
import 'package:pagos_internet/models/comprobante_model.dart';
import 'package:pagos_internet/widget/ComprobanteTile.dart';
import 'package:pagos_internet/widget/EmtpyData.dart';

class ComprobanteList extends StatefulWidget {
  final String type;

  ComprobanteList({@required this.type});

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
    this.comprobantes = await Comprobante.getByStatus(widget.type);
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

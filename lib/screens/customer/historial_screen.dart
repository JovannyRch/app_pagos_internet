import 'package:flutter/material.dart';
import 'package:pagos_internet/const/conts.dart';
import 'package:pagos_internet/helpers/months.dart';
import 'package:pagos_internet/models/comprobante_model.dart';
import 'package:pagos_internet/screens/customer/comprobante_detail_screen.dart';

class HistorialScreen extends StatefulWidget {
  HistorialScreen({Key key}) : super(key: key);

  @override
  _HistorialScreenState createState() => _HistorialScreenState();
}

class _HistorialScreenState extends State<HistorialScreen> {
  List<Comprobante> comprobantes = [];
  bool isFetchingData = false;
  bool isErrorFecthingData = false;

  @override
  void initState() {
    super.initState();
    this.fetchData();
  }

  void setIsFetchingData(bool val) {
    setState(() {
      isFetchingData = val;
    });
  }

  void setIsErrorFetchingData(bool val) {
    setState(() {
      isErrorFecthingData = val;
    });
  }

  void fetchData() async {
    setIsFetchingData(true);
    try {
      this.comprobantes = await Comprobante.getByUser();
    } catch (e) {
      setIsErrorFetchingData(true);
      print("Ocurrio un error al obtener los comprobantes del usurio");
      print(e.toString());
      this.comprobantes = [];
    } finally {
      setIsFetchingData(false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 25.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(height: 30.0),
          Text(
            "Historial de pagos",
            style: TextStyle(
              color: kMainColor.withOpacity(0.6),
            ),
          ),
          SizedBox(height: 30.0),
          SingleChildScrollView(
            child: renderDataOrLoading(),
          )
        ],
      ),
    );
  }

  Widget renderDataOrLoading() {
    if (isFetchingData) {
      return Center(child: CircularProgressIndicator());
    } else {
      return comprobantes.length == 0 ? _emptyData() : _data();
    }
  }

  Widget _emptyData() {
    return Container();
  }

  Widget _data() {
    return Column(children: [
      ...comprobantes.map((e) => _comprobanteWidget(e)).toList(),
    ]);
  }

  Widget _comprobanteWidget(Comprobante comprobante) {
    String monthName = getMonthName(comprobante.mes);
    return ListTile(
      onTap: () {
        handleClickDetailComprobante(comprobante);
      },
      title: Row(
        children: [
          Text("$monthName ${comprobante.anio}"),
          SizedBox(width: 10.0),
          Container(
            height: 10,
            width: 10,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: _getBackgroundColorByStatus(comprobante.status),
            ),
          ),
        ],
      ),
      trailing: Icon(
        Icons.arrow_forward_ios,
        color: Colors.grey.shade300,
      ),
    );
  }

  void handleClickDetailComprobante(Comprobante comprobante) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) =>
              ComprobanteDetailScreen(comprobante: comprobante)),
    );
  }

  Color _getBackgroundColorByStatus(String status) {
    switch (status) {
      case "enRevision":
        return Colors.yellow;
      case "noPagado":
        return Colors.red.shade400;
      case "pagado":
        return Colors.transparent;
    }
    return Colors.transparent;
  }
}

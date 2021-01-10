import 'package:flutter/material.dart';
import 'package:pagos_internet/const/conts.dart';
import 'package:pagos_internet/helpers/months.dart';
import 'package:pagos_internet/models/comprobante_model.dart';
import 'package:pagos_internet/screens/customer/comprobante_detail_screen.dart';
import 'package:pagos_internet/screens/customer/pago_screen.dart';

class HistorialScreen extends StatefulWidget {
  HistorialScreen({Key key}) : super(key: key);

  @override
  _HistorialScreenState createState() => _HistorialScreenState();
}

class _HistorialScreenState extends State<HistorialScreen> {
  List<Comprobante> comprobantes = [
    new Comprobante(
        id: "1",
        username: "Miriam Ramírez García",
        mes: 12,
        anio: 2020,
        foto: "",
        fecha: "",
        status: StatusComprobante.pagado,
        proveedor: "Googinet"),
    new Comprobante(
        id: "1",
        username: "Miriam Ramírez García",
        mes: 11,
        anio: 2020,
        foto: "",
        fecha: "",
        status: StatusComprobante.noPagado,
        proveedor: "Googinet"),
    new Comprobante(
        id: "1",
        username: "Miriam Ramírez García",
        mes: 10,
        anio: 2020,
        foto: "",
        fecha: "",
        status: StatusComprobante.enRevision,
        proveedor: "Googinet"),
  ];

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
            child: Column(
              children: [
                ...comprobantes.map((e) => _comprobanteWidget(e)).toList(),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _comprobanteWidget(Comprobante comprobante) {
    String monthName = getMonthName(comprobante.mes);
    return GestureDetector(
      onTap: () {
        handleClickDetailComprobante(comprobante);
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 10.0),
        height: 40.0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
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
                Icon(
                  Icons.arrow_forward,
                  color: Colors.grey.shade300,
                ),
              ],
            ),
            Divider(),
          ],
        ),
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

import 'package:flutter/material.dart';
import 'package:pagos_internet/const/conts.dart';
import 'package:pagos_internet/helpers/months.dart';
import 'package:pagos_internet/models/comprobante_model.dart';
import 'package:pagos_internet/screens/customer/comprobante_detail_screen.dart';

class ComprobanteTile extends StatelessWidget {
  final Comprobante comprobante;
  final bool isAdmin;
  ComprobanteTile({@required this.comprobante, this.isAdmin = false});

  @override
  Widget build(BuildContext context) {
    String monthName = getMonthName(comprobante.mes);
    return ListTile(
      onTap: () {
        handleClickDetailComprobante(context, comprobante);
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
              color: getBackgroundColorByStatus(comprobante.status),
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

  void handleClickDetailComprobante(
      BuildContext context, Comprobante comprobante) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ComprobanteDetailScreen(comprobante: comprobante, isAdmin: isAdmin),
      ),
    );
  }
}

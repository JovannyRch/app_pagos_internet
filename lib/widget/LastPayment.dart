import 'package:flutter/material.dart';
import 'package:pagos_internet/models/comprobante_model.dart';
import 'package:pagos_internet/screens/customer/comprobante_detail_screen.dart';
import 'package:pagos_internet/widget/CardComprobanteStatus.dart';
import 'package:pagos_internet/widget/CardTitle.dart';

class LastPaymentInfo extends StatefulWidget {
  final String userId;
  LastPaymentInfo({@required this.userId});

  @override
  _LastPaymentInfoState createState() => _LastPaymentInfoState();
}

class _LastPaymentInfoState extends State<LastPaymentInfo> {
  bool isFetchingCurrentMonthPayment = false;
  Comprobante currentMonthPayment  = new Comprobante();

  @override
  void initState() {
    this.currentMonthPayment.status = "";
    this.currentMonthPayment.mes = 1;
    this.currentMonthPayment.anio= 1;
    this.fetchCurrentMonthPayment();
    super.initState();
  }

  void fetchCurrentMonthPayment() async {
    setIsFetchingCurrentMonthPayment(true);
    currentMonthPayment =
        await Comprobante.getCurrentMonthByUser(widget.userId);
    setIsFetchingCurrentMonthPayment(false);
  }

  void setIsFetchingCurrentMonthPayment(bool val) {
    setState(() {
      isFetchingCurrentMonthPayment = val;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: handleComprobanteDetails,
      child: Container(
        height: 160.0,
        width: double.infinity,
        padding: EdgeInsets.all(15.0),
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CardTitle(title: "Pago mes actual"),
            _lastPaymentInfo(),
          ],
        ),
      ),
    );
  }

  Widget _lastPaymentInfo() {
    return CardComprobanteStatus(
      year: currentMonthPayment.anio,
      month: currentMonthPayment.mes,
      status: currentMonthPayment.status,
      withLink: true,
      isLoading: isFetchingCurrentMonthPayment,
    );
  }

  void handleComprobanteDetails() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ComprobanteDetailScreen(
          comprobante: currentMonthPayment,
          isAdmin: true,
        ),
      ),
    );
  }
}

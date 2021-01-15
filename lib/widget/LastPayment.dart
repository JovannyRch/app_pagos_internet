import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pagos_internet/const/conts.dart';
import 'package:pagos_internet/helpers/months.dart';
import 'package:pagos_internet/models/comprobante_model.dart';
import 'package:pagos_internet/screens/customer/comprobante_detail_screen.dart';
import 'package:pagos_internet/widget/CardTitle.dart';

class LastPaymentInfo extends StatefulWidget {
  final String userId;
  LastPaymentInfo({@required this.userId});

  @override
  _LastPaymentInfoState createState() => _LastPaymentInfoState();
}

class _LastPaymentInfoState extends State<LastPaymentInfo> {
  bool isFetchingCurrentMonthPayment = false;
  Comprobante currentMonthPayment;

  @override
  void initState() {
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
    return Stack(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _dateInfo(),
            _lineDivider(),
            _status(),
          ],
        ),
        Positioned(
          child: _linkButton(),
          right: 0.0,
          top: 25.0,
        ),
      ],
    );
  }

  Widget _linkButton() {
    final icon = FaIcon(
      FontAwesomeIcons.chevronRight,
      color: kMainColor.withOpacity(0.6),
    );
    return icon;
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

  Widget _lineDivider() {
    return Container(
      height: 100.0,
      width: 1.0,
      color: Colors.grey.shade300,
    );
  }

  Widget _dateInfo() {
    return Column(
      children: [
        Text(
          "${getCurrentMonth()}",
          style: TextStyle(
            fontSize: 22.0,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 10.0),
        Text(
          "${getCurrentYear()}",
          style: TextStyle(
            fontSize: 25.0,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }

  Widget _status() {
    if (isFetchingCurrentMonthPayment) {
      return Center(child: CircularProgressIndicator());
    }
    String statusFormatted = getTextByStatus(currentMonthPayment.status);
    return Column(
      children: [
        _circleIndicator(),
        SizedBox(height: 10.0),
        Text("$statusFormatted"),
      ],
    );
  }

  Widget _circleIndicator() {
    Color color = getBackgroundColorByStatus(currentMonthPayment.status);
    return Container(
      height: 20,
      width: 20,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
        boxShadow: [
          new BoxShadow(
            offset: Offset(1, 1),
            color: Colors.grey.shade300,
          )
        ],
      ),
    );
  }
}

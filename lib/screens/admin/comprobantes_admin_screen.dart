import 'package:flutter/material.dart';
import 'package:pagos_internet/const/conts.dart';
import 'package:pagos_internet/widget/ComprobantesList.dart';


class ComprobantesAdminScreen extends StatefulWidget {
  ComprobantesAdminScreen({Key key}) : super(key: key);

  @override
  _ComprobantesAdminScreenState createState() => _ComprobantesAdminScreenState();
}

class _ComprobantesAdminScreenState extends State<ComprobantesAdminScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.grey.shade100,
          bottom: TabBar(
            labelColor: kSecondaryColor,
            indicatorColor: kSecondaryColor,
            unselectedLabelColor: kMainColor,
            labelStyle: TextStyle(fontSize: 11.0, fontWeight: FontWeight.w700),
            tabs: [
              Tab(text: "En revisión"),
              Tab(text: "No pagados"),
              Tab(text: "Pagados"),
            ],
          ),
          toolbarHeight: 50.0,
          elevation: 0,
        ),
        body: TabBarView(
          children: [
            ComprobanteList(type: EN_REVISION),
            ComprobanteList(type: NO_PAGADO),
            ComprobanteList(type: PAGADO),
          ],
        ),
      ),
    );
  }
}
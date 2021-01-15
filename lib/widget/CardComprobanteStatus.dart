import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pagos_internet/const/conts.dart';
import 'package:pagos_internet/helpers/months.dart';

class CardComprobanteStatus extends StatelessWidget {
  final int year;
  final int month;
  final String status;
  final bool isLoading;
  final bool withLink;

  CardComprobanteStatus({
    @required this.year,
    @required this.month,
    @required this.status,
    this.isLoading = false,
    this.withLink = false,
  });

  @override
  Widget build(BuildContext context) {
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
        withLink
            ? Positioned(
                child: _linkButton(),
                right: 0.0,
                top: 25.0,
              )
            : Container(),
      ],
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

  Widget _lineDivider() {
    return Container(
      height: 100.0,
      width: 1.0,
      color: Colors.grey.shade300,
    );
  }

  Widget _status() {
    if (isLoading) {
      return Center(child: CircularProgressIndicator());
    }
    String statusFormatted = getTextByStatus(status);
    return Column(
      children: [
        _circleIndicator(),
        SizedBox(height: 10.0),
        Text("$statusFormatted"),
      ],
    );
  }

  Widget _circleIndicator() {
    Color color = getBackgroundColorByStatus(status);
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

  Widget _linkButton() {
    final icon = FaIcon(
      FontAwesomeIcons.chevronRight,
      color: kMainColor.withOpacity(0.6),
    );
    return icon;
  }
}

import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io';

import 'package:flutter/material.dart';

Future success(
  BuildContext context,
  String title,
  String message, {
  Function f = null,
}) {
  return CoolAlert.show(
    context: context,
    type: CoolAlertType.success,
    title: title,
    text: message,
    onConfirmBtnTap: f,
  );
}

Future error(BuildContext context, String title, String message) {
  return CoolAlert.show(
    context: context,
    type: CoolAlertType.error,
    title: title,
    text: message,
  );
}

showAlert(BuildContext context, String title, String subtitle) {
  if (Platform.isAndroid) {
    return showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(title),
        content: Text(subtitle),
        actions: <Widget>[
          MaterialButton(
              child: Text('Ok'),
              elevation: 5,
              textColor: Colors.blue,
              onPressed: () => Navigator.pop(context))
        ],
      ),
    );
  }

  showCupertinoDialog(
      context: context,
      builder: (_) => CupertinoAlertDialog(
            title: Text(title),
            content: Text(subtitle),
            actions: <Widget>[
              CupertinoDialogAction(
                isDefaultAction: true,
                child: Text('Ok'),
                onPressed: () => Navigator.pop(context),
              )
            ],
          ));
}


void showSnackBarMessage(String msg, GlobalKey<ScaffoldState> key) {
  SnackBar snackBar = new SnackBar(content: new Text(msg));
  key.currentState.showSnackBar(snackBar);
}
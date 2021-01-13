import 'package:flutter/material.dart';

const kMainColor =  Color(0xFF504F60);

const kSecondaryColor =  Color(0xFF6C63FF);

const CAMERA = 1;
const GALLERY = 2;


 Color getBackgroundColorByStatus(String status) {
    switch (status) {
      case "enRevision":
        return Colors.yellow;
      case "noPagado":
        return Colors.red.shade400;
      case "pagado":
        return Colors.green;
    }
    return Colors.white;
  }


const NO_PAGADO = "noPagado";
const EN_REVISION = "enRevision";
const PAGADO = "pagado";


const EMAIL_GOOGINET = "googinet@admin.com";
const EMAIL_INTERVALA = "intervala@admin.com";


const List<String> ADMIN_USERS = [
    EMAIL_GOOGINET,
    EMAIL_INTERVALA,
  ];
   
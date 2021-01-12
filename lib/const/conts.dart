import 'package:flutter/material.dart';
import 'package:pagos_internet/models/comprobante_model.dart';

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
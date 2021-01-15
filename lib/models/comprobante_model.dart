import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pagos_internet/const/conts.dart';
import 'package:pagos_internet/services/api_service.dart';
import 'package:pagos_internet/shared/user_preferences.dart';

class StatusComprobante {
  static String pagado = "pagado";
  static String noPagado = "noPagado";
  static String enRevision = "enRevision";
}

List<Comprobante> ratingFromJson(String str) => List<Comprobante>.from(
    json.decode(str).map((x) => Comprobante.fromJson(x)));

String ratingToJson(List<Comprobante> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Comprobante {
  static Api api = new Api("comprobantes");
  static UserPrefences _preferences = new UserPrefences();

  String id;
  String username;
  String userId;
  int mes;
  int anio;
  String foto;
  String fecha;
  String status;
  String proveedor;

  Comprobante({
    this.id,
    this.username,
    this.userId,
    this.mes,
    this.anio,
    this.foto,
    this.fecha,
    this.proveedor,
    this.status = "noPagado",
  });

  factory Comprobante.fromJson(Map<String, dynamic> json) => Comprobante(
        id: json["id"],
        username: json["username"],
        userId: json["userId"],
        mes: json["mes"],
        anio: json["anio"],
        foto: json["foto"],
        fecha: json["fecha"],
        status: json["status"],
        proveedor: json["proveedor"],
      );

  factory Comprobante.fromMap(Map<String, dynamic> json, String id) =>
      Comprobante(
        id: id,
        username: json["username"],
        userId: json["userId"],
        mes: json["mes"],
        anio: json["anio"],
        foto: json["foto"],
        fecha: json["fecha"],
        status: json["status"],
        proveedor: json["proveedor"],
      );

  Map<String, dynamic> toJson() => {
        /*  "id": id, */
        "username": username,
        "userId": userId,
        "mes": mes,
        "anio": anio,
        "foto": foto,
        "fecha": fecha,
        "status": status,
        "proveedor": proveedor,
      };

  Future<DocumentReference> save() async {
    return await api.addDocument(this.toJson());
  }

  Future aprobar() async {
    this.status = PAGADO;
    var data = {
      'status': PAGADO,
    };
    await api.updateDocument(this.id, data);
  }

  static Future<List<Comprobante>> getByCurrentUser() async {
    return getByUser(_preferences.email);
  }

  static Future<List<Comprobante>> getByUser(String userId) async {
    final resp = await api.getWhere('userId',userId);
    return resp.docs
        .map((doc) => Comprobante.fromMap(doc.data(), doc.id))
        .toList();
  }

  static Future<Comprobante> getCurrentMonthByCurrentUser() async {
    return getCurrentMonthByUser(_preferences.email);
  }

  static Future<Comprobante> getCurrentMonthByUser(
      String userId) async {
    var now = DateTime.now();
    final resp = await api.getWheres({
      'userId': userId,
      'mes': now.month,
      'anio': now.year,
    });

    if (resp.docs.length == 0) {
      Comprobante comprobanteMesActual = new Comprobante();
      comprobanteMesActual.proveedor = _preferences.provider;
      comprobanteMesActual.status = "noPagado";
      comprobanteMesActual.mes = now.month;
      comprobanteMesActual.anio = now.year;
      await comprobanteMesActual.save();
      return comprobanteMesActual;
    } else {
      return resp.docs
          .map((doc) => Comprobante.fromMap(doc.data(), doc.id))
          .toList()
          .first;
    }
  }

  static Future<List<Comprobante>> getByStatus(String status) async {
    final resp = await api.getWhere('status', status);
    return resp.docs
        .map((doc) => Comprobante.fromMap(doc.data(), doc.id))
        .toList();
  }
}

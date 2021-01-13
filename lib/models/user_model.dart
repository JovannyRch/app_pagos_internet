import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pagos_internet/services/api_service.dart';
import 'dart:convert';

List<Usuario> ratingFromJson(String str) =>
    List<Usuario>.from(json.decode(str).map((x) => Usuario.fromJson(x)));

String ratingToJson(List<Usuario> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Usuario {
  String id;
  String domicilioCompleto;
  String proveedor;
  String telefono;
  String username;

  static Api api = new Api("usuarios");

  Usuario(
      {this.id,
      this.domicilioCompleto,
      this.proveedor,
      this.telefono,
      this.username});

  factory Usuario.fromJson(Map<String, dynamic> json) => Usuario(
        id: json["id"],
        domicilioCompleto: json["domicilioCompleto"],
        telefono: json["telefono"],
        proveedor: json["proveedor"],
        username: json["username"],
      );

  factory Usuario.fromMap(Map<String, dynamic> json, String id) => Usuario(
        id: id,
        domicilioCompleto: json["domicilioCompleto"],
        telefono: json["telefono"],
        proveedor: json["proveedor"],
        username: json["username"],
      );

  Map<String, dynamic> toJson() => {
        /*  "id": id, */
        "domicilioCompleto": domicilioCompleto,
        "telefono": telefono,
        "proveedor": proveedor,
        "username": username,
      };

  static Future<void> saveUser(Usuario user) async {
   return await api.setDocumentById(user.id, user.toJson());
  }

  static Future<Usuario> getById(String id) async {
    final resp = await api.getDocumentById(id);
    return Usuario.fromJson(resp.data());
  }
}

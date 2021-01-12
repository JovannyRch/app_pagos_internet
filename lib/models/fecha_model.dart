

class Fecha {
  String mes;
  String anio;
  String dia;

  Fecha({this.mes, this.anio, this.dia});

  @override
  String toString() {
    // TODO: implement toString
    return "$dia de $mes del $anio";
  }
}
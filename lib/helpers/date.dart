import 'package:pagos_internet/helpers/months.dart';
import 'package:pagos_internet/models/fecha_model.dart';

Fecha formatDate(String date) {
  try {
    List<String> fecha = date.split("T")[0].split("-");
    Fecha f = new Fecha(
        dia: fecha[2], anio: fecha[0], mes: getMonthName(int.parse(fecha[2])));
    return f;
  } catch (e) {
    return null;
  }
}

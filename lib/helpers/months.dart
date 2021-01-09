

String getMonthName(int month){
  switch (month) {
    case 1:
      return "Enero";
    case 2: 
      return "Febrero";
    case 3: 
      return "Marzo";
    case 4: 
      return "Abril";
    case 5: 
      return "Mayo";
    case 6: 
      return "Junio";
    case 7: 
      return "Julio";
    case 8: 
      return "Agosto";
    case 9: 
      return "Septiembre";
    case 10: 
      return "Octubre";
    case 11: 
      return "Noviembre";
    case 12: 
      return "Diciembre";
    default:
      return "Mes no encontrado";
  }
}


String getCurrentMonth(){
  var now = DateTime.now();
  return getMonthName(now.month);
}


int getCurrentYear(){
  return DateTime.now().year;
}
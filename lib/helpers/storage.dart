
import 'package:pagos_internet/models/user_model.dart';
import 'package:pagos_internet/shared/user_preferences.dart';

class Storage {

    static UserPrefences _userPrefences = new UserPrefences(); 

    static void saveUser(Usuario user){
      _userPrefences.email = user.id;
      _userPrefences.provider = user.proveedor;
      _userPrefences.username = user.username;
      _userPrefences.phone = user.telefono;
    }
}
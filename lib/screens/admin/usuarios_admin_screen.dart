
import 'package:flutter/material.dart';
import 'package:pagos_internet/helpers/storage.dart';
import 'package:pagos_internet/models/user_model.dart';
import 'package:pagos_internet/widget/EmtpyData.dart';

class UsuariosAdminScreen extends StatefulWidget {
  UsuariosAdminScreen({Key key}) : super(key: key);

  @override
  _UsuariosAdminScreenState createState() => _UsuariosAdminScreenState();
}

class _UsuariosAdminScreenState extends State<UsuariosAdminScreen> {
  List<Usuario> clientes = [];
  bool isFetchingUsers;
  Usuario currentUser = Storage.getCurrentUser();

  @override
  void initState() {
    this.fethcUsers();
    super.initState();
  }

  void fethcUsers() async {
    setIsFetchingUsers(true);
    clientes = await Usuario.getByProvider(currentUser.username);
    setIsFetchingUsers(false);
  }

  void setIsFetchingUsers(bool val) {
    setState(() {
      isFetchingUsers = val;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text("Usuario Screen"),
    );
  }


  Widget _loading(){
    return Container(
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  
  Widget _data(){
    return Container();
  }

  Widget _emptyData(){
    return EmtpyData();
  }

}



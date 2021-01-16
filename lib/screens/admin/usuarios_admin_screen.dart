import 'package:flutter/material.dart';
import 'package:pagos_internet/const/conts.dart';
import 'package:pagos_internet/helpers/storage.dart';
import 'package:pagos_internet/models/user_model.dart';
import 'package:pagos_internet/screens/admin/cliente_detail_screen.dart';
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
    return _body();
  }

  Widget _body() {
    if (isFetchingUsers) {
      return _loading();
    }
    return _data();
  }

  Widget _loading() {
    return Container(
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  Widget _data() {
    if (clientes.length == 0) {
      return _emptyData();
    }
    return Container(
      padding: EdgeInsets.all(10.0),
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            ...clientes.map((e) => _userCard(e)).toList(),
          ],
        ),
      ),
    );
  }

  Widget _userCard(Usuario cliente) {
    return ListTile(
      onTap: (){
        handleUserClick(cliente);
      },
      title: Text(
        "${cliente.username}",
        style: TextStyle(color: kMainColor),
      ),
      subtitle: Text("${cliente.id}"),
      trailing: Icon(Icons.arrow_forward_ios),
    );
  }

  void handleUserClick(Usuario cliente){
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ClienteScreenDetail(cliente: cliente))
    );
  }

  Widget _emptyData() {
    return EmtpyData();
  }
}

/*

Container(
      width: double.infinity,
      height: 50.0,
      decoration: BoxDecoration(
        border: Border(
            bottom: BorderSide(color: kMainColor.withOpacity(0.2), width: 1.0)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "${cliente.username}",
            style: TextStyle(
              color: kMainColor,
              fontSize: 18.0,
              fontWeight: FontWeight.w600,  
            ),
            overflow: TextOverflow.ellipsis,
            
          ),
          SizedBox(height: 5.0,),
          Text("${cliente.id}", style: TextStyle(),),
        ],
      ),
    );

*/

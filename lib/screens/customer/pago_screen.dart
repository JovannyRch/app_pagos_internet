import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loading_button/loading_button.dart';
import 'package:pagos_internet/const/conts.dart';
import 'package:pagos_internet/helpers/alerts.dart';
import 'package:pagos_internet/helpers/image.dart';
import 'package:pagos_internet/helpers/months.dart';
import 'package:pagos_internet/helpers/storage.dart';
import 'package:pagos_internet/models/comprobante_model.dart';
import 'package:pagos_internet/models/user_model.dart';
import 'package:pagos_internet/screens/customer/comprobante_detail_screen.dart';

import 'package:pagos_internet/widget/CardContainer.dart';

enum StatusPaymanent {
  PAYED,
  CHECKING,
  NOT_PAYED,
}

class PagoScreen extends StatefulWidget {
  PagoScreen({Key key}) : super(key: key);

  @override
  _PagoScreenState createState() => _PagoScreenState();
}

class _PagoScreenState extends State<PagoScreen> {
  StatusPaymanent status = StatusPaymanent.NOT_PAYED;
  Size _size;

  final picker = new ImagePicker();
  List<Comprobante> comprobantes = [];
  bool isUploadingPhoto = false;
  bool isUploadingComprobante = false;
  Comprobante comprobanteMesActual;
  bool isLoadingComprobanteActual = false;
  DateTime now = DateTime.now();
  Usuario currentUser = Storage.getCurrentUser();

  @override
  void initState() {
    fetchCurrentComprobante();
    super.initState();
  }

  void fetchCurrentComprobante() async {
    setIsLoadingComprobanteActual(true);
    List<Comprobante> comprobantes = await Comprobante.getCurrentMonthByUser();
    this.comprobanteMesActual =
        comprobantes.length > 0 ? comprobantes.first : null;
    if (comprobanteMesActual == null) {
      this.initComprobante();
    }
    setIsLoadingComprobanteActual(false);
  }

  void initComprobante() {
    comprobanteMesActual = new Comprobante();
    comprobanteMesActual.proveedor = this.currentUser.proveedor;
    comprobanteMesActual.status = "noPagado";
    comprobanteMesActual.mes = now.month;
    comprobanteMesActual.anio = now.year;
  }

  void setIseUploadingPhoto(bool val) {
    setState(() {
      isUploadingPhoto = val;
    });
  }

  void setIsUploadingComprobante(bool val) {
    setState(() {
      isUploadingComprobante = val;
    });
  }

  void setIsLoadingComprobanteActual(bool val) {
    setState(() {
      isLoadingComprobanteActual = val;
    });
  }

  @override
  Widget build(BuildContext context) {
    _size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.only(top: 20, left: 20, right: 20),
      width: double.infinity,
      child: _currentMonthCard(),
    );
  }

  Widget _currentMonthCard() {
    return CardContainer(
      width: double.infinity,
      height: _size.height * 0.30,
      padding: EdgeInsets.all(30),
      child: isLoadingComprobanteActual
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _titleCard(),
                SizedBox(height: 8.0),
                _currentMonthLabel(),
                SizedBox(height: 4.0),
                _rowInfoStatus(),
                SizedBox(height: 12.0),
                _actionButton(),
              ],
            ),
    );
  }

  Widget _actionButton() {
    if (comprobanteMesActual.status != "noPagado") {
      if (comprobanteMesActual.status == "enRevision") {
        return _moraRevisionDetails();
      }
      return Container();
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        LoadingButton(
          isLoading: isUploadingPhoto,
          onPressed: trySendComprobante,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
            color: kSecondaryColor,
          ),
          child: Row(
            children: [
              Text(
                "Enviar comprobante",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              SizedBox(width: 10),
              Icon(
                Icons.arrow_upward,
                color: Colors.white,
              )
            ],
          ),
        ),
      ],
    );
  }

  Widget _moraRevisionDetails() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        RaisedButton(
          onPressed: handleComprobanteDetails,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          color: kMainColor,
          child: Row(
            children: [
              Text(
                "Ver comprobante",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  void handleComprobanteDetails() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            ComprobanteDetailScreen(comprobante: comprobanteMesActual),
      ),
    );
  }

  void trySendComprobante() async {
    try {
      _selectSource();
    } catch (e) {
      showErrorMessage();
    }
  }

  void _selectSource() async {
    await showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Container(
            child: new Wrap(
              children: <Widget>[
                new ListTile(
                    leading: new Icon(Icons.camera),
                    title: new Text('Tomar foto'),
                    onTap: () {
                      Navigator.pop(context);
                      sendComprobante(CAMERA);
                    }),
                new ListTile(
                  leading: new FaIcon(FontAwesomeIcons.images),
                  title: new Text('Seleccionar foto de la galeria'),
                  onTap: () {
                    Navigator.pop(context);
                    sendComprobante(GALLERY);
                  },
                ),
              ],
            ),
          );
        });
  }

  showSuccessMessage() async {
    await success(context, "Comprobante enviado",
        "Su comprobante de pago ha sido enviado para su revisión");
  }

  showErrorMessage() async {
    await error(context, "Error",
        "Ocurrió un error el enviar el comprobante, por favor intente de nuevo");
  }

  void sendComprobante(int userSourcePhotoOption) async {
    Comprobante comprobante = new Comprobante();
    DateTime now = DateTime.now();
    // String photoUrl = await _getSource(userSourcePhotoOption);
    String photoUrl =
        "https://res.cloudinary.com/jovannyrch/image/upload/v1610467708/jumbtsjyuo4ccjjjeqko.jpg";
    setIsUploadingComprobante(true);
    if (photoUrl.isNotEmpty) {
      
      comprobante.foto = photoUrl;
      comprobante.anio = now.year;
      comprobante.mes = now.month;
      comprobante.proveedor = currentUser.proveedor;
      comprobante.fecha = now.toIso8601String();
      comprobante.status = StatusComprobante.enRevision;
      comprobante.username = currentUser.username;
      comprobante.userId = currentUser.id;
      await comprobante.save();
      setState(() {
        this.comprobanteMesActual = comprobante;
      });
      showSuccessMessage();
    } else {
      showErrorImageUrl();
    }
    setIsUploadingComprobante(false);
  }

  void showErrorImageUrl() {
    showOkAlertDialog(
        context: context, title: "Error", message: "Error al subir la imagen");
  }

  Future<String> _getSource(int option) async {
    String url = "";
    try {
      PickedFile pickedFile;
      switch (option) {
        case CAMERA:
          pickedFile = await picker.getImage(source: ImageSource.camera);
          break;
        case GALLERY:
          pickedFile = await picker.getImage(source: ImageSource.gallery);
          break;
      }
      setIseUploadingPhoto(true);
      url = await subirImagen(pickedFile);
    } catch (e) {
      showErrorUploadingPhoto();
    }finally{
      setIseUploadingPhoto(false);
    }
    
    return url;
  }

  Widget _rowInfoStatus() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        _currentMonthStatus(),
        SizedBox(width: 10.0),
        _labelStatus(),
      ],
    );
  }

  Widget _labelStatus() {
    const style = TextStyle(
      color: kMainColor,
      fontSize: 17.0,
    );
    switch (comprobanteMesActual.status) {
      case "enRevision":
        return Text(
          "En revisión",
          style: style,
        );
      case "noPagado":
        return Text(
          "No pagado",
          style: style,
        );
      case "pagado":
        return Text(
          "Pagado",
          style: style,
        );
      default:
        return Text("");
    }
  }

  Widget _titleCard() {
    return Container(
        child: Text(
      comprobanteMesActual.proveedor,
      style: TextStyle(
        color: kMainColor.withOpacity(0.45),
        fontSize: 20.0,
      ),
    ));
  }

  Widget _currentMonthLabel() {
    return Text(
      "${getCurrentMonth()} ${getCurrentYear()}",
      style: TextStyle(
        fontSize: 30,
        fontWeight: FontWeight.w600,
        color: kMainColor,
        letterSpacing: 1.3,
      ),
    );
  }

  Widget _currentMonthStatus() {
    return Container(
      width: 10,
      height: 10,
      margin: EdgeInsets.only(top: 20.0),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: kMainColor.withOpacity(0.6),
            offset: Offset(1, 1),
            blurRadius: 1.0,
          ),
        ],
        color: getBackgroundColorByStatus(comprobanteMesActual.status),
      ),
    );
  }

  //Errors messages

  void showErrorUploadingPhoto() {}
}

// CREATE SEQUENCE blueray_sec START WITH 1 INCREMENT BY 1 CACHE 100;

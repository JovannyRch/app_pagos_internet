import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pagos_internet/const/conts.dart';
import 'package:pagos_internet/helpers/alerts.dart';
import 'package:pagos_internet/helpers/image.dart';
import 'package:pagos_internet/helpers/months.dart';
import 'package:pagos_internet/models/comprobante_model.dart';
import 'package:pagos_internet/shared/user_preferences.dart';
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
  UserPrefences userPrefrences = new UserPrefences();
  final picker = new ImagePicker();
  List<Comprobante> comprobantes = [];
  bool isUploadingPhoto = false;
  Comprobante comprobanteMesActual;
  bool isLoadingComprobanteActual = false;
  DateTime now = DateTime.now();

  @override
  void initState() {
    this.fetchCurrentComprobante();
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
    setIsLoadingComprobanteActual(true);
  }

  void initComprobante() {
    comprobanteMesActual.mes = now.month;
    comprobanteMesActual.proveedor = "Googinet";
    comprobanteMesActual.status = "noPagado";
    comprobanteMesActual.anio = now.year;
  }

  void setIseUploadingPhoto(bool val) {
    setState(() {
      isUploadingPhoto = val;
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
              ));
  }

  Widget _actionButton() {
    if (status != StatusPaymanent.NOT_PAYED) {
      /* if (status == StatusPaymanent.CHECKING) {
        return Container(
            child: Center(child: Text("Pago en revisión")),
            decoration: BoxDecoration(
              color: Colors.yellow.shade300,
            ));
      } */
      return Container();
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        RaisedButton(
          onPressed: handleSendComprobante,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          color: kSecondaryColor,
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
        )
      ],
    );
  }

  void handleSendComprobante() {
    trySendComprobante();
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
                    onTap: () => {sendComprobante(CAMERA)}),
                new ListTile(
                  leading: new FaIcon(FontAwesomeIcons.images),
                  title: new Text('Seleccionar foto de la galeria'),
                  onTap: () => {sendComprobante(GALLERY)},
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
    if (photoUrl.isNotEmpty) {
      comprobante.foto = photoUrl;
      comprobante.anio = now.year;
      comprobante.mes = now.month;
      comprobante.proveedor = "Googinet";
      comprobante.fecha = now.toIso8601String();
      comprobante.status = StatusComprobante.enRevision;
      comprobante.username = userPrefrences.username;
      comprobante.userId = userPrefrences.email;
      await comprobante.save();
      showSuccessMessage();
    } else {
      showErrorImageUrl();
    }
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
      setIseUploadingPhoto(false);
    } catch (e) {
      showErrorUploadingPhoto();
    }
    setIseUploadingPhoto(false);
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
    switch (status) {
      case StatusPaymanent.CHECKING:
        return Text(
          "Comprobante de pago en revisión",
          style: style,
        );
      case StatusPaymanent.NOT_PAYED:
        return Text(
          "No pagado",
          style: style,
        );
      case StatusPaymanent.PAYED:
        return Text(
          "Pagado",
          style: style,
        );
      default:
        return Text("");
    }
  }

  Widget _titleCard() {
    //TODO: Add proveedor
    return Container(
        child: Text(
      "Googinet",
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

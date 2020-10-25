import 'dart:async';
import 'package:control_ingreso/src/models/payment_model.dart';
import 'package:control_ingreso/src/providers/payment_provider.dart';
import 'package:control_ingreso/src/utils/utils.dart' as utils;
import 'package:flutter/material.dart';

class AppPaymentPage extends StatefulWidget {
  @override
  _AppPaymentPageState createState() => _AppPaymentPageState();
}

class _AppPaymentPageState extends State<AppPaymentPage> {
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final vehicleProvider = new PaymentProvider();

  PaymentModel paymentModel = new PaymentModel();
  bool _saving = false;

  @override
  Widget build(BuildContext context) {
    //**Se agrega lógica para determinar si es nuevo o es modificación */
    final PaymentModel paymentModelData =
        ModalRoute.of(context).settings.arguments;
    if (paymentModelData != null) {
      paymentModel = paymentModelData;
    }

    return Scaffold(
        key: scaffoldKey,
        appBar: AppBar(title: Text('Agregar Pago')),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(15.0),
            child: Form(
                key: formKey,
                child: Column(
                  children: <Widget>[
                    _numeroCasa(),
                    _ano(),
                    _mes(),
                    // _fecha(),
                    // _hora(),
                    _monto(),
                    SizedBox(height: 40.0),
                    _createButton(),
                  ],
                )),
          ),
        ));
  }

  Widget _numeroCasa() {
    return TextFormField(
      initialValue: paymentModel.pnca,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(labelText: 'Número de casa'),
      onSaved: (value) => paymentModel.pnca = value,
    );
  }

  Widget _ano() {
    return TextFormField(
        initialValue: paymentModel.pano.toString(),
        keyboardType: TextInputType.number,
        decoration: InputDecoration(labelText: 'Año'),
        onSaved: (value) => paymentModel.pano = int.parse(value),
        validator: (value) {
          if (utils.isNumeric(value)) {
            return null;
          } else {
            return 'Solo números';
          }
        });
  }

  Widget _mes() {
    return TextFormField(
        initialValue: paymentModel.pmes.toString(),
        keyboardType: TextInputType.number,
        decoration: InputDecoration(labelText: 'Mes'),
        onSaved: (value) => paymentModel.pmes = int.parse(value),
        validator: (value) {
          if (utils.isNumeric(value)) {
            return null;
          } else {
            return 'Solo números';
          }
        });
  }

  // Widget _fecha() {
  //   return TextFormField(
  //     initialValue: paymentModel.pfec,
  //     textCapitalization: TextCapitalization.sentences,
  //     decoration: InputDecoration(labelText: 'Fecha'),
  //     onSaved: (value) => paymentModel.pfec = value,
  //   );
  // }

  // Widget _hora() {
  //   return TextFormField(
  //     initialValue: paymentModel.phor,
  //     textCapitalization: TextCapitalization.sentences,
  //     decoration: InputDecoration(labelText: 'Hora del pago'),
  //     onSaved: (value) => paymentModel.phor = value,
  //   );
  // }

  Widget _monto() {
    return TextFormField(
        initialValue: paymentModel.pmon.toString(),
        keyboardType: TextInputType.number,
        decoration: InputDecoration(labelText: 'Monto a cancelar'),
        onSaved: (value) => paymentModel.pmon = int.parse(value),
        validator: (value) {
          if (utils.isNumeric(value)) {
            return null;
          } else {
            return 'Solo números';
          }
        });
  }

  Widget _createButton() {
    return RaisedButton.icon(
      color: Colors.teal,
      textColor: Colors.white,
      label: Text('Guardar'),
      icon: Icon(Icons.save),
      // onPressed: () {},
      onPressed: (_saving) ? null : _submit,
    );
  }

  void _submit() async {
    if (!formKey.currentState.validate()) return;
    formKey.currentState.save();
    setState(() {
      _saving = true;
    });

    //**Se valida si se creará o se modificará el producto */
    if (paymentModel.id == null) {
      // print('crea uno nuevo');
      vehicleProvider.createPayment(paymentModel);
    } else {
      // print('modifica uno existente');
      vehicleProvider.modifyPayment(paymentModel);
    }
    // setState(() {
    //   _saving = true;
    // });
    showMySnackbar('Registro almacenado correctamente');

    Timer(Duration(milliseconds: 1500), () => Navigator.pop(context));
  }

  //**Barra de mensaje */
  void showMySnackbar(String message) {
    final snackbar = SnackBar(
      content: Text(message),
      duration: Duration(milliseconds: 1500),
      backgroundColor: Colors.teal[900],
    );
    scaffoldKey.currentState.showSnackBar(snackbar);
  }

// This
// is
// the
// END
}

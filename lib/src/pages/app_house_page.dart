import 'dart:async';
import 'package:control_ingreso/src/models/house_model.dart';
import 'package:control_ingreso/src/providers/house_provider.dart';
import 'package:control_ingreso/src/utils/utils.dart' as utils;
import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';

class AppHousePage extends StatefulWidget {
  @override
  _AppHousePageState createState() => _AppHousePageState();
}

class _AppHousePageState extends State<AppHousePage> {
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final vehicleProvider = new HouseProvider();

  HouseModel houseModel = new HouseModel();
  bool _saving = false;

  @override
  Widget build(BuildContext context) {
    //**Se agrega lógica para determinar si es nuevo o es modificación */
    final HouseModel houseModelData = ModalRoute.of(context).settings.arguments;
    if (houseModelData != null) {
      houseModel = houseModelData;
    }

    return Scaffold(
        key: scaffoldKey,
        appBar: AppBar(title: Text('Agregar Vivienda')),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(15.0),
            child: Form(
                key: formKey,
                child: Column(
                  children: <Widget>[
                    _departamento(),
                    _direccion(),
                    _municipio(),
                    _numeroCasa(),
                    _residencial(),
                    _zona(),
                    _tipo(),
                    SizedBox(height: 40.0),
                    _createButton(),
                  ],
                )),
          ),
        ));
  }

  Widget _departamento() {
    return TextFormField(
      initialValue: houseModel.cdep,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(labelText: 'Departamento'),
      onSaved: (value) => houseModel.cdep = value,
    );
  }

  Widget _direccion() {
    return TextFormField(
      initialValue: houseModel.cdir,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        labelText: 'Dirección',
        // helperText: 'Ejemplo: 123ABC',
      ),
      onSaved: (value) => houseModel.cdir = value,
      validator: (value) {
        if (value.length < 3) {
          return 'Ingrese un código de placa';
        } else {
          return null;
        }
      },
    );
  }

  Widget _municipio() {
    return TextFormField(
      initialValue: houseModel.cmun,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(labelText: 'Municipio'),
      onSaved: (value) => houseModel.cmun = value,
    );
  }

  Widget _numeroCasa() {
    return TextFormField(
      initialValue: houseModel.cnca,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(labelText: 'Número de casa'),
      onSaved: (value) => houseModel.cnca = value,
    );
  }

  Widget _residencial() {
    return TextFormField(
      initialValue: houseModel.cres,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(labelText: 'Residencial'),
      onSaved: (value) => houseModel.cres = value,
    );
  }

  Widget _zona() {
    return TextFormField(
        initialValue: houseModel.czon.toString(),
        keyboardType: TextInputType.number,
        decoration: InputDecoration(labelText: 'Zona'),
        onSaved: (value) => houseModel.czon = int.parse(value),
        validator: (value) {
          if (utils.isNumeric(value)) {
            return null;
          } else {
            return 'Solo números';
          }
        });
  }

  Widget _tipo() {
    return TextFormField(
      initialValue: houseModel.ctip,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
          labelText: 'Tipo de vivienda', helperText: 'Propia, alquilada'),
      onSaved: (value) => houseModel.ctip = value,
    );
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
    if (houseModel.id == null) {
      // print('crea uno nuevo');
      vehicleProvider.createHouse(houseModel);
    } else {
      // print('modifica uno existente');
      vehicleProvider.modifyHouse(houseModel);
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

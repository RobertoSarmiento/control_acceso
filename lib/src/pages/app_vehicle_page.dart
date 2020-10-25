import 'dart:async';
import 'dart:io';
import 'package:control_ingreso/src/models/vehicle_model.dart';
import 'package:control_ingreso/src/providers/vehicle_provider.dart';
import 'package:control_ingreso/src/utils/utils.dart' as utils;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AppVehiclePage extends StatefulWidget {
  @override
  _AppVehiclePageState createState() => _AppVehiclePageState();
}

class _AppVehiclePageState extends State<AppVehiclePage> {
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final vehicleProvider = new VehicleProvider();

  VehicleModel vehicleModel = new VehicleModel();
  bool _saving = false;
  // File foto;
  File photo;

  @override
  Widget build(BuildContext context) {
    //**Se agrega lógica para determinar si es nuevo o es modificación */
    final VehicleModel vehicleModelData =
        ModalRoute.of(context).settings.arguments;
    if (vehicleModelData != null) {
      vehicleModel = vehicleModelData;
    }

    return Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
          title: Text('Agregar Vehículo'),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.photo_size_select_actual),
              onPressed: _selectPhoto,
            ),
            IconButton(
              icon: Icon(Icons.camera_alt),
              onPressed: _takePhoto,
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(15.0),
            child: Form(
                key: formKey,
                child: Column(
                  children: <Widget>[
                    _tipoPlaca(),
                    _placa(),
                    _marca(),
                    _linea(),
                    _modelo(),
                    _tipoVehiculo(),
                    _color(),
                    _otrasDescr(),
                    // SizedBox(height: 40.0),
                    // _selectPhotoButton(),
                    SizedBox(height: 40.0),
                    _mostrarFoto(),
                    SizedBox(height: 40.0),
                    _createButton(),
                  ],
                )),
          ),
        ));
  }

  Widget _tipoPlaca() {
    return TextFormField(
      initialValue: vehicleModel.atpl,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(labelText: 'Tipo de placa'),
      onSaved: (value) => vehicleModel.atpl = value,
    );
  }

  Widget _placa() {
    return TextFormField(
      initialValue: vehicleModel.apla,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        labelText: 'Número de Placa',
        helperText: 'Ejemplo: 123ABC',
      ),
      onSaved: (value) => vehicleModel.apla = value,
      validator: (value) {
        if (value.length < 3) {
          return 'Ingrese un código de placa';
        } else {
          return null;
        }
      },
    );
  }

  Widget _marca() {
    return TextFormField(
      initialValue: vehicleModel.amar,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(labelText: 'Marca'),
      onSaved: (value) => vehicleModel.amar = value,
    );
  }

  Widget _linea() {
    return TextFormField(
      initialValue: vehicleModel.alin,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(labelText: 'Línea'),
      onSaved: (value) => vehicleModel.alin = value,
    );
  }

  Widget _modelo() {
    return TextFormField(
        initialValue: vehicleModel.amod.toString(),
        keyboardType: TextInputType.number,
        decoration: InputDecoration(labelText: 'Modelo'),
        onSaved: (value) => vehicleModel.amod = int.parse(value),
        validator: (value) {
          if (utils.isNumeric(value)) {
            return null;
          } else {
            return 'Solo números';
          }
        });
  }

  Widget _tipoVehiculo() {
    return TextFormField(
      initialValue: vehicleModel.atve,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(labelText: 'Tipo del vehículo'),
      onSaved: (value) => vehicleModel.atve = value,
    );
  }

  Widget _color() {
    return TextFormField(
      initialValue: vehicleModel.acol,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(labelText: 'Color'),
      onSaved: (value) => vehicleModel.acol = value,
    );
  }

  Widget _otrasDescr() {
    return TextFormField(
      initialValue: vehicleModel.aotr,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(labelText: 'Otras Descripciones'),
      onSaved: (value) => vehicleModel.aotr = value,
    );
  }

  Widget _mostrarFoto() {
    if (vehicleModel.aurl != null) {
      //agregar aqui
      return FadeInImage(
          placeholder: AssetImage('assets/jar-loading.gif'),
          image: NetworkImage(vehicleModel.aurl));
    } else {
      if (vehicleModel.aurl != null) {
        return Container();
      } else {
        if (photo != null) {
          return Image.file(
            photo,
            fit: BoxFit.cover,
            height: 300.0,
          );
        }
      }
      return Image.asset('assets/no-vehicle.jpg');
    }
  }

  // Widget _selectPhotoButton() {
  //   return RaisedButton.icon(
  //     color: Colors.teal,
  //     textColor: Colors.white,
  //     label: Text('Seleccionar foto'),
  //     icon: Icon(Icons.photo_size_select_actual),
  //     // onPressed: () {},
  //     onPressed: (_saving) ? null : _submit,
  //   );
  // }

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

    //**Para cargar la imagen
    if (photo != null) {
      vehicleModel.aurl = await vehicleProvider.uploadImage(photo);
    }

    //**Se valida si se creará o se modificará el producto */
    if (vehicleModel.id == null) {
      // print('crea uno nuevo');
      vehicleProvider.createVehicle(vehicleModel);
    } else {
      // print('modifica uno existente');
      vehicleProvider.modifyVehicle(vehicleModel);
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

  //**Código para el manejo de imágenes
  _selectPhoto() async {
    _processImage(ImageSource.gallery);
  }

  _takePhoto() async {
    _processImage(ImageSource.camera);
  }

  _processImage(ImageSource origin) async {
    final _picker = ImagePicker();
    final pickedFile = await _picker.getImage(
      source: origin,
    );

    photo = File(pickedFile.path);
    if (photo != null) {
      vehicleModel.aurl = null;
    }
    setState(() {});
  }

// This
// is
// the
// END
}

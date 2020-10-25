import 'dart:async';
import 'dart:io';
import 'package:control_ingreso/src/models/person_model.dart';
import 'package:control_ingreso/src/providers/person_provider.dart';
import 'package:control_ingreso/src/utils/utils.dart' as utils;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AppPersonPage extends StatefulWidget {
  @override
  _AppPersonPageState createState() => _AppPersonPageState();
}

class _AppPersonPageState extends State<AppPersonPage> {
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final personProvider = new PersonProvider();

  PersonModel personModel = new PersonModel();
  bool _saving = false;
  // File foto;
  File photo;

  @override
  Widget build(BuildContext context) {
    //**Se agrega lógica para determinar si es nuevo o es modificación */
    final PersonModel personModelData =
        ModalRoute.of(context).settings.arguments;
    if (personModelData != null) {
      personModel = personModelData;
    }

    return Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
          title: Text('Agregar Vecino'),
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
                    _dpi(),
                    _nombres(),
                    _apellidos(),
                    _numeroCasa(),
                    _placa(),
                    _celular1(),
                    _celular2(),
                    SizedBox(height: 40.0),
                    _mostrarFoto(),
                    SizedBox(height: 40.0),
                    _createButton(),
                  ],
                )),
          ),
        ));
  }

  Widget _dpi() {
    return TextFormField(
        initialValue: personModel.vdpi.toString(),
        keyboardType: TextInputType.number,
        decoration: InputDecoration(labelText: 'DPI'),
        onSaved: (value) => personModel.vdpi = int.parse(value),
        validator: (value) {
          if (utils.isNumeric(value)) {
            return null;
          } else {
            return 'Solo números';
          }
        });
  }

  Widget _nombres() {
    return TextFormField(
      initialValue: personModel.vnom,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(labelText: 'Nombres'),
      onSaved: (value) => personModel.vnom = value,
    );
  }

  Widget _apellidos() {
    return TextFormField(
      initialValue: personModel.vape,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(labelText: 'Apellidos'),
      onSaved: (value) => personModel.vape = value,
    );
  }

  Widget _numeroCasa() {
    return TextFormField(
      initialValue: personModel.vnca,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(labelText: 'Número de casa'),
      onSaved: (value) => personModel.vnca = value,
    );
  }

  Widget _placa() {
    return TextFormField(
      initialValue: personModel.vpla,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        labelText: 'Número de Placa',
        helperText: 'Ejemplo: 123ABC',
      ),
      onSaved: (value) => personModel.vpla = value,
      validator: (value) {
        if (value.length < 3) {
          return 'Ingrese un código de placa';
        } else {
          return null;
        }
      },
    );
  }

  Widget _celular1() {
    return TextFormField(
        initialValue: personModel.vce1.toString(),
        keyboardType: TextInputType.number,
        decoration: InputDecoration(labelText: 'Celular'),
        onSaved: (value) => personModel.vce1 = int.parse(value),
        validator: (value) {
          if (utils.isNumeric(value)) {
            return null;
          } else {
            return 'Solo números';
          }
        });
  }

  Widget _celular2() {
    return TextFormField(
        initialValue: personModel.vce2.toString(),
        keyboardType: TextInputType.number,
        decoration: InputDecoration(labelText: 'Celular 2'),
        onSaved: (value) => personModel.vce2 = int.parse(value),
        validator: (value) {
          if (utils.isNumeric(value)) {
            return null;
          } else {
            return 'Solo números';
          }
        });
  }

  Widget _mostrarFoto() {
    if (personModel.vurl != null) {
      //agregar aqui
      return FadeInImage(
          placeholder: AssetImage('assets/jar-loading.gif'),
          image: NetworkImage(personModel.vurl));
    } else {
      if (personModel.vurl != null) {
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
      return Image.asset('assets/no-photo.png');
    }
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

    //**Para cargar la imagen
    if (photo != null) {
      personModel.vurl = await personProvider.uploadImage(photo);
    }

    //**Se valida si se creará o se modificará el producto */
    if (personModel.id == null) {
      // print('crea uno nuevo');
      personProvider.createPerson(personModel);
    } else {
      // print('modifica uno existente');
      personProvider.modifyPerson(personModel);
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
      personModel.vurl = null;
    }
    setState(() {});
  }

// This
// is
// the
// END
}

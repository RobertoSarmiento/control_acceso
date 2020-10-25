import 'dart:io';
import 'package:control_ingreso/src/models/producto_model.dart';
import 'package:control_ingreso/src/providers/productos_provider.dart';
import 'package:control_ingreso/src/utils/utils.dart' as utils;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProductoPage extends StatefulWidget {
  @override
  _ProductoPageState createState() => _ProductoPageState();
}

class _ProductoPageState extends State<ProductoPage> {
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final productoProvider = new ProdutosProvider();

  ProductoModel producto = new ProductoModel();
  bool _guardando = false;
  File foto;
  File photo;

  @override
  Widget build(BuildContext context) {
    //**Se agrega lógica para determinar si es nuevo o es modificación */
    final ProductoModel prodData = ModalRoute.of(context).settings.arguments;
    if (prodData != null) {
      producto = prodData;
    }

    return Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
          title: Text('Producto'),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.photo_size_select_actual),
              onPressed: _seleccionarFoto,
            ),
            IconButton(
              icon: Icon(Icons.camera_alt),
              onPressed: _tomarFoto,
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
                    _mostrarFoto(),
                    _crearNombre(),
                    _crearPrecio(),
                    _crearDisponible(),
                    _crearBoton(context),
                    _crearBoton2(context),
                  ],
                )),
          ),
        ));
  }

  Widget _crearNombre() {
    return TextFormField(
      initialValue: producto.titulo,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        labelText: 'Producto',
      ),
      onSaved: (value) => producto.titulo = value,
      validator: (value) {
        if (value.length < 3) {
          return 'Ingrese el nombre del producto';
        } else {
          return null;
        }
      },
    );
  }

  Widget _crearPrecio() {
    return TextFormField(
      initialValue: producto.valor.toString(),
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: 'Precio',
      ),
      onSaved: (value) => producto.valor = double.parse(value),
      validator: (value) {
        if (utils.isNumeric(value)) {
          return null;
        } else {
          return 'Solo números';
        }
      },
    );
  }

  Widget _crearDisponible() {
    return SwitchListTile(
      value: producto.disponible,
      activeColor: Colors.teal,
      onChanged: (value) => setState(() {
        producto.disponible = value;
      }),
    );
  }

  Widget _crearBoton(BuildContext context) {
    return RaisedButton.icon(
      color: Colors.teal,
      textColor: Colors.white,
      label: Text('Guardar'),
      icon: Icon(Icons.save),
      onPressed: (_guardando) ? null : _submit,

//      onPressed: () => Navigator.pushNamed(context, 'AppVehicle'),
    );
  }

  void _submit() async {
    //**Se utiliza un async por el await del url de la foto
    if (!formKey.currentState.validate()) return;
    formKey.currentState.save();
    setState(() {
      _guardando = true;
    });

    if (foto != null) {
      producto.fotoUrl = await productoProvider.subirImagen(foto);
    }

    // print('Todo bien');
    // print(producto.titulo);
    // print(producto.valor);
    // print(producto.disponible);

    //**Se valida si se creará o se modificará el producto */
    if (producto.id == null) {
      productoProvider.crearProducto(producto);
    } else {
      productoProvider.editarProducto(producto);
    }
    setState(() {
      _guardando = true;
    });
    mostrarSnackbar('Registro guardado');
    Navigator.pop(context);
  }

  void mostrarSnackbar(String mensaje) {
    final snackbar = SnackBar(
      content: Text(mensaje),
      duration: Duration(milliseconds: 2000),
      backgroundColor: Colors.teal[900],
    );
    scaffoldKey.currentState.showSnackBar(snackbar);
  }

  Widget _crearBoton2(BuildContext context) {
    return RaisedButton.icon(
      color: Colors.teal,
      textColor: Colors.white,
      label: Text('Ir a vehículos'),
      icon: Icon(Icons.save),
      onPressed: () => Navigator.pushNamed(context, 'appVehicle'),
    );
  }

  Widget _mostrarFoto() {
    if (producto.fotoUrl != null) {
      return FadeInImage(
        placeholder: AssetImage('assets/jar-loading.gif'),
        image: NetworkImage(producto.fotoUrl),
        height: 300.00,
        fit: BoxFit.contain,
      );
    } else {
      if (producto.fotoUrl != null) {
        return Container();
      } else {
        if (foto != null) {
          return Image.file(
            foto,
            fit: BoxFit.cover,
            height: 300.0,
          );
        }
      }
      return Image.asset('assets/no-image.png');
    }
  }

  _seleccionarFoto() async {
    _procesarImagen(ImageSource.gallery);
    //**Se optimiza el código */
    //   foto = await ImagePicker.pickImage(
    //     source: ImageSource.gallery,
    //   );
    //   if (foto != null) {}
    //   setState(() {});
  }

  _tomarFoto() async {
    _procesarImagen(ImageSource.camera);
    //**Se optimiza el código */
    //   foto = await ImagePicker.pickImage(
    //     source: ImageSource.camera,
    //   );
    //   if (foto != null) {}
    //   setState(() {});
  }

  _procesarImagen(ImageSource origin) async {
    final _picker = ImagePicker();
    final pickedFile = await _picker.getImage(
      source: origin,
    );

    foto = File(pickedFile.path);
    if (foto != null) {
      producto.fotoUrl = null;
    }
    setState(() {});
  }

// This
// is
// the
// END
}

// import 'package:control_ingreso/src/bloc/provider.dart';
import 'package:control_ingreso/src/models/producto_model.dart';
import 'package:control_ingreso/src/providers/productos_provider.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  final produtosProvider = new ProdutosProvider();

  @override
  Widget build(BuildContext context) {
    // final bloc = Provider.of(context);   //-->Esto es del email y contraseña
    return Scaffold(
      appBar: AppBar(
        title: Text('Inicio Practica'),
      ),
      // body: Container(
      //   child: Column(
      //     crossAxisAlignment: CrossAxisAlignment.center,
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     children: <Widget>[
      //       Text('Email: ${bloc.email}'),
      //       Divider(),
      //       Text('Contraseña: ${bloc.password}'),
      //     ],
      //   ),
      // ),

//      body: Container(),
      body: _crearListado(),

      floatingActionButton: _crearBoton(context),
    );
  }

  Widget _crearListado() {
    return FutureBuilder(
      future: produtosProvider.cargarProductos(),
      builder:
          (BuildContext context, AsyncSnapshot<List<ProductoModel>> snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (context, i) => _crearItem(context, snapshot.data[i]),
          );
        } else {}
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  Widget _crearItem(BuildContext context, ProductoModel producto) {
    //Agregar acción de desplazamiento
    return Dismissible(
      key: UniqueKey(),
      background: Container(color: Colors.red),
      onDismissed: (direccion) {
        produtosProvider.borrarProducto(producto.id);
      },
      child: Card(
        child: Column(
          children: <Widget>[
            (producto.fotoUrl == null)
                ? Image(image: AssetImage('assets/no-image.png'))
                : FadeInImage(
                    placeholder: AssetImage('assets/jar-loading.gif'),
                    image: NetworkImage(producto.fotoUrl),
                    height: 300.0,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
            ListTile(
              title: Text('${producto.titulo}-${producto.valor}'),
              subtitle: Text(producto.id),
              //Para navegar sobre un elemento y cambiar de pantalla
              //Se agrega el argumento para poder modificar el producto
              onTap: () => Navigator.pushNamed(
                context,
                'producto',
                arguments: producto,
              ),
            ),
          ],
        ),
      ),
    );
  }

  _crearBoton(BuildContext context) {
    return FloatingActionButton(
      child: Icon(Icons.keyboard_arrow_right_outlined),
      onPressed: () => Navigator.pushNamed(context, 'producto'),
      // onPressed: () => Navigator.pushNamed(context, 'appVehicle'),
      backgroundColor: Colors.teal,
    );
  }

//This
//is
//the
//END
}

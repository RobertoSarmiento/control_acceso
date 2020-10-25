// import 'package:control_ingreso/src/bloc/login_bloc.dart';
import 'package:control_ingreso/src/bloc/provider.dart';
import 'package:control_ingreso/src/models/rol_model.dart';
import 'package:control_ingreso/src/providers/rol_provider.dart';
import 'package:flutter/material.dart';

///////////////N O    S I R V E ///////////////////////
///////////////N O    S I R V E ///////////////////////
///////////////N O    S I R V E ///////////////////////
class AppHomeApp extends StatefulWidget {
  @override
  _AppHomeAppState createState() => _AppHomeAppState();
}

final rolProvider = new RolProvider();

class _AppHomeAppState extends State<AppHomeApp> {
  String userRol = '';
  String email = '';

  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of(context); //-->Esto es del email y contraseña
    email = bloc.email;
    return Scaffold(
      appBar: AppBar(
        title: Text('Inicio Temporal'),
      ),
      body: _crearListado(),
    );
  }

  Widget _crearListado() {
    return FutureBuilder(
      future: rolProvider.loadRol(email),
      builder: (BuildContext context, AsyncSnapshot<List<RolModel>> snapshot) {
        if (snapshot.hasData) {
          print('sí tiene');

          final rols = snapshot.data;
          return ListView.builder(
            itemCount: rols.length,
            itemBuilder: (context, i) => _crearItem(rols[i]),
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget _crearItem(RolModel rolModel) {
    return ListTile(
      title: Text('${rolModel.mail}-${rolModel.rrol}'),
    );
  }

  // _obtenerRol() {
  //   return FutureBuilder(
  //     future: rolProvider.loadRol(email),
  //     builder: (BuildContext context, AsyncSnapshot<List<RolModel>> snapshot) {
  //       if (snapshot.hasData) {
  //         print('sí tiene');

  //         return Container(
  //           child: Text('hola'),
  //         );
  //       } else {
  //         return Center(child: CircularProgressIndicator());
  //       }
  //     },
  //   );
  // }

  // _crearListado(LoginBloc bloc) {
  //   return Container(
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.center,
  //       mainAxisAlignment: MainAxisAlignment.center,
  //       children: <Widget>[
  //         Text('Email: ${bloc.email}'),
  //         Divider(),
  //         Text('Contraseña: ${bloc.password}'),
  //         Divider(),
  //         Text('Número de casa: ${bloc.houseNumber}'),
  //       ],
  //     ),
  //   );
  // }
// This
// is
// the
// END

}

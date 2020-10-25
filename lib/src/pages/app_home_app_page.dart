// import 'package:control_ingreso/src/bloc/login_bloc.dart';
// import 'package:control_ingreso/src/bloc/provider.dart';
import 'package:control_ingreso/src/models/rol_model.dart';
import 'package:control_ingreso/src/providers/rol_provider.dart';
import 'package:flutter/material.dart';

class AppHomeApp extends StatefulWidget {
  @override
  _AppHomeAppState createState() => _AppHomeAppState();
}

final rolProvider = new RolProvider();

class _AppHomeAppState extends State<AppHomeApp> {
  String userRol = '';
  String email = '';
  String houseNumber = '';
  String loginHouseNumber = '';

  @override
  Widget build(BuildContext context) {
    // final bloc = Provider.of(context); //-->Esto es del email y contraseña
    // email = bloc.email;
    // loginHouseNumber = bloc.houseNumber;

    email = 'admin.cocode@gmail.com';
    loginHouseNumber = '000';
    if (email == 'admin.cocode@gmail.com') {
      userRol = 'A';
    } else {
      if (email == 'guardia.cocode@gmail.com') {
        userRol = 'G';
      } else {
        userRol = 'U';
      }
    }

    // _obtenerRol();

    // _obtenerRol();
    return Scaffold(
      appBar: AppBar(title: Text('Inicio Temporal')),
      body: _crearListado(),
    );
  }

  _crearListado() {
    return Container(
      child: Column(
        children: <Widget>[
          Text('hola mundo'),
          _obtenerRol(),

          _validateHouseNumber(),
          // Text('El rol es: $userRol'),
        ],
      ),
    );
  }

  //Se obtiene el rol y número de casa
  _obtenerRol() {
    // if (userRol == 'A') {
    //   // return Container();
    // } else {
    return FutureBuilder(
      future: rolProvider.loadRol(email),
      builder: (BuildContext context, AsyncSnapshot<List<RolModel>> snapshot) {
        if (snapshot.hasData) {
          print('sí tiene');

          final rols = snapshot.data;
          print(rols.length);
          userRol = rols[0].rrol;
          houseNumber = rols[0].rnca;
          print('Este es el pito: $userRol');
          print('Este es el número de casa $houseNumber');
          print('Este es el número de casa $email');

          if (houseNumber.toString() != loginHouseNumber.toString()) {
            print('********error**********');
          }

          return Container();
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
    // }
  }

  _validateHouseNumber() {
    if (houseNumber.toString() != loginHouseNumber.toString()) {
      print('error dos');
      return Column();
    }
  }

  void showErrorMessage(BuildContext context, String mensaje) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Información incorrecta'),
          content: Text(mensaje),
          actions: <Widget>[
            FlatButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Ok'),
            )
          ],
        );
      },
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

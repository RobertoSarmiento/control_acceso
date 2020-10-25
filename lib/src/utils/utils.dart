// import 'package:control_ingreso/src/models/rol_model.dart';
// import 'package:control_ingreso/src/pages/app_home_app_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

//**Valida que el valor ingresado sea un número
bool isNumeric(String s) {
  if (s.isEmpty) return false;
  final n = num.tryParse(s);
  return (n == null) ? false : true;
}

void mostrarAlerta(BuildContext context, String mensaje) {
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

void showAlert(BuildContext context, String mensaje) {
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

// void showError(BuildContext context, String mensaje) {
//   showDialog(
//     context: context,
//     builder: (context) {
//       return AlertDialog(
//         title: Text('Información incorrecta'),
//         content: Text(mensaje),
//         actions: <Widget>[
//           FlatButton(
//             onPressed: () => Navigator.of(context).pop(),
//             child: Text('Ok'),
//           )
//         ],
//       );
//     },
//   );
// }

// void obtenerRol(email) {
//    FutureBuilder(
//     future: rolProvider.loadRol(email),
//     builder: (BuildContext context, AsyncSnapshot<List<RolModel>> snapshot) {
//       if (snapshot.hasData) {
//         print('sí tiene');

//         final rols = snapshot.data;
//         print(rols.length);
//         // userRol = rols[0].rper;
//         // print('Este es el pito: $userRol');
//         // return Container();
//       } else {
//         // return Center(child: CircularProgressIndicator());
//       }
//     },
//   );
// }

//
//
//
// String fecha = '';
// String hora = '';

// DateTime dateTime = new DateTime.now();
// fecha = '${dateTime.day}/${dateTime.month}/${dateTime.year}';
// hora = '${dateTime.hour}:${dateTime.minute}';

// print(dateTime);
// print(fecha);
// print(hora);

import 'dart:async';

class Validators {
  final checkPassword = StreamTransformer<String, String>.fromHandlers(
    handleData: (password, sink) {
      Pattern pattern =
          // r'^(?=.*\d)(?=.*[\u0021-\u002b\u003c-\u0040])(?=.*[A-Z])(?=.*[a-z])\S{6,16}$';
          r'^(?=\w*\d)(?=\w*[A-Z])(?=\w*[a-z])\S{8,16}$';

      RegExp regExp = new RegExp(pattern);

      if (regExp.hasMatch(password)) {
        sink.add(password);
      } else {
        sink.addError('Incluir mayúsculas, minúsculas y números');
        // 'La contraseña debe poseer al menos 6 y máximo 16 caracteres, incluyendo dígitos, minúsculas, mayúsculas y símbolos.');
      }

      // if (password.length >= 6) {
      //   sink.add(password);
      // } else {
      //   sink.addError('La contraseña debe poseer al menos 6 caracteres');
      // }

// Dígitos, minúsculas y mayúsculas (2)
// ^(?=\w*\d)(?=\w*[A-Z])(?=\w*[a-z])\S{8,16}$

// Dígitos, minúsculas y mayúsculas (1)
// ^(?=\w*\d)(?=\w*[A-Z])(?=\w*[a-z])\S{8,16}$

// Dígitos, minúsculas y mayúsculas y símbolos
// ^(?=.*\d)(?=.*[\u0021-\u002b\u003c-\u0040])(?=.*[A-Z])(?=.*[a-z])\S{8,16}$
    },
  );

  final checkEmail = StreamTransformer<String, String>.fromHandlers(
    handleData: (email, sink) {
      Pattern pattern =
          r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

      RegExp regExp = new RegExp(pattern);

      if (regExp.hasMatch(email)) {
        sink.add(email);
      } else {
        sink.addError('Ingrese un correo valido.');
      }
    },
  );

//Temporal revisar
//Temporal revisar
//Temporal revisar
  final checkHouseNumber = StreamTransformer<String, String>.fromHandlers(
    handleData: (houseNumber, sink) {
      if (houseNumber.length >= 3) {
        sink.add(houseNumber);
      } else {
        sink.addError('Ingresar número de casa');
      }
    },
  );
}

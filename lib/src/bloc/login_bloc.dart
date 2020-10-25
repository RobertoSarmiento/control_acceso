import 'dart:async';

import 'package:control_ingreso/src/bloc/validators.dart';
import 'package:rxdart/rxdart.dart';

class LoginBloc with Validators {
  final _emailController = BehaviorSubject<String>();
  final _passwordController = BehaviorSubject<String>();
  final _houseNumberController = BehaviorSubject<String>();

  //Recuperar los datos del Stream
  Stream<String> get emailStream =>
      _emailController.stream.transform(checkEmail);

  Stream<String> get passwordStream =>
      _passwordController.stream.transform(checkPassword);

  Stream<String> get houseNumberStream =>
      _houseNumberController.stream.transform(checkHouseNumber);

  //Sirve para validar que los campos estén llenos
  //Se combinan dos campos o más
  Stream<bool> get formValidStream =>
      // Rx.combineLatest2(emailStream, passwordStream, (e, p) => true);
      Rx.combineLatest3(
          emailStream, passwordStream, houseNumberStream, (a, b, c) => true);

  //Insertar valores al Stream
  Function(String) get changeEmail => _emailController.sink.add;
  Function(String) get changePassword => _passwordController.sink.add;
  Function(String) get changeHouseNumber => _houseNumberController.sink.add;

  //Obtener último valor ingresado
  String get email => _emailController.value;
  String get password => _passwordController.value;
  String get houseNumber => _houseNumberController.value;

  //Método para cerrarlos
  dispose() {
    _emailController?.close();
    _passwordController?.close();
    _houseNumberController?.close();
  }
}

import 'dart:convert';
import 'package:control_ingreso/src/models/rol_model.dart';
import 'package:control_ingreso/src/preferencias_usuario/preferencias_usuario.dart';
import 'package:control_ingreso/src/providers/rol_provider.dart';
import 'package:http/http.dart' as http;

String lvMessage = "";

class UserProvider {
  final String _firebaseToken = 'AIzaSyAEoi1PgWGgaMiHRqAPGgoQiHutUuqeSYo';
  final _prefs = new PreferenciasUsuario();

////////////////////////////////////////////////////////////////////////////////
//                         Para realizar el login
////////////////////////////////////////////////////////////////////////////////
  Future<Map<String, dynamic>> login(String email, String password) async {
    final authData = {
      'email': email,
      'password': password,
      'returnSecureToken': true
    };

    final answer = await http.post(
        'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=$_firebaseToken',
        body: json.encode(authData));

    Map<String, dynamic> decodedAnswer = json.decode(answer.body);

    print(decodedAnswer);
    if (decodedAnswer.containsKey('idToken')) {
      _prefs.token = decodedAnswer['idToken'];

      return {'ok': true, 'token': decodedAnswer['idToken']};
    } else {
      if (decodedAnswer['error']['message'] == 'INVALID_PASSWORD') {
        lvMessage = "Contraseña incorrecta, favor de validar";
        return {'ok': false, 'mensaje': lvMessage};
      }
      if (decodedAnswer['error']['message'] == 'EMAIL_NOT_FOUND') {
        lvMessage = "El correo ingresado no existe";
        return {'ok': false, 'mensaje': lvMessage};
      } else {
        return {'ok': false, 'mensaje': decodedAnswer['error']['message']};
      }
    }
  }

////////////////////////////////////////////////////////////////////////////////
//                     Para registrar un nuevo usuario
////////////////////////////////////////////////////////////////////////////////
  Future<Map<String, dynamic>> newUser(
      String email, String password, String houseNumber) async {
    final authData = {
      'email': email,
      'password': password,
      'returnSecureToken': true
    };

    final answer = await http.post(
      'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=$_firebaseToken',
      body: json.encode(authData),
    );

    Map<String, dynamic> decodedAnswer = json.decode(answer.body);

    print(decodedAnswer);
    if (decodedAnswer.containsKey('idToken')) {
      _prefs.token = decodedAnswer['idToken'];
      _createRol(houseNumber, email);
      return {'ok': true, 'token': decodedAnswer['idToken']};
    } else {
      // _createRol(houseNumber, email);
      if (decodedAnswer['error']['message'] == 'EMAIL_EXISTS') {
        lvMessage = "El correo ingresado ya existe";
        return {'ok': false, 'mensaje': lvMessage};
      } else {
        return {'ok': false, 'mensaje': decodedAnswer['error']['message']};
      }
    }
  }
}

void _createRol(String houseNumber, String email) {
  final rolProvider = new RolProvider();
  RolModel rolModel = new RolModel();

  rolModel.mail = email;
  rolModel.rrol = 'U';
  rolModel.rnca = houseNumber;
  rolProvider.createRol(rolModel);
  // vehicleProvider.createPayment(paymentModel);
}

//Contraseña>>> Abc12345

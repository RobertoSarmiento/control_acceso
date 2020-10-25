import 'dart:convert';
// import 'dart:io';

import 'package:control_ingreso/src/models/rol_model.dart';
// import 'package:control_ingreso/src/preferencias_usuario/preferencias_usuario.dart';
import 'package:http/http.dart' as http;
// import 'package:http_parser/http_parser.dart';
// import 'package:mime_type/mime_type.dart';

class RolProvider {
  final String _url = 'https://flutter-varios-7bbe8.firebaseio.com';
  // final _prefs = new PreferenciasUsuario();

////////////////////////////////////////////////////////////////////////////////
//           Método para CREAR un registro en la base de datos                //
////////////////////////////////////////////////////////////////////////////////
  Future<bool> createRol(RolModel rol) async {
    // final url = '$_url/rol.json?auth=${_prefs.token}';
    final url = '$_url/rol.json';
    final answer = await http.post(url, body: rolModelToJson(rol));

    final decodedData = json.decode(answer.body);
    print(decodedData);
    return true;
  }

////////////////////////////////////////////////////////////////////////////////
//           Método para MODIFICAR un registro en la base de datos            //
////////////////////////////////////////////////////////////////////////////////
  // Future<bool> modifyRol(RolModel rol) async {
  //   // final url = '$_url/rol/${rol.id}.json?auth=${_prefs.token}';
  //   final url = '$_url/rol/${rol.id}.json';
  //   final answer = await http.put(url, body: rolModelToJson(rol));

  //   final decodedData = json.decode(answer.body);
  //   print(decodedData);
  //   return true;
  // }

////////////////////////////////////////////////////////////////////////////////
//                      CARGAR información para mostrarla                     //
////////////////////////////////////////////////////////////////////////////////
  Future<List<RolModel>> loadRol(String email) async {
    // final url = '$_url/rol.json?auth=${_prefs.token}';
    final url = '$_url/rol.json';

    //**Petición get
    final answer = await http.get(url);

    //**Se extrae la respuesta
    final Map<String, dynamic> decodedData = json.decode(answer.body);
    final List<RolModel> rols = new List();

    if (decodedData == null) return [];

    //**Se recorre cada posición
    // decodedData.forEach((id, rolDecoded) {
    //   final rolTemp = RolModel.fromJson(rolDecoded);
    //   rolTemp.id = id;
    //   rols.add(rolTemp);
    // });

    decodedData.forEach((id, rolDecoded) {
      final rolTemp = RolModel.fromJson(rolDecoded);

      rolTemp.id = id;
      if (email.toString() == rolTemp.mail.toString()) {
        rols.add(rolTemp);
        print(id);
      }
    });

    //   print(rols);
    return rols;
  }

////////////////////////////////////////////////////////////////////////////////
//                             Metodo para borrar                             //
////////////////////////////////////////////////////////////////////////////////
  Future<int> deleteRol(String id) async {
    // final url = '$_url/rol/$id.json?auth=${_prefs.token}';
    final url = '$_url/rol/$id.json';
    final answer = await http.delete(url);

    print(answer.body);

    return 1;
  }

////////////////////////////////////////////////////////////////////////////////
//                               Subir imágenes                               //
////////////////////////////////////////////////////////////////////////////////
  //**Para el manejo de imágenes
  // Future<String> uploadImage(File image) async {
  //   final url = Uri.parse(
  //       'https://api.cloudinary.com/v1_1/dwubwocfc/image/upload?upload_preset=mfvfrgj6');
  //   final mimeType = mime(image.path).split('/'); //image/jpeg

  //   final imageUploadRequest = http.MultipartRequest('POST', url);
  //   final file = await http.MultipartFile.fromPath(
  //     'file',
  //     image.path,
  //     contentType: MediaType(mimeType[0], mimeType[1]),
  //   );
  //   imageUploadRequest.files.add(file);

  //   final streamResponse = await imageUploadRequest.send();
  //   final answer = await http.Response.fromStream(streamResponse);
  //   if (answer.statusCode != 200 && answer.statusCode != 201) {
  //     print('Error al subir imagen, intente más tarde');
  //     print(answer.body);
  //     return null;
  //   }

  //   final respData = json.decode(answer.body);
  //   print(respData);
  //   return respData['secure_url'];
  // }

// This
// is
// the
// END
}

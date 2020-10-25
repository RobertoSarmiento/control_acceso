import 'dart:convert';
import 'dart:io';
import 'package:control_ingreso/src/models/payment_model.dart';
// import 'package:control_ingreso/src/preferencias_usuario/preferencias_usuario.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:mime_type/mime_type.dart';

class PaymentProvider {
  final String _url = 'https://flutter-varios-7bbe8.firebaseio.com';
  // final _prefs = new PreferenciasUsuario();

////////////////////////////////////////////////////////////////////////////////
//           Método para crear un registro en la base de datos                //
////////////////////////////////////////////////////////////////////////////////
  Future<bool> createPayment(PaymentModel payment) async {
    // final url = '$_url/pago.json?auth=${_prefs.token}';
    final url = '$_url/pago.json';
    final answer = await http.post(url, body: paymentModelToJson(payment));

    final decodedData = json.decode(answer.body);
    print(decodedData);
    return true;
  }

////////////////////////////////////////////////////////////////////////////////
//           Método para modificar un registro en la base de datos            //
////////////////////////////////////////////////////////////////////////////////
  Future<bool> modifyPayment(PaymentModel payment) async {
    // final url = '$_url/pago/${payment.id}.json?auth=${_prefs.token}';
    final url = '$_url/pago/${payment.id}.json';
    final answer = await http.put(url, body: paymentModelToJson(payment));

    final decodedData = json.decode(answer.body);
    print(decodedData);
    return true;
  }

////////////////////////////////////////////////////////////////////////////////
//                      Cargar información para mostrarla                     //
////////////////////////////////////////////////////////////////////////////////
  Future<List<PaymentModel>> loadPayment() async {
    // final url = '$_url/pago.json?auth=${_prefs.token}';
    final url = '$_url/pago.json';

    //**Petición get
    final answer = await http.get(url);

    //**Se extrae la respuesta
    final Map<String, dynamic> decodedData = json.decode(answer.body);
    final List<PaymentModel> payments = new List();

    if (decodedData == null) return [];

    //**Se recorre cada posición
    decodedData.forEach((id, paymentDecoded) {
      final paymentTemp = PaymentModel.fromJson(paymentDecoded);
      paymentTemp.id = id;
      payments.add(paymentTemp);
    });

    print(payments);
    return payments;
  }

////////////////////////////////////////////////////////////////////////////////
//                             Metodo para borrar                             //
////////////////////////////////////////////////////////////////////////////////
  Future<int> deletePayment(String id) async {
    // final url = '$_url/pago/$id.json?auth=${_prefs.token}';
    final url = '$_url/pago/$id.json';
    final answer = await http.delete(url);

    print(answer.body);

    return 1;
  }

////////////////////////////////////////////////////////////////////////////////
//                               Subir imágenes                               //
////////////////////////////////////////////////////////////////////////////////
  //**Para el manejo de imágenes
  Future<String> uploadImage(File image) async {
    final url = Uri.parse(
        'https://api.cloudinary.com/v1_1/dwubwocfc/image/upload?upload_preset=mfvfrgj6');
    final mimeType = mime(image.path).split('/'); //image/jpeg

    final imageUploadRequest = http.MultipartRequest('POST', url);
    final file = await http.MultipartFile.fromPath(
      'file',
      image.path,
      contentType: MediaType(mimeType[0], mimeType[1]),
    );
    imageUploadRequest.files.add(file);

    final streamResponse = await imageUploadRequest.send();
    final answer = await http.Response.fromStream(streamResponse);
    if (answer.statusCode != 200 && answer.statusCode != 201) {
      print('Error al subir imagen, intente más tarde');
      print(answer.body);
      return null;
    }

    final respData = json.decode(answer.body);
    print(respData);
    return respData['secure_url'];
  }

// This
// is
// the
// END
}

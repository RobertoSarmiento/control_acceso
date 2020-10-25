import 'dart:convert';
import 'dart:io';
import 'package:control_ingreso/src/models/producto_model.dart';
import 'package:control_ingreso/src/preferencias_usuario/preferencias_usuario.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:mime_type/mime_type.dart';

class ProdutosProvider {
  final String _url = 'https://flutter-varios-7bbe8.firebaseio.com';
  final _prefs = new PreferenciasUsuario();

  //**Método para crear un registro en la base de datos
  Future<bool> crearProducto(ProductoModel producto) async {
    final url = '$_url/producto.json?auth=${_prefs.token}';
    final resp = await http.post(url, body: productoModelToJson(producto));

    final decodedData = json.decode(resp.body);
    print(decodedData);
    return true;
  }

  //**Método para modificar un producto
  Future<bool> editarProducto(ProductoModel producto) async {
    final url = '$_url/producto/${producto.id}.json?auth=${_prefs.token}';
    final resp = await http.put(url, body: productoModelToJson(producto));

    final decodedData = json.decode(resp.body);
    print(decodedData);
    return true;
  }

  //**Retorna una lista de ProductoModel
  Future<List<ProductoModel>> cargarProductos() async {
    final url = '$_url/producto.json?auth=${_prefs.token}';

    //**Petición get
    final resp = await http.get(url);

    //Se extrae la respuesta
    final Map<String, dynamic> decodedData = json.decode(resp.body);
    final List<ProductoModel> productos = new List();

    // print(decodedData);
    if (decodedData == null) return [];

    //**Se recorre cada posición
    decodedData.forEach((id, prod) {
      final prodTemp = ProductoModel.fromJson(prod);
      prodTemp.id = id;
      productos.add(prodTemp);
      // print(id);
      // print(prod);
    });

    print(productos);
    return productos;
  }

  /*Método para borrar */
  Future<int> borrarProducto(String id) async {
    final url = '$_url/producto/$id.json?auth=${_prefs.token}';
    final resp = await http.delete(url);

    print(resp.body);
    return 1;
  }

  //**Para el manejo de imágenes
  Future<String> subirImagen(File imagen) async {
    final url = Uri.parse(
        'https://api.cloudinary.com/v1_1/dwubwocfc/image/upload?upload_preset=mfvfrgj6');
    final mimeType = mime(imagen.path).split('/'); //image/jpeg

    final imageUploadRequest = http.MultipartRequest('POST', url);

    final file = await http.MultipartFile.fromPath(
      'file',
      imagen.path,
      contentType: MediaType(mimeType[0], mimeType[1]),
    );
    imageUploadRequest.files.add(file);

    final streamResponse = await imageUploadRequest.send();
    final resp = await http.Response.fromStream(streamResponse);
    if (resp.statusCode != 200 && resp.statusCode != 201) {
      print('Error al subir imagen, intente más tarde');
      print(resp.body);
      return null;
    }

    final respData = json.decode(resp.body);
    print(respData);
    return respData['secure_url'];
  }

//
//
// This
// is
// the
// END
}

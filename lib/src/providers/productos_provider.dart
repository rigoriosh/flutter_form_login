import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_form_login/src/pages/page_login.dart';
import 'package:flutter_form_login/src/preferencias_usuario/preferencias_usuario.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_form_login/src/modelos/producto_model.dart';
import 'package:mime_type/mime_type.dart';
import 'package:http_parser/http_parser.dart';

class ProductosProvider {
  static final _prefs = new PreferenciasUsuario();
  //se debe agregar credenciales propiuas de firebase
  final String _urlBase =
      "https://flutter-varius-de545.firebaseio.com/productos";
  final String _urlJson =
      "https://flutter-varius-de545.firebaseio.com/productos.json?auth=${_prefs.token}";

  Future<bool> crearProducto(ProductoModel producto) async {
    final respuesta =
        await http.post(_urlJson, body: productoModelToJson(producto));

    final decodificarData = json.decode(respuesta.body);

    //print(decodificarData);
    return true;
  }

  Future<bool> editProducto(ProductoModel producto) async {
    final strinfUrl = '$_urlBase/${producto.id}.json';

    final respuesta =
        await http.put(strinfUrl, body: productoModelToJson(producto));
    final decodificarData = json.decode(respuesta.body);
    return true;
  }

  Future<List<ProductoModel>> traerProductoDB(BuildContext context) async {
    final respuestaDB = await http.get(_urlJson);
    final Map<String, dynamic> decodificarData = json.decode(respuestaDB.body);

    if ((respuestaDB.statusCode == 401)) {
      //mostrarAlerta(context, decodificarData["error"]);
      Navigator.pushReplacementNamed(context, LoginPage.routName);
      //Navigator.pop(context);
      //Navigator.pushNamed(context, LoginPage.routName);
      return [];
    } else {
      final List<ProductoModel> listaProductos = new List();
      if (decodificarData == null) return [];

      decodificarData.forEach((id, productoJson) {
        final productTemp = ProductoModel.fromJson(productoJson);
        productTemp.id = id;
        listaProductos.add(productTemp);
      });
      return listaProductos;
    }
  }

  Future<bool> deleteProducto(String id) async {
    final respuestaDB =
        await http.delete('$_urlBase/$id.json?auth=${_prefs.token}');

    //print(json.decode(respuestaDB.body));

    return true;
  }

  Future<String> subirImagen(File imagen) async {
    final url = Uri.parse(
        'https://api.cloudinary.com/v1_1/du3ukdjyc/image/upload?upload_preset=tjxkyskd&');
    final tipoDeImagen =
        mime(imagen.path).split('/'); //identifica el tipo de imagen
    final peticionSubirImagen = http.MultipartRequest('POST', url);
    final archivo = await http.MultipartFile.fromPath('file', imagen.path,
        contentType: MediaType(tipoDeImagen[0], tipoDeImagen[1]));
    peticionSubirImagen.files.add(archivo);

    final streamResponse = await peticionSubirImagen.send();

    final respuesta = await http.Response.fromStream(streamResponse);

    if (respuesta.statusCode != 200 && respuesta.statusCode != 201) {
      print('Algo salio mal');
      print(respuesta.body);
      return null;
    }

    final respData = json.decode(respuesta.body);

    return respData['secure_url'];
  }
}

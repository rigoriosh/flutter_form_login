





import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter_form_login/src/modelos/producto_model.dart';

class ProductosProvider {
  
  //final String _url = "https://flutter-varius-de545.firebaseio.com";
  final String _url = "https://flutter-varius-de545.firebaseio.com/productos.json";

  Future<bool> crearProducto(ProductoModel producto) async{
        

    final respuesta = await http.post(_url, body: productoModelToJson(producto));

    final decodificarData = json.decode(respuesta.body);

    print(decodificarData);
    return true;
  }

  Future<List<ProductoModel>> traerProductoDB()async{
    final respuestaDB = await http.get(_url);
    final Map<String, dynamic> decodificarData = json.decode(respuestaDB.body);
    final List<ProductoModel> listaProductos = new List();
    if(decodificarData == null) return [];

    decodificarData.forEach((id, productoJson){
      print("///////////productos_provider.dart///////////");
      final productTemp = ProductoModel.fromJson(productoJson);
      productTemp.id = id;
      print(productTemp.toJson());
      print("//////////////////////");
      listaProductos.add(productTemp);
    });
    return listaProductos;
  }


}
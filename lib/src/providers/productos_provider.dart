





import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter_form_login/src/modelos/producto_model.dart';

class ProductosProvider {
  
  final String _urlBase = "https://flutter-varius-de545.firebaseio.com/productos";
  final String _urlJson = "https://flutter-varius-de545.firebaseio.com/productos.json";

  Future<bool> crearProducto(ProductoModel producto) async{        

    final respuesta = await http.post(_urlJson, body: productoModelToJson(producto));

    final decodificarData = json.decode(respuesta.body);

    print(decodificarData);
    return true;
  }

  Future<bool> editProducto(ProductoModel producto) async{    
    final respuesta = await http.put('${_urlBase}/${producto.id}.json', body: productoModelToJson(producto));
    final decodificarData = json.decode(respuesta.body);
    return true;
  }

  Future<List<ProductoModel>> traerProductoDB()async{
    final respuestaDB = await http.get(_urlJson);
    final Map<String, dynamic> decodificarData = json.decode(respuestaDB.body);
    final List<ProductoModel> listaProductos = new List();
    if(decodificarData == null) return [];

    decodificarData.forEach((id, productoJson){    
      final productTemp = ProductoModel.fromJson(productoJson);
      productTemp.id = id;      
      listaProductos.add(productTemp);
    });
    return listaProductos;
  }  

  Future<bool> deleteProducto(String id) async{

    final respuestaDB = await http.delete('$_urlBase/$id.json');

    print(json.decode(respuestaDB.body));

    return true;
  }


}
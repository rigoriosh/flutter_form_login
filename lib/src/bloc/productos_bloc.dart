import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:rxdart/rxdart.dart';
import 'package:flutter_form_login/src/providers/productos_provider.dart';
import 'package:flutter_form_login/src/modelos/producto_model.dart';

class ProductoBloc {
  
  final _productosController = new BehaviorSubject<List<ProductoModel>>();
  final _cargandoController = new BehaviorSubject<bool>();

  final _productosProvider = new ProductosProvider();

  Stream<List<ProductoModel>> get productosStream => _productosController.stream; 
  Stream<bool> get cargandoStream => _cargandoController.stream; 

  Future<void> cargarProductos(BuildContext context) async {
    final productos = await _productosProvider.traerProductoDB(context);
    _productosController.sink.add(productos);
  }

  agregarProducto(ProductoModel producto) async {
    _cargandoController.sink.add(true);
    await _productosProvider.crearProducto(producto);
    _cargandoController.sink.add(false);
  }

  editarProducto(ProductoModel producto) async {
    _cargandoController.sink.add(true);
    await _productosProvider.editProducto(producto);
    _cargandoController.sink.add(false);
  }

  borrarProducto(String id) async {    
    await _productosProvider.deleteProducto(id);    
  }

  Future<String> sibirFoto(File foto) async {

    _cargandoController.sink.add(true);
    final fotoUrl = await _productosProvider.subirImagen(foto);
    _cargandoController.sink.add(false);
    return fotoUrl;
  }


  dispose(){
    _productosController?.close();
    _cargandoController?.close();
  }
  


}
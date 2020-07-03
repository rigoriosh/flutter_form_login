import 'dart:js';

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

  void cargarProductos(BuildContext context){
    final productos = _productosProvider.traerProductoDB(context);
  }


  dispose(){
    _productosController?.close();
    _cargandoController?.close();
  }
  


}
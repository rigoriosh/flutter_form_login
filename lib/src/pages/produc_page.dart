import 'package:flutter/material.dart';
import 'package:flutter_form_login/src/modelos/producto_model.dart';
import 'package:flutter_form_login/src/utils.dart' as utils;

class ProductoPage extends StatefulWidget {
  //const ProductoPage({Key key}) : super(key: key);
  static final routname = 'paginaProducto';

  @override
  _ProductoPageState createState() => _ProductoPageState();
}

class _ProductoPageState extends State<ProductoPage> {
  final myFormKey = GlobalKey<FormState>();
  ProductoModel modeloProducto = new ProductoModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Producto'),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.photo_size_select_actual), onPressed: () {}),
          IconButton(icon: Icon(Icons.camera_alt), onPressed: () {}),
        ],
      ),
      body: SingleChildScrollView(
        //controller: controller,
        child: Container(
          padding: EdgeInsets.all(15.0),
          child: Form(
              key: myFormKey,
              child: Column(
                children: <Widget>[
                  _crearNombre(),
                  _crearPrecio(),
                  _crearDisponible(),
                  _btnSubmit(),
                ],
              )),
        ),
      ),
    );
  }

  Widget _crearDisponible() {
    return SwitchListTile(
      title: Text('Disponibe'),
      value: modeloProducto.disponible,      
      onChanged: (value){
        setState(() {
          modeloProducto.disponible = value;
        });
      },
      activeColor: Colors.purple,
      );
  }

  Widget _btnSubmit() {
    return Container(
      padding: EdgeInsets.only(top: 10.0),
      child: RaisedButton.icon(
          label: Text('Guardar'),
          icon: Icon(Icons.save),
          /* child: Container(
            padding: EdgeInsets.symmetric(horizontal: 80.0, vertical: 15.0),
            child: Text('Ingresar'),
          ), */
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
          elevation: 5.0,
          color: Colors.deepPurple,
          textColor: Colors.white,
          onPressed: _submint),
    );
  }

  void _submint() {
    if (!myFormKey.currentState.validate())
      return; // if the form is not valid return false, else continue whit code below
    //Action to developem whuend the form is ok
    print('all ok');
    myFormKey.currentState.save(); //ejecute all saves of fields.
    print(modeloProducto.titulo);
    print(modeloProducto.valor);
    print(modeloProducto.disponible);
  }

  Widget _crearNombre() {
    return TextFormField(
      initialValue: modeloProducto.titulo,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(labelText: 'Producto'),
      validator: (elTextoIngresado) {
        return (elTextoIngresado.length < 3)
            ? 'Ingrese el nombre del producto'
            : null;
      },
      onSaved: (elTextoIngresado) => modeloProducto.titulo = elTextoIngresado,
    );
  }

  Widget _crearPrecio() {
    return TextFormField(
      initialValue: modeloProducto.valor.toString(),
      keyboardType: TextInputType.numberWithOptions(decimal: true),
      decoration: InputDecoration(labelText: 'Precio'),
      validator: (numeroIngresado) {
        return utils.isNumeric(numeroIngresado)
            ? null
            : 'Ingerse un número valido';
      },
      onSaved: (numeroIngresado) =>
          modeloProducto.valor = double.parse(numeroIngresado),
    );
  }
}

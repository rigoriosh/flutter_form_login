import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter_form_login/src/modelos/producto_model.dart';
import 'package:flutter_form_login/src/providers/productos_provider.dart';
import 'package:flutter_form_login/src/utils.dart' as utils;
import 'package:image_picker/image_picker.dart';

class ProductoPage extends StatefulWidget {
  //const ProductoPage({Key key}) : super(key: key);
  static final routname = 'paginaProducto';

  @override
  _ProductoPageState createState() => _ProductoPageState();
}

class _ProductoPageState extends State<ProductoPage> {
  final myFormKey = GlobalKey<FormState>();
  final myScaffoldKey = GlobalKey<ScaffoldState>();
  ProductoModel modeloProducto = new ProductoModel();
  bool _guardando = false;
  File foto;

  @override
  Widget build(BuildContext context) {
    final ProductoModel prodData = ModalRoute.of(context)
        .settings
        .arguments; //carga la data enviada como argumentos
    if (prodData != null) {
      modeloProducto = prodData;
    }
    return Scaffold(
      key: myScaffoldKey,
      appBar: AppBar(
        title: Text('Producto'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.photo_size_select_actual),
            onPressed: _seleccionarFoto,
          ),
          IconButton(
            icon: Icon(Icons.camera_alt),
            onPressed: _tomarFoto,
          ),
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
                  _mostrarFoto(),
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

  _seleccionarFoto() async {
    // ignore: deprecated_member_use
    foto = await ImagePicker.pickImage(source: ImageSource.gallery);

    if (foto != null) {
      //TODO:limpieza
    }
    setState(() {});
  }

  Widget _mostrarFoto() {
    if (modeloProducto.fotoUrl != null) {
      //TODO: tengo que ajustar esto
      return Container();
    } else {
      return Image(
        image: AssetImage(foto?.path??'images/noImage.png'),//si foto no es null toma el path, si no toma la imagen por defecto
        height: 300.0,
        fit: BoxFit.cover,
      );
    }
  }

  _tomarFoto() {}

  void mostrarSnackBar(String msm) {
    final snackbar = SnackBar(
      content: Text(msm),
      duration: Duration(milliseconds: 1500),
    );

    myScaffoldKey.currentState.showSnackBar(snackbar);
  }

  Widget _crearDisponible() {
    return SwitchListTile(
      title: Text('Disponibe'),
      value: (modeloProducto.disponible == null)
          ? false
          : modeloProducto.disponible,
      onChanged: (value) {
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
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
          elevation: 5.0,
          color: Colors.deepPurple,
          textColor: Colors.white,
          onPressed: (_guardando) ? null : _submint),
    );
  }

  void _submint() {
    if (!myFormKey.currentState.validate())
      return; // if the form is not valid return false, else continue whit code below
    //Action to developem whuend the form is ok
    myFormKey.currentState.save(); //ejecute all saves of the fields.
    final productosProvider = new ProductosProvider();
    _guardando = true;

    if (modeloProducto.id == null) {
      productosProvider.crearProducto(modeloProducto);
      mostrarSnackBar("Succesful saved product");
    } else {
      productosProvider.editProducto(modeloProducto);
      mostrarSnackBar("Succesful edited product");
    }
    setState(() {});
    Navigator.pop(context);
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

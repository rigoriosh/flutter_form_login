import 'package:flutter/material.dart';
import 'package:flutter_form_login/src/bloc/provider.dart';
import 'package:flutter_form_login/src/modelos/producto_model.dart';
import 'package:flutter_form_login/src/pages/produc_page.dart';
import 'package:flutter_form_login/src/providers/productos_provider.dart';

class HomePage extends StatelessWidget {
  static final String routeName = 'ajustes';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('pagina home'),
      ),
      body: _productodDB(),
      floatingActionButton: _crearBoton(context),
    );
  }

  Widget _productodDB() {
    return FutureBuilder(
      future: ProductosProvider().traerProductoDB(),
      builder:
          (BuildContext context, AsyncSnapshot<List<ProductoModel>> snapshot) {
        if (snapshot.hasData) {
          print("///////page_home");
          print(snapshot.data);
          final data = snapshot.data;
          return ListView.builder(
            itemCount: data.length,
            /* itemBuilder: (BuildContext context , int item){
              return _mostrarProducto(data[item]);
            } */
            itemBuilder: (BuildContext context, int i) =>
                _mostrarProducto(data[i], context),
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  Widget _mostrarProducto(ProductoModel data, BuildContext context) {
    return Dismissible(
      child: ListTile(
        title: Text('${data.titulo} - ${data.valor}'),
        subtitle: Text('${data.id}'),
        onTap: () => Navigator.pushNamed(context, ProductoPage.routname,
            arguments: data),
      ),
      key: UniqueKey(),
      background: Container(
        color: Colors.red,
      ),
      onDismissed: (direccion){
        //TODO: Borrar producto
      },
    );
  }

  Widget _crearBoton(BuildContext context) {
    return FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Colors.deepPurple,
        onPressed: () {
          Navigator.pushNamed(context, ProductoPage.routname);
        });
  }

  Widget body1(BuildContext context) {
    final bloc = Provider.de(context);
    return Container(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        //crossAxisAlignment: CrossAxisAlignment.center,
        //crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text('Email: ${bloc.email}'),
          Divider(),
          Text('Password: ${bloc.password}'),
        ],
      ),
    );
  }
}

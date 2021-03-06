import 'package:flutter/material.dart';
import 'package:flutter_form_login/src/bloc/provider.dart';
import 'package:flutter_form_login/src/modelos/producto_model.dart';
import 'package:flutter_form_login/src/pages/page_login.dart';
import 'package:flutter_form_login/src/pages/produc_page.dart';

class HomePage extends StatelessWidget {
  static final String routeName = 'home';
  @override
  Widget build(BuildContext context) {
    final productoBloc = Provider.productosBloc(context);
    productoBloc.cargarProductos(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('pagina home'),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.power_settings_new,
            ),
            onPressed: () {
              Navigator.pushReplacementNamed(context, LoginPage.routName);
            },
          )
        ],
      ),
      body: _productodDB(context, productoBloc),
      floatingActionButton: _crearBoton(context),
    );
  }

  Widget _productodDB(BuildContext context, ProductoBloc pb) {
    return StreamBuilder(
        stream: pb.productosStream,
        builder: (BuildContext context,
            AsyncSnapshot<List<ProductoModel>> snapshot) {
          if (snapshot.hasData) {
            final data = snapshot.data;
            return ListView.builder(
              itemCount: data.length,
              /* itemBuilder: (BuildContext context , int item){
              return _mostrarProducto(data[item]);
            } */
              itemBuilder: (BuildContext context, int i) =>
                  _mostrarProducto(data[i], context, pb),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }

  Widget _mostrarProducto(
      ProductoModel data, BuildContext context, ProductoBloc pb) {
    return Dismissible(
      child: _listarProductos(data, context),
      key: UniqueKey(),
      background: Container(
        color: Colors.red,
      ),
      onDismissed: (direccion) {
        //ProductosProvider().deleteProducto(data.id);
        pb.borrarProducto(data.id);
      },
    );
  }

  Widget _listarProductos(ProductoModel data, BuildContext context) {
    return Card(
      elevation: 15.0,
      child: Column(
        children: <Widget>[
          (data.fotoUrl == null)
              ? Image(
                  image: AssetImage('images/noImage.png'),
                  height: 250.0,
                  fit: BoxFit.cover,
                  width: double.infinity)
              : FadeInImage(
                  placeholder: AssetImage('images/loading.gif'),
                  image: NetworkImage(data.fotoUrl),
                  height: 250.0,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
          ListTile(
            title: Text('${data.titulo} - ${data.valor}'),
            subtitle: Text('${data.id}'),
            onTap: () => Navigator.pushNamed(context, ProductoPage.routname,
                arguments: data),
          ),
          Divider()
        ],
      ),
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

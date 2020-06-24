import 'package:flutter/material.dart';
import 'package:flutter_form_login/src/bloc/provider.dart';
import 'package:flutter_form_login/src/pages/produc_page.dart';

class HomePage extends StatelessWidget {
  static final String routeName = 'ajustes';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('pagina home'),
      ),
      body: Container(),
      floatingActionButton: _crearBoton(context),
    );
  }

  Widget _crearBoton(BuildContext context){
    return FloatingActionButton(
      child: Icon(Icons.add),
      backgroundColor: Colors.deepPurple,
      onPressed: (){
        Navigator.pushNamed(context, ProductoPage.routname);
      }
      );
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

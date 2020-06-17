









import 'package:flutter/material.dart';
import 'package:flutter_form_login/src/bloc/provider.dart';

class HomePage extends StatelessWidget {
  static final String routeName = 'ajustes';
  @override
  Widget build(BuildContext context) {
    final bloc = Provider.de(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('pagina home'),
      ),
      body: Container(
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
      ),
    );
  }
}























import 'package:flutter/material.dart';
import 'package:flutter_form_login/src/bloc/login_bloc.dart';
export 'package:flutter_form_login/src/bloc/login_bloc.dart';

class Provider extends InheritedWidget {

///Esto para persistir informacion de tipo cache
  static Provider _instanciaInicial;

  //factory constructor
  factory Provider({Key key, Widget child}){// con este factori se determina si se debe emplear la instacia ya exixtente o la instancia inicial
    if (_instanciaInicial == null) {
      _instanciaInicial = new Provider._internal(key: key, child: child);// se debe construir un constructor privado para prevenir que se puededa inicializar esta clase desde afuera
    }  
    return _instanciaInicial;
  }

  Provider._internal({Key key, Widget child}) : super(key: key, child: child);

  ///Esto para persistir informacion de tipo cache /*FIN*/

  final loginBloc = LoginBloc();

  

  //Provider({Key key, Widget child}) : super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;
  

  static LoginBloc de (BuildContext context) {    
    return context.dependOnInheritedWidgetOfExactType<Provider>().loginBloc;
  }

  
}
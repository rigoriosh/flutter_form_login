





















import 'package:flutter/material.dart';
import 'package:flutter_form_login/src/bloc/login_bloc.dart';
export 'package:flutter_form_login/src/bloc/login_bloc.dart';

class Provider extends InheritedWidget {

  final loginBloc = LoginBloc();

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  Provider({Key key, Widget child}) : super(key: key, child: child);

  static LoginBloc de (BuildContext context) {    
    return context.dependOnInheritedWidgetOfExactType<Provider>().loginBloc;
  }

  
}
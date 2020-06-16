






























import 'dart:async';

import 'package:flutter_form_login/src/bloc/validators.dart';

class LoginBloc with Validaciones{
  
  final _emailController    = StreamController<String>.broadcast();
  final _passwordController = StreamController<String>.broadcast();

  //Recuperar los datos del stream
  Stream<String> get emailStream    => _emailController.stream;
  Stream<String> get passwordStream => _passwordController.stream.transform(validarPassword);

  //Insertar valores al stream
  Function(String) get changeEmail    => _emailController.sink.add;
  Function(String) get changePassword => _passwordController.sink.add;

  dispose(){
    _emailController?.close();//si no esta nulo ejecuta el metodo close
    _passwordController?.close();
  }


}
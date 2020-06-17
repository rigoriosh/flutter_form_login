






























import 'dart:async';

import 'package:flutter_form_login/src/bloc/validators.dart';
//import 'package:observable/observable.dart';
import 'package:rxdart/rxdart.dart';

class LoginBloc with Validaciones{
  
  final _emailController    = BehaviorSubject<String>();
  final _passwordController = BehaviorSubject<String>();

  //Recuperar los datos del stream
  Stream<String> get emailStream    => _emailController.stream.transform(validarEmail);
  Stream<String> get passwordStream => _passwordController.stream.transform(validarPassword);

  //CombineLatestStream.

  /* Stream<bool> get formValidStream => 
                        Observable.combineLates2(emailStream, passwordStream, (e, p) => true); */

  Stream<bool> get formValidStream =>  Rx.combineLatest2(emailStream, passwordStream, (e, p) => true);

  


  //Insertar valores al stream
  Function(String) get changeEmail    => _emailController.sink.add;
  Function(String) get changePassword => _passwordController.sink.add;

  dispose(){
    _emailController?.close();//si no esta nulo ejecuta el metodo close
    _passwordController?.close();
  }

  //obtener últimos valores ingresados a los strings
  String get email  => _emailController.value;
  String get password  => _passwordController.value;


}
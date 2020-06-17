











import 'dart:async';

class Validaciones{
  
  final validarPassword = StreamTransformer<String, String>.fromHandlers(
    handleData: (password, sink){
      if (password.length >= 6) {
        sink.add(password);
      } else {
        sink.addError('Should be more that six chartares');
      }
    }
  );

  final validarEmail = StreamTransformer<String, String>.fromHandlers(
    handleData: (email, sink){

      Pattern pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
      RegExp regExpre = new RegExp(pattern);

      if (regExpre.hasMatch(email)) {
        sink.add(email);
      } else {
        sink.addError('Email no correcto');
      }
      

    }
  );
}
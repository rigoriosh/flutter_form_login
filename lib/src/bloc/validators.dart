











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
      if (email.length >= 6) {
        sink.add(email);
      } else {
        sink.addError('Should be more that six chartares');
      }
    }
  );
}
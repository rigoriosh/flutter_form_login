import 'package:flutter/material.dart';

bool isNumeric(String s) {
  if (s.isEmpty) return false;
  final n = num.tryParse(s);
  return (n == null) ? false : true;
}

void mostrarAlerta(BuildContext context, String msm) {
  showDialog(
    context: context,
    builder: (context){
      return AlertDialog(
        title: Text("Alerta"),
        content: Text(msm),
        actions: <Widget>[
          FlatButton(
            child: Text('ok'),
            onPressed: ()=>Navigator.of(context).pop(),)
        ],
      );
    }
    );
}

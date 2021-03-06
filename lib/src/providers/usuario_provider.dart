import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_form_login/src/preferencias_usuario/preferencias_usuario.dart';
import 'package:http/http.dart' as http;

class UsuarioProvider {
  final String _token = "AIzaSyCPPNSZshpPH_GEcyGI4WILi8jSYIG5R4Y";
  final _prefers = new PreferenciasUsuario();

  Future<Map<String, dynamic>> login(
      String email, String password, BuildContext context) async {
    final url =
        "https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=";
    final authData = {
      'email': email,
      'password': password,
      'returnSecureToken': true
    };

    final resp = await http.post(url + _token, body: jsonEncode(authData));

    Map<String, dynamic> decodedResp = json.decode(resp.body);

    if (decodedResp.containsKey('idToken')) {
      _prefers.token = decodedResp['idToken'];
      return {'ok': true, 'tokrn': decodedResp['idToken']};
    } else {
      return {'ok': false, 'mensaje': decodedResp['error']['message']};
    }
  }

  Future<Map<String, dynamic>> nuevoUsuario(
      String email, String password) async {
    String url =
        "https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=";
    final authData = {
      'email': email,
      'password': password,
      'returnSecureToken': true
    };

    final resp = await http.post(url + _token, body: jsonEncode(authData));

    Map<String, dynamic> decodedResp = json.decode(resp.body);

    if (decodedResp.containsKey('idToken')) {
      _prefers.token = decodedResp['idToken'];
      return {'ok': true, 'tokrn': decodedResp['idToken']};
    } else {
      return {'ok': false, 'mensaje': decodedResp['error']['message']};
    }
  }
}

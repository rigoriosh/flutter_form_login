import 'package:flutter/material.dart';
import 'package:flutter_form_login/src/bloc/provider.dart';
import 'package:flutter_form_login/src/pages/page_home.dart';
import 'package:flutter_form_login/src/pages/page_login.dart';
import 'package:flutter_form_login/src/pages/page_registro.dart';
import 'package:flutter_form_login/src/pages/produc_page.dart';
import 'package:flutter_form_login/src/preferencias_usuario/preferencias_usuario.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = new PreferenciasUsuario();
  await prefs.initPrefs();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final prefs = new PreferenciasUsuario();

  @override
  Widget build(BuildContext context) {
    return Provider(
      child: myMaterialApp(prefs),
    );
  }

  Widget myMaterialApp(PreferenciasUsuario prefs) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      //initialRoute: prefs.verficarEstado,
      initialRoute:
          (prefs.token.isEmpty) ? LoginPage.routName : HomePage.routeName,
      //initialRoute: !_ingresar?LoginPage.routName:HomePage.routeName,
      //initialRoute: LoginPage.routName,
      routes: {
        LoginPage.routName: (BuildContext context) => LoginPage(),
        HomePage.routeName: (BuildContext context) => HomePage(),
        ProductoPage.routname: (BuildContext context) => ProductoPage(),
        Paginagistro.routname: (BuildContext context) => Paginagistro(),
      },
      theme: ThemeData(primaryColor: Colors.deepPurple),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_form_login/src/bloc/provider.dart';
import 'package:flutter_form_login/src/pages/page_home.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.brown[300],
      body: Stack(
        children: <Widget>[
          _crearFondo(context),
          _loginForm(context),
        ],
      ),
    );
  }

  Widget _crearFondo(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    final fondoMorado = Container(
      height: screenSize.height * 0.4,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [
          Color.fromRGBO(63, 63, 156, 1.0),
          Color.fromRGBO(90, 70, 178, 1.0),
        ]),
      ),
    );

    final circulo = Container(
      width: 100.0,
      height: 100.0,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100.0),
          color: Color.fromRGBO(255, 255, 255, 0.05)),
    );

    return Stack(
      children: <Widget>[
        fondoMorado,
        Positioned(child: circulo, top: 90.0, left: 30.0),
        Positioned(child: circulo, top: -40.0, right: -30.0),
        Positioned(child: circulo, bottom: -50.0, right: -10.0),
        Positioned(child: circulo, bottom: 120.0, right: 20.0),
        Positioned(child: circulo, bottom: -50.0, left: -20.0),
        _logoYnombre(), //Logo y nombre de usuario        
      ],
    );
  }

  Widget _logoYnombre() {
    return Container(
      //color: Color.fromRGBO(0, 255, 0, 0.6), //quitar luego
      padding: EdgeInsets.only(top: 80.0),
      child: Column(
        children: <Widget>[
          Icon(
            Icons.person_pin_circle,
            color: Colors.white,
            size: 100.0,
          ),
          SizedBox(
            //child: Icon(Icons.ac_unit), //quitar
            height: 10.0,
            width: double.infinity,
          ),
          Text(
            'Thiago Emanuel Rios',
            style: TextStyle(
              color: Colors.white,
              fontSize: 25.0,
            ),
          ),
        ],
      ),
    );
  }

  Widget _loginForm(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final bloc = Provider.de(context);
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          SafeArea(
              child: Container(
            height: 00.0,
          )),
          Container(
            //margin: EdgeInsets.symmetric(vertical: 240.0),
            margin: EdgeInsets.only(top: 245.0),
            padding: EdgeInsets.symmetric(vertical: 20.0),
            width: screenSize.width * 0.8,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5.0),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black26,
                      blurRadius: 3.0,
                      offset: Offset(0.0, 5.0),
                      spreadRadius: 3.0),
                ]),
            child: Column(
              children: <Widget>[
                Text(
                  'Ingreso',
                  style: TextStyle(fontSize: 20.0),
                ),
                SizedBox(
                  height: 30.0,
                ),
                _crearEmail(bloc),
                SizedBox(
                  height: 10.0,
                ),
                _crearpassword(bloc),
                SizedBox(
                  height: 10.0,
                ),
                _crearBoton(bloc),
              ],
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          Text("¿Olvido la contraseña?"),
          SizedBox(
            height: 100.0,
          ),
        ],
      ),
    );
  }

  Widget _crearEmail(LoginBloc bloc) {
    return StreamBuilder(
        stream: bloc.emailStream,
        builder: (BuildContext context, AsyncSnapshot snashoot) {
          return Container(
            //decoration: BoxDecoration(color: Colors.yellow),
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: TextField(
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                icon: Icon(
                  Icons.alternate_email,
                  color: Colors.deepPurple,
                ),
                hintText: 'ejemplo@correo.com',
                labelText: 'Correo electrónico',
                counterText: snashoot.data,
                errorText: snashoot.error,
              ),
              onChanged: bloc.changeEmail,
            ),
          );
        });
  }

  Widget _crearpassword(LoginBloc bloc) {
    return StreamBuilder(
        stream: bloc.passwordStream,
        builder: (BuildContext context, AsyncSnapshot snashoot) {
          return Container(
            //decoration: BoxDecoration(color: Colors.blue),
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: TextField(
              obscureText: true,
              keyboardType: TextInputType.numberWithOptions(),
              decoration: InputDecoration(
                icon: Icon(
                  Icons.lock_outline,
                  color: Colors.deepPurple,
                ),
                labelText: 'Contraseña',
                counterText: snashoot.data,
                errorText: snashoot.error,
              ),
              onChanged: bloc.changePassword,
            ),
          );
        });
  }

  Widget _crearBoton(LoginBloc bloc) {
    return StreamBuilder(
        stream: bloc.formValidStream,
        builder: (BuildContext context, AsyncSnapshot snashoot) {
          return RaisedButton(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 80.0, vertical: 15.0),
                child: Text('Ingresar'),
              ),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0)),
              elevation: 5.0,
              color: Colors.deepPurple,
              textColor: Colors.white,
              onPressed: snashoot.hasData ? () => _login(bloc, context) : null
              );
        });
  }

  _login(LoginBloc bloc, BuildContext context){
    print('==========================');
    print('Email: ${bloc.email} ');
    print('password:  ${bloc.password}');
    print('==========================');
    Navigator.pushNamed(context, HomePage.routeName);//Da la opcion de regresar de donde se llamo
    //Navigator.pushReplacementNamed(context, HomePage.routeName);//No Da la opcion de regresar de donde se llamo
  }
}

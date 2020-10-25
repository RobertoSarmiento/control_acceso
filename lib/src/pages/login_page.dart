import 'package:control_ingreso/src/bloc/login_bloc.dart';
import 'package:control_ingreso/src/bloc/provider.dart';
import 'package:control_ingreso/src/providers/usuario_provider.dart';
import 'package:flutter/material.dart';
import 'package:control_ingreso/src/utils/utils.dart' as utils;

class LoginPage extends StatelessWidget {
  final usuarioProvider = new UsuarioProvider();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          _createBackground(context),
          _loginForm(context),
        ],
      ),
    );
  }

////////////////////////////////////////////////////////////////////////////////
//                 Se crea el diseño de fondo de la página                    //
////////////////////////////////////////////////////////////////////////////////
  Widget _createBackground(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final myBackgroundColor = Container(
      height: size.height * 0.4,
      width: double.infinity,
//      color: Colors.teal[300],
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: <Color>[
            Colors.teal,
            Colors.teal[100],
          ],
        ),
      ),
    );

    //Se crean circulos de adorno
    final myDecoration = Container(
      width: 100.0,
      height: 100.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100.0),
        color: Color.fromRGBO(255, 255, 255, 0.07),
      ),
    );

    //Se crean circulos pequeños de adorno
    final mySmallDecoration = Container(
      width: 50.0,
      height: 50.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100.0),
        color: Color.fromRGBO(255, 255, 255, 0.06),
      ),
    );

    //Se agregan los circulos en pantalla
    final paintMyDecoration = Stack(
      children: <Widget>[
        Positioned(top: 90.0, left: 30.0, child: myDecoration),
        Positioned(top: 150.0, left: -10.0, child: myDecoration),
        Positioned(top: 40.0, left: 10.0, child: myDecoration),
        Positioned(top: -10.0, left: 100.0, child: myDecoration),
        Positioned(top: 90.0, left: 150.0, child: myDecoration),
        Positioned(top: 200.0, left: 200.0, child: myDecoration),
        Positioned(top: 300.0, left: 300.0, child: myDecoration),
        Positioned(top: 200.0, left: 260.0, child: myDecoration),
        Positioned(top: 150.0, left: 1280.0, child: myDecoration),
        Positioned(top: 230.0, left: 0.0, child: myDecoration),
      ],
    );

    //Se agregan los circulos pequeños en pantalla
    final paintMySmallDecoration = Stack(
      children: <Widget>[
        Positioned(top: 10.0, left: 15.0, child: mySmallDecoration),
        Positioned(top: 150.0, left: -10.0, child: mySmallDecoration),
        Positioned(top: 200.0, left: 90.0, child: mySmallDecoration),
        Positioned(top: -10.0, left: 100.0, child: mySmallDecoration),
        Positioned(top: 120.0, left: 250.0, child: mySmallDecoration),
        Positioned(top: 200.0, left: 200.0, child: mySmallDecoration),
      ],
    );

    //Se agrega el icono y su texto
    final myIcon = Container(
      padding: EdgeInsets.only(top: 80.0),
      child: Column(
        children: <Widget>[
          Icon(Icons.person_pin_circle, color: Colors.white, size: 100.0),
          SizedBox(
            height: 10.0,
            width: double.infinity,
          ),
          Text(
            'Ingresar:',
            style: TextStyle(color: Colors.white, fontSize: 25.0),
          )
        ],
      ),
    );

    //Devuelve resultados
    return Stack(
      children: <Widget>[
        myBackgroundColor,
        paintMyDecoration,
        paintMySmallDecoration,
        myIcon,
      ],
    );
  }

////////////////////////////////////////////////////////////////////////////////
//                      Se crea el formulario de login                        //
////////////////////////////////////////////////////////////////////////////////
  Widget _loginForm(BuildContext context) {
    final bloc = Provider.of(context);
    final size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          SafeArea(child: Container(height: 180.0)),
          Container(
            width: size.width * 0.85,
            margin: EdgeInsets.symmetric(vertical: 30.0),
            padding: EdgeInsets.symmetric(vertical: 50.0),
            decoration: BoxDecoration(color: Colors.white,
                // borderRadius: BorderRadius.circular(5.0),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 5.0,
                    offset: Offset(5.0, 5.0),
                  )
                ]),
            child: Column(
              children: <Widget>[
                Text('Ingreso', style: TextStyle(fontSize: 20.0)),
                SizedBox(height: 40.0), //60
                _createEmail(bloc),
                SizedBox(height: 40.0), //60
                _createPlateNumber(),
                SizedBox(height: 40.0), //60
                _createPassword(bloc),
                SizedBox(height: 40.0), //60
                _createButton(bloc)
              ],
            ),
          ),
          FlatButton(
            onPressed: () =>
                Navigator.pushReplacementNamed(context, 'registro'),
            child: Text('Crear una nueva cuenta'),
          ),
          SizedBox(
            height: 100.0,
          )
        ],
      ),
    );
  }

  Widget _createEmail(LoginBloc bloc) {
    return StreamBuilder(
      stream: bloc.emailStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: TextField(
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              icon: Icon(Icons.alternate_email, color: Colors.teal),
              hintText: 'nombre@correo.com',
              labelText: 'Correo Electrónico',
              counterText: snapshot.data,
              errorText: snapshot.error,
            ),
            onChanged: (value) => bloc.changeEmail(value),
          ),
        );
      },
    );
  }

  Widget _createPlateNumber() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: TextField(
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          icon: Icon(Icons.aspect_ratio, color: Colors.teal),
          hintText: 'P123ABC',
          labelText: 'Número de placa',
        ),
      ),
    );
  }

  Widget _createPassword(LoginBloc bloc) {
    return StreamBuilder(
      stream: bloc.passwordStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: TextField(
            obscureText: true,
            decoration: InputDecoration(
              icon: Icon(Icons.lock_outline, color: Colors.teal),
              labelText: 'Contraseña',
              counterText: snapshot.data,
              errorText: snapshot.error,
            ),
            onChanged: (value) => bloc.changePassword(value),
          ),
        );
      },
    );

    // return Container(
    //   padding: EdgeInsets.symmetric(horizontal: 20.0),
    //   child: TextField(
    //     obscureText: true,
    //     decoration: InputDecoration(
    //       icon: Icon(Icons.lock_outline, color: Colors.teal),
    //       labelText: 'Contraseña',
    //     ),
    //   ),
    // );
  }

  Widget _createButton(LoginBloc bloc) {
    return StreamBuilder(
      stream: bloc.formValidStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return RaisedButton(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 80.0, vertical: 15.0),
            child: Text('Ingresar'),
          ),
          elevation: 0.0,
          color: Colors.teal,
          textColor: Colors.white,
          onPressed: snapshot.hasData ? () => _login(bloc, context) : null,
        );
      },
    );
  }

  //**Último valor ingresado
  _login(LoginBloc bloc, BuildContext context) async {
    Map info = await usuarioProvider.login(bloc.email, bloc.password);

    if (info['ok']) {
      Navigator.pushReplacementNamed(context, 'home');
    } else {
      utils.mostrarAlerta(context, info['mensaje']);
    }

    // print('==========================');
    // print('Email: ${bloc.email}');
    // print('Password: ${bloc.password}');
    // print('==========================');

    //**Se navega a una nueva página que incluye el botón de regresar
    // Navigator.pushNamed(context, 'home');

    //**Se navega a una nueva página que no incluye el botón de regresar
    // Navigator.pushReplacementNamed(context, 'home');
    // Navigator.pushReplacementNamed(context, 'appHome');
  }

// This
// is
// the
// END
}

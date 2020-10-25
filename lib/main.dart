import 'package:control_ingreso/src/bloc/provider.dart';
import 'package:control_ingreso/src/pages/app_home_app_page.dart';
import 'package:control_ingreso/src/pages/app_home_page.dart';
import 'package:control_ingreso/src/pages/app_house_page.dart';
import 'package:control_ingreso/src/pages/app_login_page.dart';
import 'package:control_ingreso/src/pages/app_payment_page.dart';
import 'package:control_ingreso/src/pages/app_person_page.dart';
import 'package:control_ingreso/src/pages/app_registro_page.dart';
import 'package:control_ingreso/src/pages/app_vehicle_page.dart';
import 'package:control_ingreso/src/pages/home_page.dart';
import 'package:control_ingreso/src/pages/login_page.dart';
import 'package:control_ingreso/src/pages/producto_page.dart';
import 'package:control_ingreso/src/pages/registro_page.dart';
import 'package:control_ingreso/src/preferencias_usuario/preferencias_usuario.dart';
import 'package:flutter/material.dart';

//void main() => runApp(MyApp( ));
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = new PreferenciasUsuario();
  await prefs.initPrefs();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // WidgetsFlutterBinding.ensureInitialized();
    final prefs = new PreferenciasUsuario();
    print(prefs.token);

    return Provider(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        // title: 'Material App',
        // initialRoute: 'login',
        // initialRoute: 'home',
        // initialRoute: 'appLogin',
        // initialRoute: 'appHome',
        initialRoute: 'appHomeApp',
        // initialRoute: 'appHouse',
        // initialRoute: 'appPerson',
        // initialRoute: 'appPayment',
        routes: {
          'login': (BuildContext context) => LoginPage(),
          'registro': (BuildContext context) => RegistroPage(),
          'home': (BuildContext context) => HomePage(),
          'producto': (BuildContext context) => ProductoPage(),
          'appLogin': (BuildContext context) => AppLoginPage(),
          'appRegistro': (BuildContext context) => AppRegistroPage(),
          'appHome': (BuildContext context) => AppHomePage(),
          'appVehicle': (BuildContext context) => AppVehiclePage(),
          'appHouse': (BuildContext context) => AppHousePage(),
          'appPerson': (BuildContext context) => AppPersonPage(),
          'appPayment': (BuildContext context) => AppPaymentPage(),
          'appHomeApp': (BuildContext context) => AppHomeApp(),
          // '': (BuildContext context) => AppHomePage(),
          // '': (BuildContext context) => AppHomePage(),
          // '': (BuildContext context) => AppHomePage(),
          // '': (BuildContext context) => AppHomePage(),
          // '': (BuildContext context) => AppHomePage(),
          // '': (BuildContext context) => AppHomePage(),
          // '': (BuildContext context) => AppHomePage(),
          // '': (BuildContext context) => AppHomePage(),
        },
        theme: ThemeData(primaryColor: Colors.teal),
      ),
    );
  }
}

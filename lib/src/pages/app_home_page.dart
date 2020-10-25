// import 'package:control_ingreso/src/bloc/provider.dart';
// import 'package:control_ingreso/src/models/rol_model.dart';
import 'package:control_ingreso/src/models/vehicle_model.dart';
import 'package:control_ingreso/src/providers/rol_provider.dart';
import 'package:control_ingreso/src/providers/vehicle_provider.dart';
import 'package:flutter/material.dart';

class AppHomePage extends StatefulWidget {
  @override
  _AppHomePageState createState() => _AppHomePageState();
}

class _AppHomePageState extends State<AppHomePage> {
  final vehicleProvider = new VehicleProvider();
  final rolProvider = new RolProvider();
  // String email = '';
  String email = 'admin.cocode@gmail.com';

  @override
  Widget build(BuildContext context) {
    // final bloc = Provider.of(context); //-->Esto es del email y contraseña
    // email = bloc.email;
    return Scaffold(
      appBar: AppBar(title: Text('Inicio')),
      drawer: _createMenu(context),
      body: _createList(),
      floatingActionButton: _createButton(context),
    );
  }

////////////////////////////////////////////////////////////////////////////////
//                      Creación del menú lateral                             //
////////////////////////////////////////////////////////////////////////////////

  Drawer _createMenu(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            padding: EdgeInsets.zero,
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/img/menu/menu05.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Column(
            children: <Widget>[
              _createHouseButton(context),
              Divider(),
              _createCarButton(context),
              Divider(),
              _createPersonButton(context),
              Divider(),
              _createPasswordButton(context),
              Divider(),
              _createPaymentButton(context),
              Divider(),
              _createReportButton(context),
              Divider(),
            ],
          ),
        ],
      ),
    );
  }

////////////////////////////////////////////////////////////////////////////////
//                      Creación de los botones del menú                      //
////////////////////////////////////////////////////////////////////////////////
  Widget _createHouseButton(BuildContext context) {
    return ListTile(
      leading: Icon(Icons.home, color: Colors.teal),
      title: Text('Agregar viviendas'),
      // onTap: () {
      //   Navigator.pop(context);
      // },

      onTap: () {
        Navigator.pop(context);
        Navigator.pushNamed(context, 'appHouse').then((value) {
          setState(() {});
        }); //**onTap Action ends
      },
    );
    // }
  }

  Widget _createCarButton(BuildContext context) {
    return ListTile(
      leading: Icon(Icons.car_rental, color: Colors.teal),
      title: Text('Agregar vehículo'),
      // onTap: () {
      //   Navigator.pop(context);
      // },

      //**onTap Action begins
      onTap: () {
        Navigator.pop(context);
        Navigator.pushNamed(context, 'appVehicle').then((value) {
          setState(() {});
        }); //**onTap Action ends
      },
    );
  }

  Widget _createPersonButton(BuildContext context) {
    return ListTile(
      leading: Icon(Icons.people, color: Colors.teal),
      title: Text('Agregar vecino'),
      // onTap: () {
      //   Navigator.pop(context);
      // },
      onTap: () {
        Navigator.pop(context);
        Navigator.pushNamed(context, 'appPerson').then((value) {
          setState(() {});
        }); //**onTap Action ends
      },
    );
  }

  Widget _createPaymentButton(BuildContext context) {
    return ListTile(
      leading: Icon(Icons.attach_money, color: Colors.teal),
      title: Text('Agregar pago'),
      onTap: () {
        Navigator.pop(context);
        Navigator.pushNamed(context, 'appPayment').then((value) {
          setState(() {});
        }); //**onTap Action ends
      },
    );
  }

  Widget _createPasswordButton(BuildContext context) {
    return ListTile(
      leading: Icon(Icons.lock_open, color: Colors.teal),
      title: Text('Administrar contraseñas'),
      onTap: () {
        Navigator.pop(context);
      },
    );
  }

  Widget _createReportButton(BuildContext context) {
    return ListTile(
      leading: Icon(Icons.list_alt, color: Colors.teal),
      title: Text('Visualizar reporte'),
      onTap: () {
        Navigator.pop(context);
      },
    );
  }

////////////////////////////////////////////////////////////////////////////////
//                                                                            //
////////////////////////////////////////////////////////////////////////////////
  Widget _createList() {
    return FutureBuilder(
      future: vehicleProvider.loadVehicle(),
      builder:
          (BuildContext context, AsyncSnapshot<List<VehicleModel>> snapshot) {
        if (snapshot.hasData) {
          rolProvider.loadRol(email);
          final vehicleData = snapshot.data;
          return ListView.builder(
            itemCount: vehicleData.length,
            itemBuilder: (context, i) => _createItem(context, vehicleData[i]),
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  //**Crea los elementos */
  Widget _createItem(BuildContext context, VehicleModel vehicle) {
    //**Dismissible sirve para eliminar desplazando a los lados
    return Dismissible(
      key: UniqueKey(),
      background: Container(color: Colors.red),
      onDismissed: (direccion) {
        vehicleProvider.deleteVehicle(vehicle.id);
      },
      child: Card(
        child: Column(
          children: <Widget>[
            (vehicle.aurl == null)
                ? Image(image: AssetImage('assets/no-image.png'))
                : FadeInImage(
                    placeholder: AssetImage('assets/jar-loading.gif'),
                    image: NetworkImage(vehicle.aurl),
                    height: 300.0,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
            ListTile(
              title: Text('${vehicle.amar}-${vehicle.apla}'),
              // subtitle: Text(vehicle.id),
              subtitle: Text(email),
              // onTap: () => Navigator.pushNamed(
              //       context,
              //       'appVehicle',
              //       arguments: vehicle,
              //     ))

              onTap: () =>
                  Navigator.pushNamed(context, 'appVehicle', arguments: vehicle)
                      .then(
                (value) {
                  setState(() {});
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  _createButton(BuildContext context) {
    return FloatingActionButton(
      child: Icon(Icons.keyboard_arrow_right_outlined),
      //**onPressed Action begins
      onPressed: () => Navigator.pushNamed(context, 'appVehicle').then((value) {
        setState(() {});
      }), //**onPressed Action ends
      backgroundColor: Colors.teal,
      //
      //
      // onPressed: () => Navigator.pushNamed(context, 'appVehicle'),
    );
  }
}

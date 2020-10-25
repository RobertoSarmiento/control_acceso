import 'package:control_ingreso/src/models/vehicle_model.dart';
import 'package:control_ingreso/src/providers/vehicle_provider.dart';
import 'package:flutter/material.dart';

class BkAppHomePage extends StatefulWidget {
  @override
  _AppHomePageState createState() => _AppHomePageState();
}

class _AppHomePageState extends State<BkAppHomePage> {
  final vehicleProvider = new VehicleProvider();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Inicio App'),
      ),
      body: _createList(),
      floatingActionButton: _createButton(context),
    );
  }

  Widget _createList() {
    return FutureBuilder(
      future: vehicleProvider.loadVehicle(),
      builder:
          (BuildContext context, AsyncSnapshot<List<VehicleModel>> snapshot) {
        if (snapshot.hasData) {
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
              subtitle: Text(vehicle.id),
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
      // onPressed: () => Navigator.pushNamed(context, 'appVehicle'),
      onPressed: () => Navigator.pushNamed(context, 'appVehicle').then((value) {
        setState(() {});
      }),

      backgroundColor: Colors.teal,
    );
  }
}

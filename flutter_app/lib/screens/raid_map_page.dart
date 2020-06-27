import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'package:provider/provider.dart';
import 'package:pogo/providers/raid_provider.dart';

class RaidMapPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var gyms = context.watch<RaidProvider>().gyms;

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Provider.of<RaidProvider>(context, listen: false)
              .addGym(LatLng(0.0, 0.0), 'New Gym');
        },
        child: Icon(Icons.add_location),
      ),
      body: FlutterMap(
        options: MapOptions(
            //TODO Get phone location
            center: gyms?.first?.pos ?? LatLng(51.5074, 0.1278),
            zoom: 13.0,
            onLongPress: (pos) async {
              await _showDialog(context).then((value) => {
                    print(value),
                    if (value != null)
                      {
                        Provider.of<RaidProvider>(context, listen: false)
                            .addGym(pos, value)
                      }
                  });
            }),
        layers: [
          TileLayerOptions(
              urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
              subdomains: ['a', 'b', 'c']),
          MarkerLayerOptions(
              markers: List<Marker>.generate(
            gyms.length,
            (index) {
              return Marker(
                width: 80.0,
                height: 80.0,
                point: gyms[index].pos,
                builder: (ctx) => Container(
                  child: Image.asset('assets/images/GymIcon.png'),
                ),
              );
            },
          )),
        ],
      ),
    );
  }

  Future<String> _showDialog(BuildContext context) async {
    String text;
    await showDialog(
      context: context,
      child: AlertDialog(
        contentPadding: const EdgeInsets.all(16.0),
        content: Row(
          children: <Widget>[
            Expanded(
              child: TextField(
                autofocus: true,
                decoration: InputDecoration(labelText: 'Gym Title'),
                onChanged: (newValue) {
                  text = newValue;
                },
              ),
            )
          ],
        ),
        actions: <Widget>[
          FlatButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.pop(context, null);
              }),
          FlatButton(
              child: const Text('Submit'),
              onPressed: () {
                Navigator.pop(context, text);
              })
        ],
      ),
    );
    return text;
  }
}

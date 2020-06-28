import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart' as coordinates;
import 'package:pogo/models/gym.dart';
import 'package:provider/provider.dart';
import 'package:pogo/providers/raid_provider.dart';
import 'dart:math' as math;

class RaidMapPage extends StatefulWidget {
  @override
  _RaidMapPageState createState() => _RaidMapPageState();
}

class _RaidMapPageState extends State<RaidMapPage> {
  GymInfo gymInfo;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var gyms = context.watch<RaidProvider>().gyms;

    return Scaffold(
      body: Stack(
        children: <Widget>[
          FlutterMap(
            options: MapOptions(
                //TODO Get phone location
                center: gyms?.first?.pos ?? coordinates.LatLng(51.5074, 0.1278),
                zoom: 13.0,
                onTap: (_) {
                  setState(() {
                    gymInfo = null;
                  });
                },
                onLongPress: (pos) async {
                  await _showDialog(context).then((value) => {
                        if (value != null)
                          {
                            Provider.of<RaidProvider>(context, listen: false)
                                .addGym(pos, value)
                          }
                      });
                }),
            layers: [
              TileLayerOptions(
                  urlTemplate:
                      "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                  subdomains: ['a', 'b', 'c']),
              MarkerLayerOptions(
                  markers: List<Marker>.generate(
                gyms.length,
                (index) {
                  return Marker(
                    width: 80.0,
                    height: 80.0,
                    point: gyms[index].pos,
                    builder: (ctx) => GestureDetector(
                      child: Container(
                        child: Image.asset('assets/images/GymIcon.png'),
                      ),
                      onTap: () {
                        setState(() {
                          gymInfo = GymInfo(gym: gyms[index]);
                        });
                      },
                    ),
                  );
                },
              )),
            ],
          ),
        ],
      ),
      bottomSheet: gymInfo,
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

class GymInfo extends StatelessWidget {
  final Gym gym;

  const GymInfo({Key key, this.gym}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          FittedBox(
            child: SizedBox(
                width: 200,
                height: 200,
                child: CustomPaint(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [Text('aaaa'), Text('bbbbbbb')]),
                  painter: PokeBallPainter(),
                )),
          ),
        ],
      ),
    );
  }
}

class PokeBallPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    int outlineThickness = 10;
    Paint paint = Paint()..color = Colors.red;
    // set the color property of the paint
    paint.color = Colors.black;
    // center of the canvas is (x,y) => (width/2, height/2)
    var center = Offset(size.width / 2, size.height / 2);

    // draw the circle on centre of canvas having radius 75.0
    canvas.drawCircle(center, size.width / 2, paint);

    paint = Paint()..color = Colors.red;
    canvas.drawArc(
      Rect.fromCenter(
        center: center,
        height: size.height - outlineThickness,
        width: size.width - outlineThickness,
      ),
      math.pi,
      math.pi,
      false,
      paint,
    );
    paint = Paint()..color = Colors.white;
    canvas.drawArc(
      Rect.fromCenter(
        center: center,
        height: size.height - outlineThickness,
        width: size.width - outlineThickness,
      ),
      -math.pi,
      -math.pi,
      false,
      paint,
    );

    paint.color = Colors.black;
    paint.strokeWidth = 8;

    canvas.drawCircle(center, size.width / 8, paint);

    canvas.drawLine(
        Offset(0, size.height / 2), Offset(size.width, size.height / 2), paint);
    paint.color = Colors.white;
    canvas.drawCircle(center, size.width / 10, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return oldDelegate != this;
  }
}

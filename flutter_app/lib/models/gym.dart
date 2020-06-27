import 'package:pogo/models/raid.dart';
import 'package:latlong/latlong.dart';

class Gym {
  LatLng pos;
  String name;
  Raid raid;
  String gymId;

  Gym(this.pos, this.name, this.raid, this.gymId);
}

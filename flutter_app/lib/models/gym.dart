import 'package:pogo/models/raid.dart';

class Gym {
  double lat;
  double lon;
  String name;
  Raid raid;
  String gymId;

  Gym(this.lat, this.lon, this.name, this.raid, this.gymId);
}

import 'package:pogo/models/raid.dart';
import 'package:latlong/latlong.dart';

class Gym {
  LatLng pos;
  String name;
  Raid raid;
  String gymId;

  Gym(this.pos, this.name, this.raid, this.gymId);

  Gym.fromJson(Map<String, dynamic> json, String id)
      : pos = LatLng(json['lat'] ?? 0, json['lon'] ?? 0),
        name = json['name'],
        raid = (json['raid'] != null) ? Raid.fromJson(json['raid']) : null,
        gymId = id;

  Map<String, dynamic> toJson() => {
        'lat': pos.latitude,
        'lon': pos.longitude,
        'name': name,
        'raid': raid,
      };
}

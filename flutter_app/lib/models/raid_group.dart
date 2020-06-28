import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pogo/models/player.dart';

class RaidGroup {
  DateTime time;
  List<Player> raiders;
  RaidGroup(this.time, this.raiders);

  RaidGroup.fromJson(Map<String, dynamic> json)
      : time = (json['time'] as Timestamp).toDate().toUtc(),
        raiders = List<Map<String, dynamic>>.from(json['raiders'])
            .map((Map<String, dynamic> player) => Player.fromJson(player))
            .toList();

  Map<String, dynamic> toJson() => {
        'time': time,
        'raiders': raiders.map((raider) => raider.toJson()).toList(),
      };
}

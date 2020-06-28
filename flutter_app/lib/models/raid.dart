import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pogo/models/pokemon.dart';
import 'package:pogo/models/raid_group.dart';

class Raid {
  DateTime startTime;
  DateTime endTime;
  int tier;
  Pokemon raidBoss;
  List<RaidGroup> groups;

  Raid(this.startTime, this.endTime, this.tier, this.raidBoss, this.groups);

  Raid.fromJson(Map<String, dynamic> json)
      : startTime = (json['startTime'] as Timestamp)
            .toDate(), //DateTime.tryParse(json['startTime'].toString()),
        endTime = (json['endTime'] as Timestamp)
            .toDate(), //DateTime.tryParse(json['endTime'].toString()),
        tier = json['tier'],
        raidBoss = json['raidBoss'],
        groups = null; //json['groups'];

  Map<String, dynamic> toJson() => {
        'startTime': startTime,
        'endTime': endTime,
        'tier': tier,
        'raidBoss': raidBoss,
        'groups': groups
      };
}

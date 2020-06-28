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
      : startTime = (json['startTime'] as Timestamp).toDate().toUtc(),
        endTime = (json['endTime'] as Timestamp).toDate().toUtc(),
        tier = json['tier'],
        raidBoss = json['raidBoss'],
        groups = List<Map<String, dynamic>>.from(json['groups'])
            .map((Map<String, dynamic> raidGroup) =>
                RaidGroup.fromJson(raidGroup))
            .toList();

  Map<String, dynamic> toJson() => {
        'startTime': startTime,
        'endTime': endTime,
        'tier': tier,
        'raidBoss': raidBoss,
        'groups': groups.map((group) => group.toJson()).toList()
      };
}

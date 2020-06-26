import 'package:pogo/models/pokemon.dart';
import 'package:pogo/models/raid_group.dart';

class Raid {
  DateTime startTime;
  DateTime endTime;
  int tier;
  Pokemon raidBoss;
  List<RaidGroup> groups;

  Raid(this.startTime, this.endTime, this.tier, this.raidBoss, this.groups);
}

import 'package:pogo/models/pokemon.dart';
import 'package:pogo/models/raid_group.dart';

class Raid {
  DateTime startTime;
  DateTime endTime;
  int tier;
  Pokemon raidBoss;
  List<RaidGroup> groups;
}

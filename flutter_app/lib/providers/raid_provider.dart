import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pogo/models/gym.dart';
import 'package:pogo/models/raid.dart';
import 'package:pogo/models/raid_group.dart';
import 'package:latlong/latlong.dart';

class RaidProvider with ChangeNotifier {
  List<Gym> gyms;

  //TODO Backend
  RaidProvider() {
    gyms = [];
  }

  reportRaid(String gymId, Raid raid) {
    gyms.firstWhere((element) => element.gymId == gymId).raid = raid;
    notifyListeners();
  }

  createRaidGroup(String gymId, RaidGroup group) {
    gyms.firstWhere((element) => element.gymId == gymId).raid.groups.add(group);
    notifyListeners();
  }

  addGym(LatLng pos, String name) {
    Random rnd = Random();
    gyms.add(Gym(pos, name, null, rnd.nextInt(100000).toString()));
    notifyListeners();
  }
}

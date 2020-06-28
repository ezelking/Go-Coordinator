import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pogo/models/gym.dart';
import 'package:pogo/models/raid.dart';
import 'package:pogo/models/raid_group.dart';
import 'package:latlong/latlong.dart';

class RaidProvider with ChangeNotifier {
  List<Gym> gyms;
  final _firestore = Firestore.instance;

  //TODO Backend
  RaidProvider() {
    gyms = [];
  }

  getGyms() async {
    var updatedGyms = await _firestore.collection('gyms').getDocuments();

    gyms.clear();
    for (var document in updatedGyms.documents) {
      gyms.add(Gym.fromJson(document.data, document.documentID));
    }
    notifyListeners();
  }

  reportRaid(String gymId, Raid raid) {
    print(raid);
    _firestore
        .collection("gyms")
        .document(gymId)
        .updateData({"raid": raid.toJson()}).then((_) {
      getGyms();
    });
  }

  createRaidGroup(String gymId, RaidGroup group) {
    gyms.firstWhere((element) => element.gymId == gymId).raid.groups.add(group);
    notifyListeners();
  }

  addGym(LatLng pos, String name) {
    Random rnd = Random();
    _firestore.runTransaction((transaction) async {
      await transaction
          .set(_firestore.collection("gyms").document(),
              Gym(pos, name, null, '').toJson())
          .then((value) => Future.delayed(const Duration(seconds: 5), () {
                getGyms();
              }));
    });
  }
}

import 'package:flutter/cupertino.dart';
import 'package:pogo/models/gym.dart';
import 'package:pogo/models/player.dart';
import 'package:pogo/models/pokemon.dart';
import 'package:pogo/models/raid.dart';
import 'package:pogo/models/raid_group.dart';

class RaidProvider with ChangeNotifier {
  List<Gym> gyms;

  //TODO Backend
  RaidProvider() {
    gyms = [
      Gym(
          0.0,
          0.0,
          'abc',
          Raid(DateTime.now(), DateTime.now().add(Duration(minutes: 45)), 5,
              Pokemon(), [
            RaidGroup(DateTime.now().add(Duration(minutes: 20)),
                [Player('john doe', 5)])
          ]),
          '00000')
    ];
  }
}

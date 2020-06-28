import 'package:pogo/models/player.dart';

class RaidGroup {
  DateTime time;
  List<Player> raiders;
  RaidGroup(this.time, this.raiders);

  Map<String, dynamic> toJson() => {
        'time': time,
        'raiders': raiders,
      };
}

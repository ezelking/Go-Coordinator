import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pogo/models/raid.dart';
import 'package:pogo/constants.dart';

class ReportRaidAlert {
  static Future<Raid> alert(BuildContext context) async {
    Raid _raid = Raid(null, null, 5, null, []);
    TierPicker _tierPicker = TierPicker(
      raid: _raid,
    );
    var selectedTime = await showTimePicker(
      initialTime: TimeOfDay.now(),
      context: context,
      builder: (BuildContext context, Widget child) {
        return FittedBox(
          child: Card(
              child: Row(children: [
            _tierPicker,
            child,
          ])),
        );
      },
    );
    DateTime today = DateTime.now().toUtc();
    _raid.startTime = Constants.convertDateTime(selectedTime);
    _raid.endTime = Constants.convertDateTime(selectedTime.replacing(
        hour: selectedTime.hour, minute: selectedTime.minute + 45));
    return _raid;
  }
}

class TierPicker extends StatefulWidget {
  final Raid raid;

  const TierPicker({Key key, this.raid}) : super(key: key);
  @override
  _TierPickerState createState() => _TierPickerState();
}

class _TierPickerState extends State<TierPicker> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text('Tier:'),
        DropdownButton<int>(
          value: widget.raid.tier,
          icon: Icon(Icons.arrow_downward),
          iconSize: 24,
          elevation: 16,
          onChanged: (int newValue) {
            setState(() {
              widget.raid.tier = newValue;
            });
          },
          items: <int>[1, 2, 3, 4, 5].map<DropdownMenuItem<int>>((int value) {
            return DropdownMenuItem<int>(
              value: value,
              child: Text(value.toString()),
            );
          }).toList(),
        ),
        Image.asset(
          'assets/images/tier-${widget.raid.tier}-egg.png',
          scale: 4,
        )
      ],
    );
  }
}

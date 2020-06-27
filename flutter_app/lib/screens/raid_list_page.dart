import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pogo/alerts/report_raid_alert.dart';
import 'package:pogo/models/gym.dart';
import 'package:pogo/models/raid_group.dart';
import 'package:pogo/providers/raid_provider.dart';
import 'package:provider/provider.dart';

import '../constants.dart';

class RaidListPage extends StatelessWidget {
  static String id = 'RaidListPage';
  @override
  Widget build(BuildContext context) {
    var gyms = context.watch<RaidProvider>().gyms;
    return Scaffold(
      body: ListView.builder(
          itemCount: gyms.length,
          itemBuilder: (BuildContext context, int index) {
            return ExpansionTile(
                leading: SizedBox(
                  width: 50,
                  child: Center(
                    child: (gyms[index].raid != null)
                        ? Image.asset(
                            'assets/images/tier-${gyms[index].raid.tier}-egg.png',
                            scale: 4,
                          )
                        : IconButton(
                            icon: Icon(Icons.alarm_add),
                            onPressed: () async {
                              ReportRaidAlert.alert(context).then((value) => {
                                    if (value != null)
                                      {
                                        Provider.of<RaidProvider>(context,
                                                listen: false)
                                            .reportRaid(
                                                gyms[index].gymId, value)
                                      }
                                  });
                            },
                          ),
                  ),
                ),
                title: Text(gyms[index].name),
                trailing: SizedBox(
                  width: 100,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      if (gyms[index].raid != null)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            for (int i = 0; i < gyms[index].raid.tier; i++)
                              Image.asset(
                                'assets/images/raid-icon.png',
                                scale: 4,
                                color: Colors.black,
                              ),
                          ],
                        ),
                      if (gyms[index].raid != null)
                        RichText(
                          text: TextSpan(
                              style: TextStyle(
                                  fontSize: 18, color: Colors.red[900]),
                              text:
                                  '${gyms[index].raid.startTime.hour.toString().padLeft(2, '0')}:${gyms[index].raid.startTime.minute.toString().padLeft(2, '0')}',
                              children: [
                                TextSpan(text: '-'),
                                TextSpan(
                                    text:
                                        '${gyms[index].raid.endTime.hour.toString().padLeft(2, '0')}:${gyms[index].raid.endTime.minute.toString().padLeft(2, '0')}')
                              ]),
                        )
                    ],
                  ),
                ),
                children: _createChildren(gyms[index], context));
          }),
    );
  }

  List<Widget> _createChildren(Gym gym, BuildContext context) {
    var groups = gym?.raid?.groups ?? null;
    return List<Widget>.generate((groups == null) ? 0 : groups.length + 1,
        (int index) {
      return (index >= groups.length)
          ? ListTile(
              title: Text('Create New Raid Party'),
              trailing: Icon(Icons.group_add),
              onTap: () async {
                var selectedTime = await showTimePicker(
                  initialTime: TimeOfDay.now(),
                  context: context,
                );
                var convertedTime = Constants.convertDateTime(selectedTime);
                if (convertedTime.isAfter(DateTime.now()) &&
                    convertedTime.isAfter(gym.raid.startTime) &&
                    convertedTime.isBefore(gym.raid.endTime))
                  Provider.of<RaidProvider>(context, listen: false)
                      .createRaidGroup(
                          gym.gymId,
                          RaidGroup(
                              Constants.convertDateTime(selectedTime), []));
              },
            )
          : ListTile(
              title: Text(
                  '${groups[index].time.hour.toString().padLeft(2, '0')}:${groups[index].time.minute.toString().padLeft(2, '0')}'),
              trailing: Tab(
                icon: Icon(Icons.group),
                text: groups[index].raiders.length.toString(),
              ),
            );
    });
  }
}

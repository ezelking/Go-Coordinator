import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pogo/providers/raid_provider.dart';
import 'package:provider/provider.dart';

class RaidListPage extends StatelessWidget {
  static String id = 'RaidListPage';
  @override
  Widget build(BuildContext context) {
    var gyms = context.watch<RaidProvider>().gyms;
    return Scaffold(
      body: ListView.builder(
          itemCount: gyms.length,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              leading: Image.asset(
                'assets/images/tier-${gyms[index].raid.tier}-egg.png',
                scale: 4,
              ),
              title: Text(gyms[index].name),
              trailing: SizedBox(
                width: 100,
                child: Row(
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
              ),
            );
          }),
    );
  }
}

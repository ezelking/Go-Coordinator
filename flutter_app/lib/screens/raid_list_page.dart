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
              title: Text(gyms[index].name),
            );
          }),
    );
  }
}

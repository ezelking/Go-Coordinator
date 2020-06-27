import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pogo/providers/raid_provider.dart';
import 'package:pogo/screens/raid_list_page.dart';
import 'package:pogo/screens/raid_map_page.dart';
import 'package:provider/provider.dart';

class RaidPage extends StatelessWidget {
  static String id = 'RaidPage';
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: choices.length,
      child: SafeArea(
        child: Scaffold(
          appBar: TabBar(
            indicatorColor: Colors.red[900],
            labelColor: Colors.red[300],
            tabs: choices.map((Choice choice) {
              return Tab(
                text: choice.title,
                icon: Icon(choice.icon),
              );
            }).toList(),
          ),
          body: TabBarView(
            physics: NeverScrollableScrollPhysics(),
            children: choices.map((Choice choice) {
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: RaidView(choice: choice),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}

class Choice {
  const Choice({this.title, this.icon});

  final String title;
  final IconData icon;
}

const List<Choice> choices = const <Choice>[
  const Choice(title: 'List', icon: Icons.list),
  const Choice(title: 'Map', icon: Icons.map),
];

class RaidView extends StatelessWidget {
  const RaidView({Key key, this.choice}) : super(key: key);

  final Choice choice;

  @override
  Widget build(BuildContext context) {
    return (choice.title == 'Map') ? RaidMapPage() : RaidListPage();
  }
}

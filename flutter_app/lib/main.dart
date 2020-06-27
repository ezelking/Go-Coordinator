import 'package:flutter/material.dart';
import 'package:pogo/providers/raid_provider.dart';
import 'package:pogo/screens/raid_list_page.dart';
import 'package:pogo/screens/raid_page.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<RaidProvider>(create: (_) => RaidProvider())
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.red,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        initialRoute: RaidPage.id,
        routes: {RaidPage.id: (context) => RaidPage()},
      ),
    );
  }
}

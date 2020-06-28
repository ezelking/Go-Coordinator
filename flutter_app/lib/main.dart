import 'package:flutter/material.dart';
import 'package:pogo/providers/raid_provider.dart';
import 'package:pogo/screens/login_page.dart';
import 'package:pogo/screens/raid_page.dart';
import 'package:pogo/screens/registration_page.dart';
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
        title: 'Go Coordinator',
        theme: ThemeData(
          primarySwatch: Colors.red,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          bottomSheetTheme: BottomSheetThemeData(
              backgroundColor: Colors.black.withOpacity(0)),
        ),
        initialRoute: LoginPage.id,
        routes: {
          LoginPage.id: (context) => LoginPage(),
          RegistrationPage.id: (context) => RegistrationPage(),
          RaidPage.id: (context) => RaidPage()
        },
      ),
    );
  }
}

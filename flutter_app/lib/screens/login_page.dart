import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pogo/screens/raid_page.dart';
import 'package:pogo/screens/registration_page.dart';

class LoginPage extends StatefulWidget {
  static String id = 'LoginPage';
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _auth = FirebaseAuth.instance;
  String email;
  String password;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.8,
          height: MediaQuery.of(context).size.width * 0.6,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              TextField(
                decoration: InputDecoration(hintText: 'Email'),
                onChanged: (newValue) {
                  email = newValue;
                },
              ),
              TextField(
                obscureText: true,
                decoration: InputDecoration(hintText: 'Password'),
                onChanged: (newValue) {
                  password = newValue;
                },
              ),
              RaisedButton(
                child: Text('Login'),
                onPressed: () async {
                  try {
                    final user = await _auth.signInWithEmailAndPassword(
                        email: email, password: password);

                    if (user != null) {
                      Navigator.pushNamed(context, RaidPage.id);
                    }
                  } catch (e) {
                    print(e);
                  }
                },
              ),
              FlatButton(
                child: Text('New? Click here to sign up'),
                onPressed: () {
                  Navigator.pushNamed(context, RegistrationPage.id);
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

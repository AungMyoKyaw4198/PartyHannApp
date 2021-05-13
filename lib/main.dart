import 'package:flutter/material.dart';
import 'package:partyhann_app/screens/createparty_screen.dart';
import 'package:partyhann_app/screens/partylist_screen.dart';
import 'package:partyhann_app/screens/user_screens/login.dart';
import 'package:partyhann_app/screens/user_screens/register.dart';
import 'package:firebase_core/firebase_core.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
            title: 'PartyHaan',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            home: LoginScreen(),
            routes: {
              '/login': (context) => LoginScreen(),
              '/register': (context) => RegisterScreen(),
              '/create': (context) => CreatePartyScreen(),
              '/view': (context) => PartyListScreen(),
            }, 
          );
  }
}


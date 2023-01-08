import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'chatpage.dart';

bool isLoggedIn = false;
String lastUserName = 'DefaultID';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(
    const MyApp(),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    doCheck();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: isLoggedIn ? chatpage(userName: lastUserName) : Home(),
      debugShowCheckedModeBanner: false,
    );
  }

  void doCheck() async {
    var sharedpref = await SharedPreferences.getInstance();
    await sharedpref.reload();
    var log = sharedpref.getBool('Login');
    var userKaNaam = sharedpref.getString('User');

    setState(() {
      isLoggedIn = log ?? false;
      lastUserName = userKaNaam ?? 'neverGonnaTrigger';
    });
  }
}

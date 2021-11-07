import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:massageapppro/home_screen.dart';
import 'package:massageapppro/login/loginscreen.dart';
import 'package:massageapppro/model/login.dart';
import 'package:massageapppro/profile.dart';
import 'package:massageapppro/widgets/colors.dart';
import 'package:splashscreen/splashscreen.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final storage = new FlutterSecureStorage();
  bool isLogin = false;
  String guid;
  int onay = 0;
  int isprofilefull = 0;
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  @override
  void initState() {
    _guid().then((value) {
      guid = value;
      if (guid != null) {
        _check();
      }
    });

    super.initState();
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
        // _showItemDialog(message);
      },
      onBackgroundMessage: myBackgroundMessageHandler,
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
        // _navigateToItemDetail(message);
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
        // _navigateToItemDetail(message);
      },
    );
  }

  static Future<dynamic> myBackgroundMessageHandler(
      Map<String, dynamic> message) async {
    if (message.containsKey('data')) {
      final dynamic data = message['data'];
    }

    if (message.containsKey('notification')) {
      final dynamic notification = message['notification'];
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: MyColors.navy,
      ),
      home: SplashScreen(
        seconds: 3,
        navigateAfterSeconds: new Scaffold(body: loginControl()),
        title: new Text(
          'Professional',
          style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0,color: Colors.yellow),
        ),
        image: new Image.asset('assets/images/sueno6.png'),
        photoSize: 100.0,
        backgroundColor: Colors.black,
        loaderColor: Colors.yellow,
      ),
    );
  }

  Widget loginControl() {
    if (guid != null) {
      if (onay == 1)
        return HomePage(
          pageIndex: 0,
        );
      else
        return ProfilePage();
    } else
      return LoginScreen();
  }

  Future<String> _guid() async {
    return await storage.read(key: "guid");
  }

  _check() async {
    usercheck(guid).then((value) {
      setState(() {
        onay = value.onay;
        isprofilefull = value.isprofilefull;
      });
    });
  }
}

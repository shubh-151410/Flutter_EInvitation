import 'package:e_invitation/screens/login.dart';
import 'package:e_invitation/screens/selectcardtype.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:splashscreen/splashscreen.dart';
import './utils/colors.dart' as colors;
import 'screens/AdminScreen/admin_dashboard.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SharedPreferences prefs = await SharedPreferences.getInstance();

  String userId = prefs.getString("USER_ID") ?? "";
  String userTYPE = prefs.getString("USER_TYPE") ?? "";

  if (userId.isNotEmpty && userTYPE.isEmpty) {
    return runApp(
      MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(fontFamily: "Gilroy"),
        home: new SplashScreen(
          seconds: 2,
          navigateAfterSeconds: new SelectCardType(),
          title: new Text(
            '',
            textAlign: TextAlign.center,
            style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
          ),
          useLoader: false,
          backgroundColor: colors.mainbgColor,
        ),
      ),
    );
  } if(userId.isNotEmpty && userTYPE.isNotEmpty){
     return runApp(
      MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(fontFamily: "Gilroy"),
        home: new SplashScreen(
          seconds: 2,
          navigateAfterSeconds: new AdminDashBoard(),
          title: new Text(
            '',
            textAlign: TextAlign.center,
            style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
          ),
          useLoader: false,
          backgroundColor: colors.mainbgColor,
        ),
      ),
    );

  }else {
    runApp(MyApp());
  }
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: new SplashScreen(
        seconds: 2,
        navigateAfterSeconds: new LoginPage(),
        title: new Text(
          '',
          textAlign: TextAlign.center,
          style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
        ),
        useLoader: false,
        backgroundColor: colors.mainbgColor,
      ),
    );
  }
}

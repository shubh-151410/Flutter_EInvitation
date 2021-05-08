import 'package:e_invitation/screens/about_me.dart';
import 'package:e_invitation/screens/login.dart';
import 'package:e_invitation/screens/privacy_policy.dart';
import 'package:e_invitation/screens/profile_screen.dart';
import 'package:e_invitation/screens/terms_condition.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../utils/colors.dart' as colors;

Widget commonDrawer(String userName,BuildContext context){
  return Drawer(
        child: Container(
          padding: EdgeInsets.only(top: 60.0),
          color: colors.mainbgColor,
          child: Column(
            
            children: <Widget>[
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => ProfileScreen()),
                      (route) => true).then((value) {
                    if (value != null) {
                      userName = value.toString();
                      // setState(() {
                        
                      // });
                    }
                  });
                },
                child: AspectRatio(
                  aspectRatio: 3,
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                  ),
                ),
              ),
              SizedBox(height: 10.0),
              Text(
                userName,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold),
              ),
              Divider(
                thickness: 2.0,
                color: Colors.white,
              ),
              ListTile(
                title: Text('Settings'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text('Share'),
                onTap: () {
                  // Update the state of the app
                  // ...
                  // Then close the drawer
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text('About Me'),
                onTap: () {
                  // Update the state of the app
                  // ...
                  // Then close the drawer
                  Navigator.pop(context);
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => AboutMe()),
                      (route) => true);
                },
              ),
              ListTile(
                title: Text('Privacy & Policy'),
                onTap: () {
                  // Update the state of the app
                  // ...
                  // Then close the drawer
                  Navigator.pop(context);
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PrivacyAndPolicy()),
                      (route) => true);
                },
              ),
              ListTile(
                title: Text('Terms & Condition'),
                onTap: () {
                  // Update the state of the app
                  // ...
                  // Then close the drawer
                  Navigator.pop(context);
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) => TermsAndCondition()),
                      (route) => true);
                },
              ),
              ListTile(
                title: Text(
                  'Log out',
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
                onTap: () async{
                  SharedPreferences prefs = await SharedPreferences.getInstance();

                  prefs.clear();
                  // Update the state of the app
                  // ...
                  // Then close the drawer
                //  Navigator.pushReplacement(
                //     context, MaterialPageRoute(builder: (context) => Login())))

                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage()));
                },
              ),
            ],
          ),
        ),
      );
}

 Future<String> getUserName() async {
    try {
      String userName;
      SharedPreferences prefs = await SharedPreferences.getInstance();
      userName = prefs.getString("USER_NAME") ?? "";
      return userName;
    } catch (e) {
      return e.toString();
    }
  }
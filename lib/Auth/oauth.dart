import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';

import "package:http/http.dart" as http;


class SocialAuth{
  static FirebaseAuth auth = FirebaseAuth.instance;
 static  GoogleSignIn googleSignIn = GoogleSignIn();

  static Map<String, dynamic> userData;
  static AccessToken accessToken;
  static bool checking = true;
  static GoogleSignInAccount currentUser;
  static String contactText;
    // bool checking = true;

//   static GoogleSignIn googleSignIn = GoogleSignIn(
//   scopes: <String>[
//     'email',
//     'https://www.googleapis.com/auth/contacts.readonly',
//   ],
// );
static String prettyPrint(Map json) {
  JsonEncoder encoder = new JsonEncoder.withIndent('  ');
  String pretty = encoder.convert(json);
  return pretty;
}
static Future<String> signInWithGoogle() async {
     GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
   GoogleSignInAuthentication googleSignInAuthentication =
      await googleSignInAccount.authentication;

  //  AuthCredential credential = GoogleAuthProvider.getCredential(
  //   accessToken: googleSignInAuthentication.accessToken,
  //   idToken: googleSignInAuthentication.idToken,
  // );
   AuthCredential credential = GoogleAuthProvider.credential(
     accessToken: googleSignInAuthentication.accessToken,
     idToken: googleSignInAuthentication.idToken,
  

   );

   UserCredential authResult = await auth.signInWithCredential(credential);
   User user = authResult.user;

  assert(!user.isAnonymous);
  assert(await user.getIdToken() != null);

  //  User currentUser = await auth.currentUser();
  User currentUser =  auth.currentUser;
  assert(user.uid == currentUser.uid);

  return 'signInWithGoogle succeeded: $user';
}

// static socialGoogleSignIn()async{
//    googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount account) {
//      currentUser = account;
     
        
//       if (currentUser != null) {
//         handleGetContact();
//       }
//     });
//     googleSignIn.signInSilently();
// }
static  Future<void> handleGetContact() async {
  var dio = Dio();
   
      contactText = "Loading contact info...";
    
  final http.Response response = await http.get(
      'https://people.googleapis.com/v1/people/me/connections'
      '?requestMask.includeField=person.names',
      headers: await currentUser.authHeaders,
    );
    if (response.statusCode != 200) {
     
        contactText = "People API gave a ${response.statusCode} "
            "response. Check logs for details.";
    
      print('People API ${response.statusCode} response: ${response.body}');
      return;
    }
    final Map<String, dynamic> data = json.decode(response.body);
    final String namedContact = pickFirstNamedContact(data);
  
      if (namedContact != null) {
        contactText = "I see you know $namedContact!";
      } else {
        contactText = "No contacts to display.";
      }
    
  }
  static  String pickFirstNamedContact(Map<String, dynamic> data) {
    final List<dynamic> connections = data['connections'];
    final Map<String, dynamic> contact = connections?.firstWhere(
      (dynamic contact) => contact['names'] != null,
      orElse: () => null,
    );
    if (contact != null) {
      final Map<String, dynamic> name = contact['names'].firstWhere(
        (dynamic name) => name['displayName'] != null,
        orElse: () => null,
      );
      if (name != null) {
        return name['displayName'];
      }
    }
    return null;
  }
  // static Future handleSignIn() async {
  //   try {
  //     await googleSignIn.signIn();
  //   } catch (error) {
  //     print(error);
  //   }
  // }

  static Future<void> checkIfIsLogged() async {
     AccessToken accessToken = await FacebookAuth.instance.isLogged;
    
      checking = false;
    
    if (accessToken != null) {
      print("is Logged:::: ${prettyPrint(accessToken.toJson())}");
      // now you can call to  FacebookAuth.instance.getUserData();
       userData = await FacebookAuth.instance.getUserData();
      // final userData = await FacebookAuth.instance.getUserData(fields: "email,birthday,friends,gender,link");
      accessToken = accessToken;
     
        userData = userData;
      
    }
  }

  static  Future<void> login() async {
    try {
      // show a circular progress indicator
     
        checking = true;
      
      accessToken = await FacebookAuth.instance.login(); // by the fault we request the email and the public profile
      // loginBehavior is only supported for Android devices, for ios it will be ignored
      // accessToken = await FacebookAuth.instance.login(
      //   permissions: ['email', 'public_profile', 'user_birthday', 'user_friends', 'user_gender', 'user_link'],
      //   loginBehavior:
      //       LoginBehavior.DIALOG_ONLY, // (only android) show an authentication dialog instead of redirecting to facebook app
      // );
      printCredentials();
      // get the user data
      // by default we get the userId, email,name and picture
      //  userData = await FacebookAuth.instance.getUserData();
       userData = await FacebookAuth.instance.getUserData();
      userData = userData;
      print(userData);
    } on FacebookAuthException catch (e) {
      // if the facebook login fails
      print(e.message); // print the error message in console
      // check the error type
      switch (e.errorCode) {
        case FacebookAuthErrorCode.OPERATION_IN_PROGRESS:
          print("You have a previous login operation in progress");
          break;
        case FacebookAuthErrorCode.CANCELLED:
          print("login cancelled");
          break;
        case FacebookAuthErrorCode.FAILED:
          print("login failed");
          break;
      }
    } catch (e, s) {
      // print in the logs the unknown errors
      print(e);
      print(s);
    } finally {
      // update the view
     
        checking = false;
      
    }
  }
  static void printCredentials() {
    print(
      prettyPrint(accessToken.toJson()),
    );
  }
}
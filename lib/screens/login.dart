import 'package:e_invitation/Mobx/apiremote.dart';
import 'package:e_invitation/screens/selectcardtype.dart';
import 'package:e_invitation/screens/signup.dart';
import 'package:flutter/material.dart';
import '../Auth/oauth.dart';
import 'AdminScreen/admin_dashboard.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  double _height = 0.0;
  double _width = 0.0;
  SocialAuth socialAuth = SocialAuth();
  ApiRemote apiRemote = ApiRemote();
  bool isCheck = false;
  final _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldkey = new GlobalKey<ScaffoldState>();

  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    emailController = TextEditingController(text: "shubhanshu@gmail.com");
    passwordController = TextEditingController(text: "123456789");

    // SocialAuth.socialGoogleSignIn();
  }

  @override
  Widget build(BuildContext context) {
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;
    return Scaffold(
      key: _scaffoldkey,
      // backgroundColor: Colors.white,
      body: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/bggg.png"), fit: BoxFit.cover),
          ),
          child: Container(
            padding: EdgeInsets.only(
                top: _height * 0.08, left: _width * 0.05, right: _width * 0.05),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Text(
                      'The Pearl',
                      style: TextStyle(
                        fontFamily: 'Butterfly-Kiss---Personal-Use',
                        fontSize: 52,
                        color: const Color(0xffffffff),
                        height: 0.8269230769230769,
                      ),
                      textAlign: TextAlign.left,
                    ),
                    Text(
                      'EVENTS',
                      style: TextStyle(
                        fontFamily: 'DIN-Medium',
                        fontSize: 11,
                        color: const Color(0xffffffff),
                        letterSpacing: 4.4,
                        height: 1.1818181818181819,
                      ),
                      textAlign: TextAlign.left,
                    ),
                    SizedBox(height: 30),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Login ',
                        style: TextStyle(
                          fontFamily: 'Helvetica Neue',
                          fontSize: 20,
                          color: const Color(0xffffffff),
                          fontWeight: FontWeight.w700,
                          height: 3.65,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    SizedBox(height: 20),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0),
                        color: const Color(0xffffffff),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: _width * 0.8,
                            child: TextFormField(
                              controller: emailController,
                              keyboardType: TextInputType.emailAddress,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return "Email is empty";
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                hintText: "EMAIL",
                                border: InputBorder.none,
                              ),
                              style: TextStyle(
                                fontFamily: 'Helvetica Neue',
                                fontSize: 12,
                                color: const Color(0xff3b3737),
                                fontWeight: FontWeight.w700,
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ),
                          Container(child: Image.asset("assets/loginname.png"))
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0),
                        color: const Color(0x99ffffff),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: _width * 0.8,
                            child: TextFormField(
                              controller: passwordController,
                              obscureText: true,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return "Password is empty";
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                hintText: "PASSWORD",
                                border: InputBorder.none,
                              ),
                              style: TextStyle(
                                fontFamily: 'Helvetica Neue',
                                fontSize: 12,
                                color: const Color(0xff3b3737),
                                fontWeight: FontWeight.w700,
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ),
                          Container(
                              child: Image.asset("assets/loginpassword.png"))
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        // crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Theme(
                            data:
                                ThemeData(unselectedWidgetColor: Colors.white),
                            child: Checkbox(
                              value: isCheck,
                              onChanged: (value) {
                                setState(() {
                                  isCheck = value;
                                });
                              },
                            ),
                          ),
                          SizedBox(
                            width: 10.0,
                          ),
                          Text(
                            'Remember me ',
                            style: TextStyle(
                              fontFamily: 'Helvetica Neue',
                              fontSize: 15,
                              color: const Color(0xffffffff),
                              fontWeight: FontWeight.w500,
                              height: 1.8,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 30),
                    InkWell(
                      onTap: () {
                        if (_formKey.currentState.validate()) {
                          showSnackBar();
                          //  Navigator.pushAndRemoveUntil(
                          //         context,
                          //         MaterialPageRoute(
                          //             builder: (context) => SelectCardType()),
                          //         (route) => false);

                          // value['data'][0]['user_type']

// admin

                          apiRemote
                              .getLogin(
                                  emailController.text, passwordController.text)
                              .then((value) {
                            if (value != null) {
                              if (value['status'] == "true") {
                                if (value['data'][0]['user_type'] == "admin") {
                                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => AdminDashBoard()));
                                } else {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => SelectCardType()),
                                  );
                                }
                              } else if (value['status'] == 'false') {
                                showerrorSnackBar(value['message']);
                              }
                            }
                          });
                        }
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            vertical: 13, horizontal: 20.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.0),
                          color: const Color(0xffdefffd),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0x08000000),
                              offset: Offset(0, 7),
                              blurRadius: 9,
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Login ',
                              style: TextStyle(
                                fontFamily: 'Helvetica Neue',
                                fontSize: 16,
                                color: const Color(0xff3b3737),
                                fontWeight: FontWeight.w700,
                                height: 1.6875,
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: _height * 0.22),
                    Text(
                      'Or sign up with',
                      style: TextStyle(
                        fontFamily: 'Helvetica Neue',
                        fontSize: 15,
                        color: const Color(0xff707070),
                        fontWeight: FontWeight.w500,
                        height: 1.8,
                      ),
                      textAlign: TextAlign.left,
                    ),
                    SizedBox(
                      height: _height * 0.02,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                            onTap: () {
                              SocialAuth.signInWithGoogle();
                            },
                            child: Image.asset("assets/google.png")),
                        SizedBox(width: 50.0),
                        InkWell(
                            onTap: () {
                              SocialAuth.login();
                            },
                            child: Image.asset("assets/facebook.png")),
                        SizedBox(width: 50.0),
                        Image.asset("assets/instagram.png"),
                      ],
                    ),
                    SizedBox(height: 10),
                    InkWell(
                      onTap: () {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (context) => SignUp()),
                            (route) => true);
                      },
                      child: Text.rich(
                        TextSpan(
                          style: TextStyle(
                            fontFamily: 'Helvetica Neue',
                            fontSize: 16,
                            color: const Color(0xff707070),
                            height: 1.6875,
                          ),
                          children: [
                            TextSpan(
                              text: 'Don’t have an account ',
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            TextSpan(
                              text: 'Sign up',
                              style: TextStyle(
                                color: const Color(0xff87d0cb),
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void showSnackBar() {
    final snackBarContent = SnackBar(
      content: Container(
        height: 40,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Please Wait"),
            Center(child: CircularProgressIndicator())
          ],
        ),
      ),
    );
    _scaffoldkey.currentState.showSnackBar(snackBarContent);
  }

  void showerrorSnackBar(String message) {
    final snackBarContent = SnackBar(
      content: Container(height: 40, child: Text(message)),
    );
    _scaffoldkey.currentState.showSnackBar(snackBarContent);
  }
}

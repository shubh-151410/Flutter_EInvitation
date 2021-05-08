import 'package:e_invitation/Mobx/apiremote.dart';
import 'package:e_invitation/screens/selectcardtype.dart';
import 'package:e_invitation/validate.dart';
import 'package:flutter/material.dart';
import '../utils/colors.dart' as colors;

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  double _height = 0.0;
  double _width = 0.0;
  final _formKey = GlobalKey<FormState>();
  ApiRemote apiRemote = ApiRemote();
  final GlobalKey<ScaffoldState> _scaffoldkey = new GlobalKey<ScaffoldState>();

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  TextEditingController mobileController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  TextEditingController repasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;
    return Scaffold(
      key: _scaffoldkey,
      backgroundColor: Colors.white,
      body: Container(
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
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: Image.asset("assets/backarrow.png")),
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'The Pearl',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Butterfly-Kiss---Personal-Use',
                          fontSize: 52,
                          color: const Color(0xffffffff),
                          // height: 0.8269230769230769,
                        ),
                      ),
                      Text(
                        'EVENTS',
                        style: TextStyle(
                          fontFamily: 'DIN-Medium',
                          fontSize: 11,
                          color: const Color(0xffffffff),
                          letterSpacing: 4.4,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ],
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Create your account',
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
                            controller: nameController,
                            validator: (value) {
                              return Validate.usernamerequired(value, context);
                            },
                            decoration: InputDecoration(
                              hintText: "NAME",
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
                  CustomTextField(
                    height: _height,
                    width: _width,
                    hintname: "EMAIL",
                    errormessage: "Please enter your email",
                    iconpath: "assets/email.png",
                    isObscureText: false,
                    textEditingController: emailController,
                    type: "email",
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  CustomTextField(
                    height: _height,
                    width: _width,
                    type: "phone",
                    hintname: "MOBILE NUMBER",
                    errormessage: "Please enter your mobile no",
                    iconpath: "assets/mobileNo.png",
                    isObscureText: false,
                    textEditingController: mobileController,
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  CustomTextField(
                    height: _height,
                    width: _width,
                    type: "password",
                    hintname: "PASSWORD",
                    errormessage: "Please enter your password",
                    iconpath: "assets/loginpassword.png",
                    isObscureText: true,
                    textEditingController: passwordController,
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  CustomTextField(
                    height: _height,
                    width: _width,
                    type: "repassword",
                    isObscureText: true,
                    hintname: "RETYPE PASSWORD",
                    errormessage: "Please enter your retype password",
                    iconpath: "assets/loginpassword.png",
                    textEditingController: repasswordController,
                    passwordController: passwordController,
                  ),
                  SizedBox(height: 20),
                  InkWell(
                    onTap: () {
                      if (_formKey.currentState.validate()) {
                        showSnackBar();
                        apiRemote
                            .getRegister(
                                nameController.text,
                                emailController.text,
                                mobileController.text,
                                passwordController.text)
                            .then((value) {
                          print(value);
                          _scaffoldkey.currentState.hideCurrentSnackBar();
                          if (value['status'].toString() == "true") {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SelectCardType()),
                            );
                          } else if (value['status'].toString() == "false") {
                            _scaffoldkey.currentState.showSnackBar(SnackBar(
                              content: Container(
                                  height: 40,
                                  child: Text(value['message'].toString())),
                            ));
                          }
                        });
                      }
                    },
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 13, horizontal: 20.0),
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
                            'Sign up',
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
                  SizedBox(height: _height * 0.1),
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
                      Image.asset("assets/google.png"),
                      SizedBox(width: 50.0),
                      Image.asset("assets/facebook.png"),
                      SizedBox(width: 50.0),
                      Image.asset("assets/instagram.png"),
                    ],
                  ),
                ],
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
}

class CustomTextField extends StatelessWidget {
  double height = 0.0;
  double width = 0.0;
  String hintname = "";
  String iconpath = "";
  TextEditingController textEditingController;
  TextEditingController passwordController;
  var callback;
  String errormessage;
  bool isObscureText = false;
  String type;

  CustomTextField(
      {this.height,
      this.width,
      this.hintname,
      this.iconpath,
      this.textEditingController,
      this.isObscureText,
      this.callback,
      this.errormessage,
      this.type,
      this.passwordController});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 0.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.0),
        color: const Color(0x99ffffff),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.only(left: 5.0),
            width: width * 0.8,
            child: TextFormField(
              controller: textEditingController,
              onChanged: (value) {
                callback(value);
              },
              obscureText: this.isObscureText,
              validator: (value) {
                switch (type) {
                  case ("name"):
                    return Validate.usernamerequired(value, context);

                    break;

                  case ("email"):
                    return Validate.validateEmail(value.trim(), context);
                    break;

                  case ("phone"):

                    // return Validate.p

                    // return Validate.v

                    break;

                  case ("password"):
                    return Validate.isValidPassword(value, context);

                    break;

                  case ("repassword"):
                    return Validate.isConfirmPassword(
                        value, passwordController.text, "password", context);
                    break;

                  default:
                    return null;
                    break;
                }

                return null;

                // if (value.isEmpty) {
                //   return '$errormessage';
                // }
                // return null;
              },
              decoration: InputDecoration(
                hintText: "$hintname",
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
          Container(child: Image.asset("$iconpath"))
        ],
      ),
    );
  }
}

import 'package:dio/dio.dart';
import 'package:e_invitation/Model/userProfileModel.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../utils/colors.dart' as colors;
import '../validate.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController repasswordCOntroller = TextEditingController();

  final GlobalKey<ScaffoldState> _scaffoldkey = new GlobalKey<ScaffoldState>();

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    // getUserProfile();
  }

  Future<UserProfileModel> getUserProfile() async {
    try {
      UserProfileModel userProfileModel = UserProfileModel();
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String userId = prefs.getString("USER_ID");
      var userProfileAPI =
          "http://pearl.tradeguruweb.com/api/v1/getuser/$userId";
      Response response = await Dio().get(userProfileAPI);

      userProfileModel = UserProfileModel.fromJson(response.data);
      await prefs.setString("USER_NAME", userProfileModel.data.name);
      nameController =
          TextEditingController(text: userProfileModel.data.name ?? "");
      emailController =
          TextEditingController(text: userProfileModel.data.email ?? "");
      phoneController =
          TextEditingController(text: userProfileModel.data.mobile ?? "");
      passwordController =
          TextEditingController(text: userProfileModel.data.password ?? "");
      repasswordCOntroller =
          TextEditingController(text: userProfileModel.data.password ?? "");

      return userProfileModel;
    } catch (e) {
      print(e);
      return e;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colors.mainbgColor,
      body: FutureBuilder<UserProfileModel>(
          future: getUserProfile(),
          builder: (context, snapshot) {
            return (snapshot.hasData)
                ? SingleChildScrollView(
                    child: Container(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.only(top: 60, left: 20, right: 20.0),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            Container(
                              height: 120,
                              width: 120,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white,
                                  border: Border.all(color: Colors.black)),
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Text(
                              snapshot.data.data.name ?? "",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 4.0,
                            ),
                            Text(
                              snapshot.data.data.email,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.normal),
                            ),
                            SizedBox(
                              height: 14.0,
                            ),
                            TextFormField(
                              // initialValue: snapshot.data.data.name,
                              controller: nameController,
                              validator: (value) {
                                return Validate.usernamerequired(
                                    value, context);
                              },
                              decoration: InputDecoration(
                                focusedBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.white)),
                                enabledBorder: const UnderlineInputBorder(
                                  borderSide:
                                      const BorderSide(color: Colors.white),
                                ),
                              ),
                            ),
                            SizedBox(height: 10.0),
                            TextFormField(
                              controller: emailController,
                              validator: (value) {
                                return Validate.validateEmail(
                                    value.trim(), context);

                                // return (value.isEmpty)
                                //     ? "Please enter your email"
                                //     : null;
                              },
                              decoration: InputDecoration(
                                focusedBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.white)),
                                enabledBorder: const UnderlineInputBorder(
                                  borderSide:
                                      const BorderSide(color: Colors.white),
                                ),
                              ),
                            ),
                            SizedBox(height: 10.0),
                            TextFormField(
                              // initialValue: snapshot.data.data.mobile,
                              controller: phoneController,
                              validator: (value) {
                                return (value.isEmpty)
                                    ? "Please enter your phone no"
                                    : null;
                              },
                              decoration: InputDecoration(
                                focusedBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.white)),
                                enabledBorder: const UnderlineInputBorder(
                                  borderSide:
                                      const BorderSide(color: Colors.white),
                                ),
                              ),
                            ),
                            SizedBox(height: 10.0),
                            TextFormField(
                              // initialValue: snapshot.data.data.password,
                              controller: passwordController,
                              obscureText: true,
                              validator: (value) {
                                return Validate.isValidPassword(value, context);
                              },
                              decoration: InputDecoration(
                                focusedBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.white)),
                                enabledBorder: const UnderlineInputBorder(
                                  borderSide:
                                      const BorderSide(color: Colors.white),
                                ),
                              ),
                            ),
                            SizedBox(height: 10.0),
                            TextFormField(
                              obscureText: true,
                              // initialValue: snapshot.data.data.password,
                              controller: repasswordCOntroller,
                              validator: (value) {
                                return Validate.isConfirmPassword(
                                    value,
                                    passwordController.text,
                                    "password",
                                    context);
                              },
                              decoration: InputDecoration(
                                focusedBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.white)),
                                enabledBorder: const UnderlineInputBorder(
                                  borderSide:
                                      const BorderSide(color: Colors.white),
                                ),
                              ),
                            ),
                            SizedBox(height: 20.0),
                            Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Share",
                                  style: TextStyle(fontSize: 19.0),
                                )),
                            SizedBox(height: 20.0),
                            Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Terms & Conditions",
                                  style: TextStyle(fontSize: 19.0),
                                )),
                            SizedBox(height: 20.0),
                            Row(
                              children: [
                                Expanded(
                                    child: RaisedButton(
                                  color: colors.mainAlertDialogbgColor,
                                  onPressed: updateProfile,
                                  child: Padding(
                                    child: Center(
                                      child: Text(
                                        "Update",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18.0),
                                      ),
                                    ),
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 20.0, vertical: 20.0),
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                ))
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                : Center(child: CircularProgressIndicator());
          }),
    );
  }

  updateProfile() async {
    try {
      if (_formKey.currentState.validate()) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        String id = prefs.getString("USER_ID");

        Map<String, String> body = {
          "name": "${nameController.text.trim()}",
          "email": "${emailController.text.trim()}",
          "mobile": "${phoneController.text.trim()}",
          "password": "${passwordController.text.trim()}",
          "id": "$id"
        };
        String api = "http://pearl.tradeguruweb.com/api/v1/getupdateuserinfo";

        Response response = await Dio().post(api, data: body);

        // print();

        if (response.data['status'] == "true") {
          await prefs.setString("USER_NAME", nameController.text.trim());
          Navigator.pop(context, nameController.text.trim());
        }
      }
    } catch (e) {}
  }
}

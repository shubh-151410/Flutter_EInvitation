import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../utils/colors.dart' as colors;

class PrivacyAndPolicy extends StatefulWidget {
  @override
  _PrivacyAndPolicyState createState() => _PrivacyAndPolicyState();
}

class _PrivacyAndPolicyState extends State<PrivacyAndPolicy> {
  @override
  void initState() {
    super.initState();
  }

  Future<String> getTermsAndCondition() async {
    try {
      Response response =
          await Dio().get("http://pearl.tradeguruweb.com/api/v1/getpolicy");

      return response.data['data']['content'];
    } catch (e) {
      return e.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: colors.mainbgColor,
        centerTitle: true,
        title: Text("Privacy & Policy"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SingleChildScrollView(
          child: Padding(
        padding: EdgeInsets.all(30.0),
        child: FutureBuilder(
          future: getTermsAndCondition(),
          builder: (context, snapshot) {
            return (snapshot.hasData)
                ? Text(
                    snapshot.data.toString(),
                    style: TextStyle(fontSize: 16.0),
                  )
                : Center(child: CircularProgressIndicator());
          },
        ),
      )),
    );
  }
}

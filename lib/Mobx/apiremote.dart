import 'package:dio/dio.dart';
import 'package:e_invitation/Model/QrCodeModel.dart';
import 'package:e_invitation/Model/categoryModel.dart';
import 'package:e_invitation/Model/backgroundModel.dart';
import 'package:e_invitation/Model/readycardmodel.dart';
import 'package:e_invitation/Model/sticker_model.dart';
import 'package:mobx/mobx.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Constant/constant.dart';

part 'apiremote.g.dart';

class ApiRemote = ApiRemoteBase with _$ApiRemote;

abstract class ApiRemoteBase with Store {
  @observable
  int value = 0;

  @observable
  AllCategory allCategory = AllCategory();
  @observable
  AllCategory searchCategory = AllCategory();

  @observable
  StickerModel stickerModel = StickerModel();

  // @observable
  // List<Data>

  APIConstant apiConstant = APIConstant();

  @observable
  BackgroundCard backgroundCard = BackgroundCard();

  @observable
  ReadyCard readyCard = ReadyCard();

  @observable
  QrCodeModel qrCodeModel = QrCodeModel();

  @observable
  String qrCodePath = "";

  @action
  void increment() {
    value++;
  }

  @action
  Future getLogin(String email, String password) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      String baseURL = apiConstant.BASE_URL;

      String loginpath = apiConstant.login;

      Map<String, String> bodyData = {"email": email, "password": password};

      Response response =
          await Dio().post("$baseURL$loginpath", data: bodyData);
      // print(response.data['data'][0]['id']);
      if (response.data['status'] != 'false') {
        if(response.data['data'][0]['user_type'] == "admin"){
        await prefs.setString("USER_ID", response.data['data'][0]['id']);
        await prefs.setString("USER_TYPE", response.data['data'][0]['user_type']);
        }else{
          await prefs.setString("USER_ID", response.data['data'][0]['id']);
        }
      }

      return response.data;

      // print(response);
    } catch (e) {
      print(e);
    }
  }

  @action
  Future getRegister(
      String name, String email, String mobile, String password) async {
    try {
      String baseURL = apiConstant.BASE_URL;

      String register = apiConstant.register;

      Map<String, String> bodyData = {
        "email": email,
        "password": password,
        "name": name,
        "mobile": mobile
      };

      Response response = await Dio().post("$baseURL$register", data: bodyData);

      return response.data;

      // print(response);
    } catch (e) {
      print(e);
    }
  }

  @action
  getCateoryCard() async {
    try {
      String baseURL = apiConstant.BASE_URL;

      String register = apiConstant.category;

      // Map<String, String> bodyData = {"email": email, "password": password,"name":name,"mobile":mobile};

      Response response = await Dio().get("$baseURL$register");

      allCategory = AllCategory.fromJson(response.data);

      print(allCategory);

      // print(response);
    } catch (e) {
      print(e);
    }
  }

  @action
  getBackGround(int categoryId) async {
    try {
      String baseURL = apiConstant.BASE_URL;

      String backgroundcardurl = "getallbackground/1/$categoryId";

      // Map<String, String> bodyData = {"email": email, "password": password,"name":name,"mobile":mobile};

      Response response = await Dio().get("$baseURL$backgroundcardurl");

      if (response.data['status'] != "false") {
        backgroundCard = BackgroundCard.fromJson(response.data);
      }

      print(allCategory);

      // print(response);
    } catch (e) {
      print(e);
    }
  }

  @action
  getReadyCard() async {
    try {
      String baseURL = apiConstant.BASE_URL;

      String readycardurl = "getallreadycard/1/";

      // Map<String, String> bodyData = {"email": email, "password": password,"name":name,"mobile":mobile};

      // Response response = await Dio().get("$baseURL$readycardurl/3");
      Response response = await Dio()
          .get("http://pearl.tradeguruweb.com/api/v1/getallreadycard/1/3");

      readyCard = ReadyCard.fromJson(response.data);

      print(readyCard.data);

      // print(response);
    } catch (e) {
      print(e);
    }
  }

  @action
  getQrCode(String categoryId) async {
    try {
      String baseURL = apiConstant.BASE_URL;

      String readycardurl = "getcreateqrcode/1/$categoryId";

      Response response =
          await Dio().get("http://pearl.tradeguruweb.com/api/v1/$readycardurl");
      qrCodeModel = QrCodeModel.fromJson(response.data);

      print(qrCodeModel);

      // readyCard = ReadyCard.fromJson(response.data);

      // print(readyCard.data);

      // print(response);
    } catch (e) {
      print(e);
    }
  }

  @action
  getSticker() async {
    try {
      String baseURL = apiConstant.BASE_URL;

      // String readycardurl = "getcreateqrcode/1/$categoryId";

      Response response = await Dio()
          .get("http://pearl.tradeguruweb.com/api/v1/getallstickers");
      stickerModel = StickerModel.fromJson(response.data);

      print(stickerModel);

      // readyCard = ReadyCard.fromJson(response.data);

      // print(readyCard.data);

      // print(response);
    } catch (e) {
      print(e);
    }
  }
}

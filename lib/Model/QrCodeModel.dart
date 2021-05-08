class QrCodeModel {
  String status;
  String message;
  List<QrData> data;

  QrCodeModel({this.status, this.message, this.data});

  QrCodeModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = new List<QrData>();
      json['data'].forEach((v) {
        data.add(new QrData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class QrData {
  int id;
  String qrcode;

  QrData({this.id, this.qrcode});

  QrData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    qrcode = json['qrcode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['qrcode'] = this.qrcode;
    return data;
  }
}

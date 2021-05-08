class BackgroundCard {
  String status;
  List<Data> data;

  BackgroundCard({this.status, this.data});

  BackgroundCard.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = new List<Data>();
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String id;
  String uploadedBy;
  String userId;
  String backgroundName;
  String backgroundUrl;
  String isActive;
  String createdAt;
  String updatedAt;
  String categoryId;

  Data(
      {this.id,
      this.uploadedBy,
      this.userId,
      this.backgroundName,
      this.backgroundUrl,
      this.isActive,
      this.createdAt,
      this.categoryId,
      this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    uploadedBy = json['uploaded_by'];
    userId = json['user_id'];
    backgroundName = json['background_name'];
    backgroundUrl = json['background_url'];
    isActive = json['is_active'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    categoryId = json['category_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['uploaded_by'] = this.uploadedBy;
    data['user_id'] = this.userId;
    data['background_name'] = this.backgroundName;
    data['background_url'] = this.backgroundUrl;
    data['is_active'] = this.isActive;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class ReadyCard {
  String status;
  List<Data> data;

  ReadyCard({this.status, this.data});

  ReadyCard.fromJson(Map<String, dynamic> json) {
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
  String categoryId;
  String userId;
  String cardName;
  String cardUrl;
  String thumbnail;
  List<Content> content;
  String isActive;

  Data(
      {this.id,
      this.categoryId,
      this.userId,
      this.cardName,
      this.cardUrl,
      this.thumbnail,
      this.content,
      this.isActive});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryId = json['category_id'];
    userId = json['user_id'];
    cardName = json['card_name'];
    cardUrl = json['card_url'];
    thumbnail = json['thumbnail'];
    if (json['content'] != null) {
      content = new List<Content>();
      json['content'].forEach((v) {
        content.add(new Content.fromJson(v));
      });
    }
    isActive = json['is_active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['category_id'] = this.categoryId;
    data['user_id'] = this.userId;
    data['card_name'] = this.cardName;
    data['card_url'] = this.cardUrl;
    data['thumbnail'] = this.thumbnail;
    if (this.content != null) {
      data['content'] = this.content.map((v) => v.toJson()).toList();
    }
    data['is_active'] = this.isActive;
    return data;
  }
}

class Content {
  String text;
  String size;
  String fontStyle;
  String x;
  String y;
  String fontFamily;
  String color;

  Content(
      {this.text,
      this.size,
      this.fontStyle,
      this.x,
      this.y,
      this.fontFamily,
      this.color});

  Content.fromJson(Map<String, dynamic> json) {
    text = json['text'];
    size = json['size'];
    fontStyle = json['font-style'];
    x = json['x'];
    y = json['y'];
    fontFamily = json['font-family'];
    color = json['color'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['text'] = this.text;
    data['size'] = this.size;
    data['font-style'] = this.fontStyle;
    data['x'] = this.x;
    data['y'] = this.y;
    data['font-family'] = this.fontFamily;
    data['color'] = this.color;
    return data;
  }
}

class UserData {
  bool? admin;
  List<dynamic>? chapterTops;
  int? coinCount;
  List<dynamic>? collectIds;
  String? email;
  String? icon;
  int? id;
  String? nickname;
  String? password;
  String? publicName;
  String? token;
  int? type;
  String? username;

  UserData(
      {this.admin,
      this.chapterTops,
      this.coinCount,
      this.collectIds,
      this.email,
      this.icon,
      this.id,
      this.nickname,
      this.password,
      this.publicName,
      this.token,
      this.type,
      this.username});

  UserData.fromJson(Map<String, dynamic> json) {
    admin = json["admin"];
    chapterTops = json["chapterTops"] ?? [];
    coinCount = (json["coinCount"] as num).toInt();
    collectIds = json["collectIds"] ?? [];
    email = json["email"];
    icon = json["icon"];
    id = (json["id"] as num).toInt();
    nickname = json["nickname"];
    password = json["password"];
    publicName = json["publicName"];
    token = json["token"];
    type = (json["type"] as num).toInt();
    username = json["username"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["admin"] = admin;
    if (chapterTops != null) {
      data["chapterTops"] = chapterTops;
    }
    data["coinCount"] = coinCount;
    if (collectIds != null) {
      data["collectIds"] = collectIds;
    }
    data["email"] = email;
    data["icon"] = icon;
    data["id"] = id;
    data["nickname"] = nickname;
    data["password"] = password;
    data["publicName"] = publicName;
    data["token"] = token;
    data["type"] = type;
    data["username"] = username;
    return data;
  }
}

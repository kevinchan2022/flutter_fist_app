class WebsitesDataList {
  List<WebsitesData>? websites;

  WebsitesDataList.fromJson(dynamic json) {
    websites = [];
    if (json is List) {
      for (var item in json) {
        websites?.add(WebsitesData.fromJson(item));
      }
    }
  }
}

class WebsitesData {
  String? category;
  String? icon;
  int? id;
  String? link;
  String? name;
  int? order;
  int? visible;

  WebsitesData(
      {this.category,
      this.icon,
      this.id,
      this.link,
      this.name,
      this.order,
      this.visible});

  WebsitesData.fromJson(Map<String, dynamic> json) {
    category = json["category"];
    icon = json["icon"];
    id = (json["id"] as num).toInt();
    link = json["link"];
    name = json["name"];
    order = (json["order"] as num).toInt();
    visible = (json["visible"] as num).toInt();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["category"] = category;
    data["icon"] = icon;
    data["id"] = id;
    data["link"] = link;
    data["name"] = name;
    data["order"] = order;
    data["visible"] = visible;
    return data;
  }
}

class HotKeysDataList {
  List<HotKeysData>? hotkeys;

  HotKeysDataList.fromJson(dynamic json) {
    hotkeys = [];
    if (json is List) {
      for (var item in json) {
        hotkeys?.add(HotKeysData.fromJson(item));
      }
    }
  }
}

class HotKeysData {
  int? id;
  String? link;
  String? name;
  int? order;
  int? visible;

  HotKeysData({this.id, this.link, this.name, this.order, this.visible});

  HotKeysData.fromJson(Map<String, dynamic> json) {
    id = (json["id"] as num).toInt();
    link = json["link"];
    name = json["name"];
    order = (json["order"] as num).toInt();
    visible = (json["visible"] as num).toInt();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    data["link"] = link;
    data["name"] = name;
    data["order"] = order;
    data["visible"] = visible;
    return data;
  }
}

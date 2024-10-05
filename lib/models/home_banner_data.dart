class HomeBannerData {
  List<HomeBannerItem>? bannerList;
  HomeBannerData.fromJson(dynamic json) {
    if (json is List) {
      bannerList = [];
      for (var item in json) {
        bannerList?.add(HomeBannerItem.fromJson(item));
      }
    }
  }
}

class HomeBannerItem {
  String? desc;
  int? id;
  String? imagePath;
  int? isVisible;
  int? order;
  String? title;
  int? type;
  String? url;

  HomeBannerItem(
      {this.desc,
      this.id,
      this.imagePath,
      this.isVisible,
      this.order,
      this.title,
      this.type,
      this.url});

  HomeBannerItem.fromJson(Map<String, dynamic> json) {
    desc = json["desc"];
    id = (json["id"] as num).toInt();
    imagePath = json["imagePath"];
    isVisible = (json["isVisible"] as num).toInt();
    order = (json["order"] as num).toInt();
    title = json["title"];
    type = (json["type"] as num).toInt();
    url = json["url"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["desc"] = desc;
    data["id"] = id;
    data["imagePath"] = imagePath;
    data["isVisible"] = isVisible;
    data["order"] = order;
    data["title"] = title;
    data["type"] = type;
    data["url"] = url;
    return data;
  }
}

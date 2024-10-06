class CollectsListData {
  int? curPage;
  List<CollectsItemData>? datas;
  int? offset;
  bool? over;
  int? pageCount;
  int? size;
  int? total;

  CollectsListData(
      {this.curPage,
      this.datas,
      this.offset,
      this.over,
      this.pageCount,
      this.size,
      this.total});

  CollectsListData.fromJson(Map<String, dynamic> json) {
    curPage = (json["curPage"] as num).toInt();
    datas = json["datas"] == null
        ? null
        : (json["datas"] as List)
            .map((e) => CollectsItemData.fromJson(e))
            .toList();
    offset = (json["offset"] as num).toInt();
    over = json["over"];
    pageCount = (json["pageCount"] as num).toInt();
    size = (json["size"] as num).toInt();
    total = (json["total"] as num).toInt();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["curPage"] = curPage;
    if (datas != null) {
      data["datas"] = datas?.map((e) => e.toJson()).toList();
    }
    data["offset"] = offset;
    data["over"] = over;
    data["pageCount"] = pageCount;
    data["size"] = size;
    data["total"] = total;
    return data;
  }
}

class CollectsItemData {
  String? author;
  int? chapterId;
  String? chapterName;
  int? courseId;
  String? desc;
  String? envelopePic;
  int? id;
  String? link;
  String? niceDate;
  String? origin;
  int? originId;
  int? publishTime;
  String? title;
  int? userId;
  int? visible;
  int? zan;

  CollectsItemData(
      {this.author,
      this.chapterId,
      this.chapterName,
      this.courseId,
      this.desc,
      this.envelopePic,
      this.id,
      this.link,
      this.niceDate,
      this.origin,
      this.originId,
      this.publishTime,
      this.title,
      this.userId,
      this.visible,
      this.zan});

  CollectsItemData.fromJson(Map<String, dynamic> json) {
    author = json["author"];
    chapterId = (json["chapterId"] as num).toInt();
    chapterName = json["chapterName"];
    courseId = (json["courseId"] as num).toInt();
    desc = json["desc"];
    envelopePic = json["envelopePic"];
    id = (json["id"] as num).toInt();
    link = json["link"];
    niceDate = json["niceDate"];
    origin = json["origin"];
    originId = (json["originId"] as num).toInt();
    publishTime = (json["publishTime"] as num).toInt();
    title = json["title"];
    userId = (json["userId"] as num).toInt();
    visible = (json["visible"] as num).toInt();
    zan = (json["zan"] as num).toInt();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["author"] = author;
    data["chapterId"] = chapterId;
    data["chapterName"] = chapterName;
    data["courseId"] = courseId;
    data["desc"] = desc;
    data["envelopePic"] = envelopePic;
    data["id"] = id;
    data["link"] = link;
    data["niceDate"] = niceDate;
    data["origin"] = origin;
    data["originId"] = originId;
    data["publishTime"] = publishTime;
    data["title"] = title;
    data["userId"] = userId;
    data["visible"] = visible;
    data["zan"] = zan;
    return data;
  }
}

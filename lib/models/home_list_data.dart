class HomeListData {
  int? curPage;
  List<HomeListItem>? datas;
  int? offset;
  bool? over;
  int? pageCount;
  int? size;
  int? total;

  HomeListData(
      {this.curPage,
      this.datas,
      this.offset,
      this.over,
      this.pageCount,
      this.size,
      this.total});

  HomeListData.fromJson(Map<String, dynamic> json) {
    curPage = (json["curPage"] as num).toInt();
    datas = json["datas"] == null
        ? null
        : (json["datas"] as List).map((e) => HomeListItem.fromJson(e)).toList();
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

/// 首页置顶数据
class HomeTopListData {
  List<HomeListItem>? topList;

  HomeTopListData.fromJson(dynamic json) {
    if (json is List) {
      topList = [];
      for (var item in json) {
        topList?.add(HomeListItem.fromJson(item));
      }
    }
  }
}

class HomeListItem {
  bool? adminAdd;
  String? apkLink;
  int? audit;
  String? author;
  bool? canEdit;
  int? chapterId;
  String? chapterName;
  bool? collect;
  int? courseId;
  String? desc;
  String? descMd;
  String? envelopePic;
  bool? fresh;
  String? host;
  int? id;
  bool? isAdminAdd;
  String? link;
  String? niceDate;
  String? niceShareDate;
  String? origin;
  String? prefix;
  String? projectLink;
  int? publishTime;
  int? realSuperChapterId;
  int? selfVisible;
  int? shareDate;
  String? shareUser;
  int? superChapterId;
  String? superChapterName;
  List<Tags>? tags;
  String? title;
  int? type;
  int? userId;
  int? visible;
  int? zan;

  HomeListItem(
      {this.adminAdd,
      this.apkLink,
      this.audit,
      this.author,
      this.canEdit,
      this.chapterId,
      this.chapterName,
      this.collect,
      this.courseId,
      this.desc,
      this.descMd,
      this.envelopePic,
      this.fresh,
      this.host,
      this.id,
      this.isAdminAdd,
      this.link,
      this.niceDate,
      this.niceShareDate,
      this.origin,
      this.prefix,
      this.projectLink,
      this.publishTime,
      this.realSuperChapterId,
      this.selfVisible,
      this.shareDate,
      this.shareUser,
      this.superChapterId,
      this.superChapterName,
      this.tags,
      this.title,
      this.type,
      this.userId,
      this.visible,
      this.zan});

  HomeListItem.fromJson(Map<String, dynamic> json) {
    adminAdd = json["adminAdd"];
    apkLink = json["apkLink"];
    audit = (json["audit"] as num).toInt();
    author = json["author"];
    canEdit = json["canEdit"];
    chapterId = (json["chapterId"] as num).toInt();
    chapterName = json["chapterName"];
    collect = json["collect"];
    courseId = (json["courseId"] as num).toInt();
    desc = json["desc"];
    descMd = json["descMd"];
    envelopePic = json["envelopePic"];
    fresh = json["fresh"];
    host = json["host"];
    id = (json["id"] as num).toInt();
    isAdminAdd = json["isAdminAdd"];
    link = json["link"];
    niceDate = json["niceDate"];
    niceShareDate = json["niceShareDate"];
    origin = json["origin"];
    prefix = json["prefix"];
    projectLink = json["projectLink"];
    publishTime = (json["publishTime"] as num).toInt();
    realSuperChapterId = (json["realSuperChapterId"] as num).toInt();
    selfVisible = (json["selfVisible"] as num).toInt();
    shareDate = (json["shareDate"] as num).toInt();
    shareUser = json["shareUser"];
    superChapterId = (json["superChapterId"] as num).toInt();
    superChapterName = json["superChapterName"];
    tags = json["tags"] == null
        ? null
        : (json["tags"] as List).map((e) => Tags.fromJson(e)).toList();
    title = json["title"];
    type = (json["type"] as num).toInt();
    userId = (json["userId"] as num).toInt();
    visible = (json["visible"] as num).toInt();
    zan = (json["zan"] as num).toInt();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["adminAdd"] = adminAdd;
    data["apkLink"] = apkLink;
    data["audit"] = audit;
    data["author"] = author;
    data["canEdit"] = canEdit;
    data["chapterId"] = chapterId;
    data["chapterName"] = chapterName;
    data["collect"] = collect;
    data["courseId"] = courseId;
    data["desc"] = desc;
    data["descMd"] = descMd;
    data["envelopePic"] = envelopePic;
    data["fresh"] = fresh;
    data["host"] = host;
    data["id"] = id;
    data["isAdminAdd"] = isAdminAdd;
    data["link"] = link;
    data["niceDate"] = niceDate;
    data["niceShareDate"] = niceShareDate;
    data["origin"] = origin;
    data["prefix"] = prefix;
    data["projectLink"] = projectLink;
    data["publishTime"] = publishTime;
    data["realSuperChapterId"] = realSuperChapterId;
    data["selfVisible"] = selfVisible;
    data["shareDate"] = shareDate;
    data["shareUser"] = shareUser;
    data["superChapterId"] = superChapterId;
    data["superChapterName"] = superChapterName;
    if (tags != null) {
      data["tags"] = tags?.map((e) => e.toJson()).toList();
    }
    data["title"] = title;
    data["type"] = type;
    data["userId"] = userId;
    data["visible"] = visible;
    data["zan"] = zan;
    return data;
  }
}

class Tags {
  String? name;
  String? url;

  Tags({this.name, this.url});

  Tags.fromJson(Map<String, dynamic> json) {
    name = json["name"];
    url = json["url"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["name"] = name;
    data["url"] = url;
    return data;
  }
}

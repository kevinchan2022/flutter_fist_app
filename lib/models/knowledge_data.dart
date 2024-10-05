class KnowledgeListData {
  List<KnowledgeData> knowledgeList = [];

  KnowledgeListData.fromJson(dynamic json) {
    if (json is List) {
      for (var item in json) {
        knowledgeList.add(KnowledgeData.fromJson(item));
      }
    }
  }
}

class KnowledgeData {
  List<dynamic>? articleList;
  String? author;
  List<KnowledgeChildren>? children;
  int? courseId;
  String? cover;
  String? desc;
  int? id;
  String? lisense;
  String? lisenseLink;
  String? name;
  int? order;
  int? parentChapterId;
  int? type;
  bool? userControlSetTop;
  int? visible;

  KnowledgeData(
      {this.articleList,
      this.author,
      this.children,
      this.courseId,
      this.cover,
      this.desc,
      this.id,
      this.lisense,
      this.lisenseLink,
      this.name,
      this.order,
      this.parentChapterId,
      this.type,
      this.userControlSetTop,
      this.visible});

  KnowledgeData.fromJson(Map<String, dynamic> json) {
    articleList = json["articleList"] ?? [];
    author = json["author"];
    children = json["children"] == null
        ? null
        : (json["children"] as List)
            .map((e) => KnowledgeChildren.fromJson(e))
            .toList();
    courseId = (json["courseId"] as num).toInt();
    cover = json["cover"];
    desc = json["desc"];
    id = (json["id"] as num).toInt();
    lisense = json["lisense"];
    lisenseLink = json["lisenseLink"];
    name = json["name"];
    order = (json["order"] as num).toInt();
    parentChapterId = (json["parentChapterId"] as num).toInt();
    type = (json["type"] as num).toInt();
    userControlSetTop = json["userControlSetTop"];
    visible = (json["visible"] as num).toInt();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (articleList != null) {
      data["articleList"] = articleList;
    }
    data["author"] = author;
    if (children != null) {
      data["children"] = children?.map((e) => e.toJson()).toList();
    }
    data["courseId"] = courseId;
    data["cover"] = cover;
    data["desc"] = desc;
    data["id"] = id;
    data["lisense"] = lisense;
    data["lisenseLink"] = lisenseLink;
    data["name"] = name;
    data["order"] = order;
    data["parentChapterId"] = parentChapterId;
    data["type"] = type;
    data["userControlSetTop"] = userControlSetTop;
    data["visible"] = visible;
    return data;
  }
}

class KnowledgeChildren {
  List<dynamic>? articleList;
  String? author;
  List<KnowledgeChildren>? children;
  int? courseId;
  String? cover;
  String? desc;
  int? id;
  String? lisense;
  String? lisenseLink;
  String? name;
  int? order;
  int? parentChapterId;
  int? type;
  bool? userControlSetTop;
  int? visible;

  KnowledgeChildren(
      {this.articleList,
      this.author,
      this.children,
      this.courseId,
      this.cover,
      this.desc,
      this.id,
      this.lisense,
      this.lisenseLink,
      this.name,
      this.order,
      this.parentChapterId,
      this.type,
      this.userControlSetTop,
      this.visible});

  KnowledgeChildren.fromJson(Map<String, dynamic> json) {
    articleList = json["articleList"] ?? [];
    author = json["author"];
    // children = json["children"] ?? [];
    children = json["children"] == null
        ? null
        : (json["children"] as List)
            .map((e) => KnowledgeChildren.fromJson(e))
            .toList();
    courseId = (json["courseId"] as num).toInt();
    cover = json["cover"];
    desc = json["desc"];
    id = (json["id"] as num).toInt();
    lisense = json["lisense"];
    lisenseLink = json["lisenseLink"];
    name = json["name"];
    order = (json["order"] as num).toInt();
    parentChapterId = (json["parentChapterId"] as num).toInt();
    type = (json["type"] as num).toInt();
    userControlSetTop = json["userControlSetTop"];
    visible = (json["visible"] as num).toInt();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (articleList != null) {
      data["articleList"] = articleList;
    }
    data["author"] = author;
    if (children != null) {
      data["children"] = children;
    }
    data["courseId"] = courseId;
    data["cover"] = cover;
    data["desc"] = desc;
    data["id"] = id;
    data["lisense"] = lisense;
    data["lisenseLink"] = lisenseLink;
    data["name"] = name;
    data["order"] = order;
    data["parentChapterId"] = parentChapterId;
    data["type"] = type;
    data["userControlSetTop"] = userControlSetTop;
    data["visible"] = visible;
    return data;
  }
}

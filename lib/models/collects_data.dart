class CollectsListData {
  int? curPage;
  List<dynamic>? datas;
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
    datas = json["datas"] ?? [];
    offset = (json["offset"] as num).toInt();
    over = json["over"];
    pageCount = (json["pageCount"] as num).toInt();
    size = (json["size"] as num).toInt();
    total = (json["total"] as num).toInt();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["curPage"] = curPage;
    if (datas != null) {
      _data["datas"] = datas;
    }
    _data["offset"] = offset;
    _data["over"] = over;
    _data["pageCount"] = pageCount;
    _data["size"] = size;
    _data["total"] = total;
    return _data;
  }
}

class Article{
  int id;
  String title;
  String body;

  static final dbTable = "articles";
  static final dbId = "id";
  static final dbTitle = "title";
  static final dbBody = "body";

  Article({this.id, this.title, this.body});

  Article.fromMap(Map<String, dynamic> map) : this (
    id : map[dbId],
    title : map[dbTitle],
    body : map[dbBody]
  );

  Map<String, dynamic> toMap() {
    return {
      dbId: id,
      dbTitle: title,
      dbBody: body,
    };
  }
}
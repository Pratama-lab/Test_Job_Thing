class Blog {
  int id;
  String title;
  String subTitle;
  String photo;
  String content;
  String author;
  int createAt;
  String tag;

  Blog({
    required this.id,
    required this.title,
    required this.subTitle,
    required this.photo,
    required this.content,
    required this.author,
    required this.createAt,
    required this.tag,
  });

  factory Blog.fromJson(Map<String, dynamic> json) => Blog(
        id: json["id"],
        title: json["title"],
        subTitle: json["subTitle"],
        photo: json["photo"],
        content: json["content"],
        author: json["author"],
        createAt: json["create_at"],
        tag: json["tag"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "subTitle": subTitle,
        "photo": photo,
        "content": content,
        "author": author,
        "create_at": createAt,
        "tag": tag,
      };
}

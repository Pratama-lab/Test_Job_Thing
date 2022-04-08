class Candidate {
  int id;
  String name;
  String gender;
  String photo;
  int birthday;
  int expired;

  Candidate({
    required this.id,
    required this.name,
    required this.gender,
    required this.photo,
    required this.birthday,
    required this.expired,
  });

  factory Candidate.fromJson(Map<String, dynamic> json) => Candidate(
        id: json["id"],
        name: json["name"],
        gender: json["gender"],
        photo: json["photo"],
        birthday: json["birthday"],
        expired: json["expired"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "gender": gender,
        "photo": photo,
        "birthday": birthday,
        "expired": expired,
      };
}

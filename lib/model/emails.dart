class Email {
  int? id;
  String? email;
  String? phone;

  Email({
    this.id,
    this.email,
    this.phone,
  });

  factory Email.fromJson(Map<String, dynamic> json) => Email(
        id: json["id"],
        email: json["email"],
        phone: json["phone"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "phone": phone,
      };
}

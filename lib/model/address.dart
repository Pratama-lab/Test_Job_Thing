class Address {
  int? id;
  String? address;
  String? city;
  String? state;
  int? zipCode;

  Address({
    this.id,
    this.address,
    this.city,
    this.state,
    this.zipCode,
  });

  factory Address.fromJson(Map<String, dynamic> json) => Address(
        id: json["id"],
        address: json["address"],
        city: json["city"],
        state: json["state"],
        zipCode: json["zip_code"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "address": address,
        "city": city,
        "state": state,
        "zip_code": zipCode,
      };
}

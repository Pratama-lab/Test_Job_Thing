class Merge {
  final int id;
  final String name;
  final String gender;
  final String photo;
  final int birthday;
  final int expired;
  final String email;
  final String phone;
  final String address;
  final String city;
  final String state;
  final int zipCode;
  final String status;
  final String jobTitle;
  final String companyName;
  final String industry;

  Merge(
      {required this.id,
      required this.name,
      required this.gender,
      required this.photo,
      required this.birthday,
      required this.expired,
      required this.email,
      required this.phone,
      required this.address,
      required this.city,
      required this.state,
      required this.zipCode,
      required this.status,
      required this.jobTitle,
      required this.companyName,
      required this.industry});

  factory Merge.fromJson(Map<String, dynamic> jsonData) => Merge(
      id: jsonData['id'],
      name: jsonData['name'],
      gender: jsonData['gender'],
      photo: jsonData['photo'],
      birthday: jsonData['birthday'],
      expired: jsonData['expired'],
      email: jsonData['email'],
      phone: jsonData['phone'],
      address: jsonData['address'],
      city: jsonData['city'],
      state: jsonData['state'],
      zipCode: jsonData['zip_code'],
      status: jsonData['status'],
      jobTitle: jsonData['job_title'],
      companyName: jsonData['company_name'],
      industry: jsonData['industry']);

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'gender': gender,
        'photo': photo,
        'birthday': birthday,
        'expired': expired,
        'email': email,
        'phone': phone,
        'address': address,
        'city': city,
        'state': state,
        'zip_code': zipCode,
        'status': status,
        'job_title': jobTitle,
        'company_name': companyName,
        'industry': industry
      };
}

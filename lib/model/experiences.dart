class Experience {
  int? id;
  String? status;
  String? jobTitle;
  String? companyName;
  String? industry;

  Experience({
    this.id,
    this.status,
    this.jobTitle,
    this.companyName,
    this.industry,
  });

  factory Experience.fromJson(Map<String, dynamic> json) => Experience(
        id: json["id"],
        status: json["status"],
        jobTitle: json["job_title"],
        companyName: json["company_name"],
        industry: json["industry"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "status": status,
        "job_title": jobTitle,
        "company_name": companyName,
        "industry": industry,
      };
}

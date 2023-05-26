class StudentDetailsModel {
  String? student_id;
  String? name;
  String? usn;
  String? phoneum;

  StudentDetailsModel(
      {required this.student_id,
      required this.name,
      required this.usn,
      required this.phoneum});

  StudentDetailsModel.fromJson(Map<String, dynamic> json) {
    student_id = json['student_id'];
    name = json['name'];
    usn = json['usn'];
    phoneum = json['phonenum'].toString();
  }
}

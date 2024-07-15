class Drs {
  List<Datum> data;
  bool success;
  String message;

  Drs({
    required this.data,
    required this.success,
    required this.message,
  });

  factory Drs.fromJson(Map<String, dynamic> json) => Drs(
      success: json["success"] ?? false,
      message: json["message"] ?? "error",
      data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))));
}

class Datum {
  String id;
  String drsno;
  String drsdate;
  int awbcount;
  String fieldexecutive;
  String status;

  Datum({
    required this.id,
    required this.drsno,
    required this.drsdate,
    required this.awbcount,
    required this.fieldexecutive,
    required this.status,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
      id: json["id"] ?? "error",
      drsno: json["drsno"] ?? "error",
      drsdate: json["drsdate"] ?? "error",
      awbcount: json["awbcount"] ?? 0,
      fieldexecutive: json["fieldexecutive"] ?? "error",
      status: json["status"] ?? "error");
}

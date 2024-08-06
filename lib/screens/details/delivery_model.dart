class DeliveryAll {
  bool success;
  String message;
  List<DDatum> data;

  DeliveryAll({
    required this.success,
    required this.message,
    required this.data,
  });

  factory DeliveryAll.fromJson(Map<String, dynamic> json) => DeliveryAll(
      success: json["success"] ?? false,
      message: json["message"] ?? "error",
      data: List<DDatum>.from(json["data"].map((x) => DDatum.fromJson(x))));
}

class DDatum {
  String awbnumber;
  String bookingdate;
  String consigneename;
  Consigneedetails consigneedetails;
  List<double>? latlng;

  DDatum({
    required this.awbnumber,
    required this.bookingdate,
    required this.consigneename,
    required this.consigneedetails,
    this.latlng = const [19.0, 27.0],
  });

  factory DDatum.fromJson(Map<String, dynamic> json) => DDatum(
        awbnumber: json["awbnumber"] ?? "error",
        bookingdate: json["bookingdate"] ?? "error",
        consigneename: json["consigneename"] ?? "error",
        consigneedetails: Consigneedetails.fromJson(json["consigneedetails"]),
      );
}

class Consigneedetails {
  String city;
  String state;
  String country;
  String address1;
  String address2;
  int mobileno;
  String telno;

  Consigneedetails({
    required this.city,
    required this.state,
    required this.country,
    required this.address1,
    this.address2 = "N/A",
    required this.mobileno,
    required this.telno,
  });

  factory Consigneedetails.fromJson(Map<String, dynamic> json) =>
      Consigneedetails(
        city: json["city"] ?? "error",
        state: json["state"] ?? "error",
        country: json["country"] ?? "error",
        address1: json["address1"] ?? "error",
        address2: json["address2"] ?? " ",
        mobileno: json["mobileno"] ?? "error",
        telno: json["tel"] ?? "error",
      );
}

class DeliveryAll {
  bool success;
  String message;
  List<Datum> data;

  DeliveryAll({
    required this.success,
    required this.message,
    required this.data,
  });

  factory DeliveryAll.fromJson(Map<String, dynamic> json) => DeliveryAll(
      success: json["success"] ?? false,
      message: json["message"] ?? "error",
      data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))));
}

class Datum {
  String awbnumber;
  String bookingdate;
  String consigneename;
  Consigneedetails consigneedetails;

  Datum({
    required this.awbnumber,
    required this.bookingdate,
    required this.consigneename,
    required this.consigneedetails,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
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
  String mobileno;
  String telno;

  Consigneedetails({
    required this.city,
    required this.state,
    required this.country,
    required this.address1,
    required this.address2,
    required this.mobileno,
    required this.telno,
  });

  factory Consigneedetails.fromJson(Map<String, dynamic> json) =>
      Consigneedetails(
        city: json["city"] ?? "error",
        state: json["state"] ?? "error",
        country: json["country"] ?? "error",
        address1: json["address1"] ?? "error",
        address2: json["address2"] ?? "error",
        mobileno: json["mobileno"] ?? "error",
        telno: json["telno"] ?? "error",
      );
}

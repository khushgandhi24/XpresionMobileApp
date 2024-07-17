class PickupAll {
  bool success;
  String message;
  List<Datum> data;

  PickupAll({
    required this.success,
    required this.message,
    required this.data,
  });

  factory PickupAll.fromJson(Map<String, dynamic> json) => PickupAll(
        success: json["success"],
        message: json["message"],
        data: List<Datum>.from(json["data"].map((e) => Datum.fromJson(e))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  int? id;
  String? pickupno;
  String? pickupdate;
  String? contactperson;
  String? shippername;
  String? status;

  Datum({
    required this.id,
    required this.pickupno,
    required this.pickupdate,
    required this.contactperson,
    required this.shippername,
    required this.status,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"] ?? 5,
        pickupno: json["pickupno"] ?? "N/A",
        pickupdate: json["pickupdate"] ?? "N/A",
        contactperson: json["contactperson"] ?? "N/A",
        shippername: json["shippername"] ?? "N/A",
        status: json["status"] ?? "N/A",
      );

  Map<String, dynamic> toJson() => {
        "id": id ?? 5,
        "pickupno": pickupno ?? "N/A",
        "pickupdate": pickupdate ?? "N/A",
        "contactperson": contactperson ?? "N/A",
        "shippername": shippername ?? "N/A",
        "status": status ?? "N/A",
      };
}

class PickupId {
  bool success;
  String message;
  List<IDDatum> data;

  PickupId({
    required this.success,
    required this.message,
    required this.data,
  });

  factory PickupId.fromJson(Map<String, dynamic> json) => PickupId(
        success: json["success"] ?? false,
        message: json["message"] ?? "error",
        data: List<IDDatum>.from(json["data"].map((e) => IDDatum.fromJson(e))),
      );
}

class IDDatum {
  String pickupNo;
  int? customerid;
  String pickupdate;
  String contactperson;
  List<Detail> details;
  String? servicecenterid;
  int? fieldexecutiveid;
  String? salesexecutiveid;
  String vehicletype;
  String? specialinstructions;
  String? status;
  List<double>? latlng;

  IDDatum({
    required this.pickupNo,
    required this.customerid,
    required this.pickupdate,
    required this.contactperson,
    required this.details,
    required this.servicecenterid,
    required this.fieldexecutiveid,
    required this.salesexecutiveid,
    required this.vehicletype,
    required this.specialinstructions,
    required this.status,
    this.latlng = const [19.0, 27.0],
  });

  factory IDDatum.fromJson(Map<String, dynamic> json) => IDDatum(
        pickupNo: json["pickupNo"] ?? "error",
        customerid: json["customerid"] ?? 0,
        pickupdate: json["pickupdate"] ?? "error",
        contactperson: json["contactperson"] ?? "error",
        details:
            List<Detail>.from(json["details"].map((e) => Detail.fromJson(e))),
        servicecenterid: json["servicecenterid"] ?? "error",
        fieldexecutiveid: json["fieldexecutiveid"] ?? 0,
        salesexecutiveid: json["salesexecutiveid"] ?? "error",
        vehicletype: json["vehicletype"] ?? "error",
        specialinstructions: json["specialinstructions"] ?? "None",
        status: json["status"] ?? "error",
      );
}

class Detail {
  String type;
  Info? info;
  Loc? location;

  Detail({
    required this.type,
    this.info,
    this.location,
  });

  factory Detail.fromJson(Map<String, dynamic> json) => Detail(
        type: json["type"] ?? "error",
        info: json["info"] != null ? Info.fromJson(json["info"]) : null,
        location:
            json["location"] != null ? Loc.fromJson(json["location"]) : null,
      );
}

class Info {
  int? id;
  String code;
  String name;

  Info({
    required this.id,
    required this.code,
    required this.name,
  });

  factory Info.fromJson(Map<String, dynamic> json) => Info(
        id: json["id"] ?? 0,
        code: json["code"] ?? "error",
        name: json["name"] ?? "error",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "code": code,
        "name": name,
      };
}

class Loc {
  int? tel;
  String? area;
  String? city;
  String? state;
  String? country;
  String? pincode;
  String? address1;
  String? address2;
  int? mobileno;

  Loc({
    this.tel,
    this.area,
    this.city,
    this.state,
    this.country,
    this.pincode,
    this.address1,
    this.address2,
    this.mobileno,
  });

  factory Loc.fromJson(Map<String, dynamic> json) => Loc(
        tel: json["tel"] ?? 0,
        area: json["area"] ?? "N/A",
        city: json["city"] ?? "N/A",
        state: json["state"] ?? "N/A",
        country: json["country"] ?? "N/A",
        address1: json["address1"] ?? "N/A",
        address2: json["address2"] ?? "India",
        mobileno: json["mobileno"] ?? 0,
        pincode: json["pincode"] ?? "N/A",
      );

  Map<String, dynamic> toJson() => {
        "tel": tel ?? 0,
        "area": area ?? "N/A",
        "city": city,
        "state": state,
        "country": country,
        "address1": address1,
        "address2": address2,
        "mobileno": mobileno,
        "pincode": pincode ?? "N/A",
      };
}

class Token {
  bool success;
  String message;
  List<Datum> data;
  String accesstoken;
  String refreshtoken;

  Token({
    required this.success,
    required this.message,
    required this.data,
    required this.accesstoken,
    required this.refreshtoken,
  });

  factory Token.fromJson(Map<String, dynamic> json) => Token(
        success: json["success"],
        message: json["message"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        accesstoken: json["accesstoken"],
        refreshtoken: json["refreshtoken"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "accesstoken": accesstoken,
        "refreshtoken": refreshtoken,
      };
}

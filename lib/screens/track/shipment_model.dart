class Shipment {
  bool success;
  String message;
  List<ShipDatum> data;

  Shipment({
    required this.success,
    required this.message,
    required this.data,
  });

  factory Shipment.fromJson(Map<String, dynamic> json) => Shipment(
        success: json['success'] ?? false,
        message: json['message'] ?? "error",
        data: List<ShipDatum>.from(
            json['data'].map((e) => ShipDatum.fromJson(e))),
      );

  // Map<String, dynamic> toJson() => {
  //     "success": success,
  //     "message": message,
  //     "data": List<dynamic>.from(data.map((x) => x.toJson())),
  // };
}

class ShipDatum {
  String transactionstatus;
  String transactiondate;
  String transactiontime;

  ShipDatum({
    required this.transactionstatus,
    required this.transactiondate,
    required this.transactiontime,
  });

  factory ShipDatum.fromJson(Map<String, dynamic> json) => ShipDatum(
        transactionstatus: json['transactionstatus'] ?? "error",
        transactiondate: json['transactiondate'] ?? "error",
        transactiontime: json['transactiontime'] ?? "error",
      );

  // Map<String, dynamic> toJson() => {
  //   'transactionstatus': transactionstatus,
  //   'transactiondate': transactiondate,
  //   'transactiontime': transactiontime,
  // };
}

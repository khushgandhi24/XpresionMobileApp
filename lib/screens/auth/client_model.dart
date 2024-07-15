class Client {
  bool success;
  String message;
  List<Datum> data;
  String accesstoken;
  String refreshtoken;

  Client({
    required this.success,
    required this.message,
    required this.data,
    required this.accesstoken,
    required this.refreshtoken,
  });

  factory Client.fromJson(Map<String, dynamic> json) => Client(
        success: json["success"] ?? false,
        message: json["message"] ?? "error",
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        accesstoken: json["accesstoken"] ?? "error",
        refreshtoken: json["refreshtoken"] ?? "error",
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "accesstoken": accesstoken,
        "refreshtoken": refreshtoken,
      };
}

class Datum {
  int id;
  String username;
  String logintype;
  String metainfo;
  int groupid;
  String groupname;
  int roleid;
  String fileid;

  Datum({
    required this.id,
    required this.username,
    required this.logintype,
    required this.metainfo,
    required this.groupid,
    required this.groupname,
    required this.roleid,
    required this.fileid,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"] ?? 0,
        username: json["username"] ?? "error",
        logintype: json["logintype"] ?? "error",
        metainfo: json["metainfo"] ?? "error",
        groupid: json["groupid"] ?? 0,
        groupname: json["groupname"] ?? "error",
        roleid: json["roleid"] ?? 0,
        fileid: json["fileid"] ?? "error",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "logintype": logintype,
        "metainfo": metainfo,
        "groupid": groupid,
        "groupname": groupname,
        "roleid": roleid,
        "fileid": fileid,
      };
}

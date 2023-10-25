// To parse this JSON data, do
//
//     final districtResponse = districtResponseFromMap(jsonString);

import 'dart:convert';

DistrictResponse districtResponseFromMap(String str) => DistrictResponse.fromMap(json.decode(str));

String districtResponseToMap(DistrictResponse data) => json.encode(data.toMap());

class DistrictResponse {
  Status status;
  List<Datum> data;

  DistrictResponse({
    required this.status,
    required this.data,
  });

  factory DistrictResponse.fromMap(Map<String, dynamic> json) => DistrictResponse(
    status: Status.fromMap(json["status"]),
    data: List<Datum>.from(json["data"].map((x) => Datum.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    "status": status.toMap(),
    "data": List<dynamic>.from(data.map((x) => x.toMap())),
  };

  @override
  String toString() {
    return 'DistrictResponse{status: $status, data: $data}';
  }
}

class Datum {
  String id;
  String district;
  String districtbn;
  String coordinates;

  Datum({
    required this.id,
    required this.district,
    required this.districtbn,
    required this.coordinates,
  });

  factory Datum.fromMap(Map<String, dynamic> json) => Datum(
    id: json["_id"],
    district: json["district"],
    districtbn: json["districtbn"],
    coordinates: json["coordinates"],
  );

  Map<String, dynamic> toMap() => {
    "_id": id,
    "district": district,
    "districtbn": districtbn,
    "coordinates": coordinates,
  };

  @override
  String toString() {
    return 'Datum{id: $id, district: $district, districtbn: $districtbn, coordinates: $coordinates}';
  }
}

class Status {
  int code;
  String message;
  String date;

  Status({
    required this.code,
    required this.message,
    required this.date,
  });

  factory Status.fromMap(Map<String, dynamic> json) => Status(
    code: json["code"],
    message: json["message"],
    date: json["date"],
  );

  Map<String, dynamic> toMap() => {
    "code": code,
    "message": message,
    "date": date,
  };

  @override
  String toString() {
    return 'Status{code: $code, message: $message, date: $date}';
  }
}

/// IS_GPS : "OFF"
/// GPS_INTERVAL : 1
/// status : "OK"

class GetGpsStatusResModel {
  GetGpsStatusResModel({
    this.isgps,
    this.gpsinterval,
    this.status,
  });

  GetGpsStatusResModel.fromJson(dynamic json) {
    isgps = json['IS_GPS'];
    gpsinterval = json['GPS_INTERVAL'] ?? 1;
    status = json['status'];
  }
  String? isgps;
  int? gpsinterval;
  String? status;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['IS_GPS'] = isgps;
    map['GPS_INTERVAL'] = gpsinterval;
    map['status'] = status;
    return map;
  }
}

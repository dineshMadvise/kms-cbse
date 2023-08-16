/// latitude : "22.303894"
/// longitude : "70.802162"
/// date_time : "2022-01-22 13:10:00"

class LocationReqModel {
  LocationReqModel({
    this.latitude,
    this.longitude,
    this.dateTime,
  });

  LocationReqModel.fromJson(dynamic json) {
    latitude = json['latitude'];
    longitude = json['longitude'];
    dateTime = json['date_time'];
  }
  String? latitude;
  String? longitude;
  String? dateTime;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['latitude'] = latitude;
    map['longitude'] = longitude;
    map['date_time'] = dateTime;
    return map;
  }
}

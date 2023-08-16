class GetTransportInfoResModel {
  GetTransportInfoResModel({this.data, this.status, this.msg});

  GetTransportInfoResModel.fromJson(dynamic json) {
    if (json['DATA'] != null) {
      if (json['DATA'] is List<dynamic>) {
        if ((json['DATA'] as List<dynamic>).isEmpty) {
          msg = 'No record found';
        } else {
          json['DATA'].forEach((v) {
            data?.add(Data.fromJson(v));
          });
        }
      } else {
        msg = json['DATA'];
      }
    }
    status = json['status'];
  }

  List<Data>? data = [];
  String? status;
  String? msg;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (data != null) {
      map['DATA'] = data?.map((v) => v.toJson()).toList();
    }
    map['status'] = status;
    return map;
  }
}

class Data {
  Data({
    this.vehicleName,
    this.vehicleNo,
    this.driverName,
    this.driverNo,
    this.schoolLatitude,
    this.schoolLongitude,
    this.currentLatitude,
    this.currentLongitude,
    this.stopLatitude,
    this.stopLongitude,
    this.lastUpdatedTime,
  });

  Data.fromJson(dynamic json) {
    vehicleName = json['vehicle_name'];
    vehicleNo = json['vehicle_no'];
    driverName = json['driver_name'];
    driverNo = json['driver_no'];
    schoolLatitude = json['school_latitude'] ?? "";
    schoolLongitude = json['school_longitude'] ?? '';
    currentLatitude = json['current_latitude'] ?? '';
    currentLongitude = json['current_longitude'] ?? '';
    // currentLatitude = '21.2378888';
    // currentLongitude = '72.863352';
    stopLatitude = json['stop_latitude'] ?? "";
    stopLongitude = json['stop_longitude'] ?? '';
    lastUpdatedTime = json['last_updated_time'];
  }

  String? vehicleName;
  String? vehicleNo;
  String? driverName;
  String? driverNo;
  String? schoolLatitude;
  String? schoolLongitude;
  String? currentLatitude;
  String? currentLongitude;
  String? stopLatitude;
  String? stopLongitude;
  String? lastUpdatedTime;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['vehicle_name'] = vehicleName;
    map['vehicle_no'] = vehicleNo;
    map['driver_name'] = driverName;
    map['driver_no'] = driverNo;
    map['school_latitude'] = schoolLatitude;
    map['school_longitude'] = schoolLongitude;
    map['current_latitude'] = currentLatitude;
    map['current_longitude'] = currentLongitude;
    map['stop_latitude'] = stopLatitude;
    map['stop_longitude'] = stopLongitude;
    map['last_updated_time'] = lastUpdatedTime;
    return map;
  }
}

class GetSmsListResModel {
  GetSmsListResModel({
    this.data,
    this.status,
  });

  GetSmsListResModel.fromJson(dynamic json) {
    if (json['DATA'] != null) {
      data = [];
      json['DATA'].forEach((v) {
        data?.add(Data.fromJson(v));
      });
    }
    status = json['status'];
  }

  List<Data>? data;
  String? status;

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
    this.campaignName,
    this.createdOn,
    this.smsId,
    this.totalSent,
    this.totalFailed,
    this.creditUsage,
  });

  Data.fromJson(dynamic json) {
    campaignName = json['campaign_name'];
    createdOn = json['created_on'];
    smsId = json['sms_id'];
    totalSent = json['total_sent'];
    totalFailed = json['total_failed'];
    creditUsage = json['credit_usage'];
  }

  String? campaignName;
  String? createdOn;
  String? smsId;
  String? totalSent;
  String? totalFailed;
  String? creditUsage;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['campaign_name'] = campaignName;
    map['created_on'] = createdOn;
    map['sms_id'] = smsId;
    map['total_sent'] = totalSent;
    map['total_failed'] = totalFailed;
    map['credit_usage'] = creditUsage;
    return map;
  }
}

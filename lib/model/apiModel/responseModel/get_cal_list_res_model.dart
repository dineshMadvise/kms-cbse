class GetCalListResModel {
  GetCalListResModel({
      this.data, 
      this.status,});

  GetCalListResModel.fromJson(dynamic json) {
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
      this.template, 
      this.totalSent, 
      this.totalFailed, 
      this.creditUsage, 
      this.createdOn,});

  Data.fromJson(dynamic json) {
    campaignName = json['campaign_name'];
    template = json['template'];
    totalSent = json['total_sent'];
    totalFailed = json['total_failed'];
    creditUsage = json['credit_usage'];
    createdOn = json['created_on'];
  }
  String? campaignName;
  String? template;
  String? totalSent;
  String? totalFailed;
  String? creditUsage;
  String? createdOn;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['campaign_name'] = campaignName;
    map['template'] = template;
    map['total_sent'] = totalSent;
    map['total_failed'] = totalFailed;
    map['credit_usage'] = creditUsage;
    map['created_on'] = createdOn;
    return map;
  }

}
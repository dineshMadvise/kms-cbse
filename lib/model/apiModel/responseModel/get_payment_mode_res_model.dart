class GetPaymentModeResModel {
  GetPaymentModeResModel({
    this.data,
    this.status,
  });

  GetPaymentModeResModel.fromJson(dynamic json) {
    data = json['DATA'] != null ? json['DATA'].cast<String>() : [];
    status = json['status'];
  }
  List<String>? data;
  String? status;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['DATA'] = data;
    map['status'] = status;
    return map;
  }
}

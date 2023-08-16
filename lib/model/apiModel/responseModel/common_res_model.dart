class CommonResModel {
  CommonResModel({
    this.data,
    this.status,
  });

  CommonResModel.fromJson(Map<String, dynamic> json) {
    data = json['DATA']?.toString();
    status = json['status'];
  }
  String? data;
  String? status;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['DATA'] = data;
    map['status'] = status;
    return map;
  }
}

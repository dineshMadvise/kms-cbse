import 'package:msp_educare_demo/model/apiModel/responseModel/get_homework_list_res_model.dart';

class GetHomeworkDetailResModel {
  GetHomeworkDetailResModel({
      this.data, 
      this.status,});

  GetHomeworkDetailResModel.fromJson(dynamic json) {
    if (json['DATA'] != null) {
      data = [];
      json['DATA'].forEach((v) {
        data?.add(HomeWorkData.fromJson(v));
      });
    }
    status = json['status'];
  }
  List<HomeWorkData>? data;
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

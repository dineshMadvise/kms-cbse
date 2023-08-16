// ignore_for_file: unnecessary_new, prefer_collection_literals, unnecessary_this

class GetEditExpensesStatusResModel {
  List<String>? dATA;
  String? status;

  GetEditExpensesStatusResModel({this.dATA, this.status});

  GetEditExpensesStatusResModel.fromJson(Map<String, dynamic> json) {
    dATA = json['DATA'].cast<String>();
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['DATA'] = this.dATA;
    data['status'] = this.status;
    return data;
  }
}

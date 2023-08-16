// ignore_for_file: unnecessary_new, prefer_collection_literals, unnecessary_this

class GetEditExpensesOption {
  List<DATA>? dATA;
  String? status;

  GetEditExpensesOption({this.dATA, this.status});

  GetEditExpensesOption.fromJson(Map<String, dynamic> json) {
    if (json['DATA'] != null) {
      dATA = <DATA>[];
      json['DATA'].forEach((v) {
        dATA!.add(new DATA.fromJson(v));
      });
    }
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.dATA != null) {
      data['DATA'] = this.dATA!.map((v) => v.toJson()).toList();
    }
    data['status'] = this.status;
    return data;
  }
}

class DATA {
  String? id;
  String? name;

  DATA({this.id, this.name});

  DATA.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}

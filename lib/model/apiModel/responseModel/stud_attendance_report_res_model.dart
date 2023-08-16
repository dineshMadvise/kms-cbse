class StudAttendanceReportResModel {
  List<DATA>? dATA;
  String? status;

  StudAttendanceReportResModel({this.dATA, this.status});

  StudAttendanceReportResModel.fromJson(Map<String, dynamic> json) {
    if (json['DATA'] != null) {
      dATA = <DATA>[];
      json['DATA'].forEach((v) {
        dATA!.add(DATA.fromJson(v));
      });
    }
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (dATA != null) {
      data['DATA'] = dATA!.map((v) => v.toJson()).toList();
    }
    data['status'] = status;
    return data;
  }
}

class DATA {
  int? tOTALPRESENT;
  int? tOTALABSENT;
  int? tOTALNOTMARKED;
  int? totalStudent;

  DATA({this.tOTALPRESENT, this.tOTALABSENT, this.tOTALNOTMARKED});

  DATA.fromJson(Map<String, dynamic> json) {
    tOTALPRESENT = json['TOTAL_PRESENT'];
    tOTALABSENT = json['TOTAL_ABSENT'];
    tOTALNOTMARKED = json['TOTAL_NOT_MARKED'];
    totalStudent = json['TOTAL_STUDENT'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['TOTAL_PRESENT'] = tOTALPRESENT;
    data['TOTAL_ABSENT'] = tOTALABSENT;
    data['TOTAL_NOT_MARKED'] = tOTALNOTMARKED;
    data['TOTAL_STUDENT'] = totalStudent;
    return data;
  }
}

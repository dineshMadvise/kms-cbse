class ExamScoreReportResModel {
  ExamScoreReportResModel({
    this.data,
    this.status,
  });

  ExamScoreReportResModel.fromJson(dynamic json) {
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
    this.startDate,
    this.examType,
    this.scoreList,
    this.total,
  });

  Data.fromJson(dynamic json) {
    startDate = json['start_date'];
    examType = json['exam_type'];
    if (json['score_list'] != null) {
      scoreList = [];
      json['score_list'].forEach((v) {
        scoreList?.add(ScoreList.fromJson(v));
      });
    }
    total = json['total'];
  }
  String? startDate;
  String? examType;
  List<ScoreList>? scoreList;
  String? total;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['start_date'] = startDate;
    map['exam_type'] = examType;
    if (scoreList != null) {
      map['score_list'] = scoreList?.map((v) => v.toJson()).toList();
    }
    map['total'] = total;
    return map;
  }
}

class ScoreList {
  ScoreList({
    this.subjectName,
    this.score,
    this.result,
  });

  ScoreList.fromJson(dynamic json) {
    subjectName = json['subject_name'];
    score = json['score'];
    result = json['result'];
  }
  String? subjectName;
  String? score;
  String? result;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['subject_name'] = subjectName;
    map['score'] = score;
    map['result'] = result;
    return map;
  }
}

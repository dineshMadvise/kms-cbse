/// DATA : [{"start_date":"07 Dec 2021","exam_type":"Term1 Test","score_list":[{"subject_name":"Mathematics","score":"67"},{"subject_name":"English","score":"100"}],"total":167},{"start_date":"22 Nov 2021","exam_type":"demo test 1","score_list":[{"subject_name":"TELGU","score":null}],"total":0},{"start_date":"15 Nov 2021","exam_type":"Unit Test 1","score_list":[{"subject_name":"Mathematics","score":null},{"subject_name":"EVS","score":null},{"subject_name":"Hindi","score":null},{"subject_name":"Computer Science","score":null},{"subject_name":"TELGU","score":null}],"total":0},{"start_date":"28 Oct 2021","exam_type":"Term1 Test","score_list":[{"subject_name":"English","score":"100"},{"subject_name":"EVS","score":"98"},{"subject_name":"Computer Science","score":"87"},{"subject_name":"Mathematics","score":"67"},{"subject_name":"Hindi","score":"83"}],"total":435},{"start_date":"11 Oct 2021","exam_type":"demo test 1","score_list":[{"subject_name":"Computer Science","score":null}],"total":0}]
/// status : "OK"

class GetExamScoreListResModel {
  GetExamScoreListResModel({this.data, this.status, this.msg});

  GetExamScoreListResModel.fromJson(dynamic json) {
    if (json['DATA'] != null) {
      if (json['DATA'] is List<dynamic>) {
        if ((json['DATA'] as List<dynamic>).isEmpty) {
          msg = 'No record found';
        } else {
          json['DATA'].forEach((v) {
            data?.add(ExamScoreData.fromJson(v));
          });
        }
      } else {
        msg = json['DATA'];
      }
    }
    status = json['status'];
  }

  List<ExamScoreData>? data = [];
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

/// start_date : "07 Dec 2021"
/// exam_type : "Term1 Test"
/// score_list : [{"subject_name":"Mathematics","score":"67"},{"subject_name":"English","score":"100"}]
/// total : 167

class ExamScoreData {
  ExamScoreData({
    this.startDate,
    this.examType,
    this.scoreList,
    this.total,
  });

  ExamScoreData.fromJson(dynamic json) {
    startDate = json['start_date'];
    examType = json['exam_type'];
    if (json['score_list'] != null) {
      scoreList = [];
      json['score_list'].forEach((v) {
        scoreList?.add(ScoreList.fromJson(v));
      });
    }
    // total = json['total'] is int
    //     ? (json['total'] as int).toDouble()
    //     : json['total'];
    total = json['total'];
  }

  String? startDate;
  String? examType;
  List<ScoreList>? scoreList;
  dynamic total;

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

/// subject_name : "Mathematics"
/// score : "67"

class ScoreList {
  ScoreList({
    this.subjectName,
    this.score,
    this.result,
  });

  ScoreList.fromJson(dynamic json) {
    subjectName = json['subject_name'];
    score = json['score'] == "" || json['score'] == null ? '0' : json['score'];
    result = json['result'] ?? "";
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

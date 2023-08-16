/// DATA : [{"exam_type":"Term1 Test","exam_date":"07 Dec 2021 - 08 Dec 2021","list":[{"start_date":"07/12/2021","start_time":"10.18","end_time":"12.18","subject_name":"Mathematics","syllabus":"Unit 1, Unit 2"},{"start_date":"08/12/2021","start_time":"10.18","end_time":"12.18","subject_name":"English","syllabus":"Unit 1 & 2"}]},{"exam_type":"demo test 1","exam_date":"22 Nov 2021","list":[{"start_date":"22/11/2021","start_time":"16.10","end_time":"16.30","subject_name":"TELGU","syllabus":""}]},{"exam_type":"Unit Test 1","exam_date":"15 Nov 2021 - 19 Nov 2021","list":[{"start_date":"15/11/2021","start_time":"09.10","end_time":"10.10","subject_name":"Mathematics","syllabus":"addtion , numbers name"},{"start_date":"16/11/2021","start_time":"09.10","end_time":"12.10","subject_name":"EVS","syllabus":"Transport, "},{"start_date":"17/11/2021","start_time":"09.10","end_time":"12.10","subject_name":"Hindi","syllabus":"oral test in days of the week , daysd of the month "},{"start_date":"18/11/2021","start_time":"09.10","end_time":"10.10","subject_name":"Computer Science","syllabus":"lesson 1, lesson 2"},{"start_date":"19/11/2021","start_time":"09.10","end_time":"10.10","subject_name":"TELGU","syllabus":"lesson 1"}]},{"exam_type":"Term1 Test","exam_date":"28 Oct 2021 - 05 Nov 2021","list":[{"start_date":"28/10/2021","start_time":"09.10","end_time":"10.10","subject_name":"English","syllabus":"Lesson 1 - \nlesson 2 \nlesson 3\n poem \nrefers course book, note book, work sheet \ngrammar book "},{"start_date":"30/10/2021","start_time":"09.10","end_time":"10.00","subject_name":"EVS","syllabus":"Leeson 1 , lesson 2, lesson 3, lesson 4 \nRefer course bioik , note book \nworks sheet "},{"start_date":"01/11/2021","start_time":"09.11","end_time":"10.10","subject_name":"Computer Science","syllabus":"Leeson 1 ,lesson2 , lesson3 , note book , course book, note book , refer course book , note book "},{"start_date":"03/11/2021","start_time":"09.10","end_time":"10.10","subject_name":"Mathematics","syllabus":"lesson 1 , lesson2 ,lesson3 , refer course book , ,work sheet ,grammar book"},{"start_date":"05/11/2021","start_time":"09.10","end_time":"10.10","subject_name":"Hindi","syllabus":"Lesson 1 , leson2 , lesson 3, lesso 4 , refer course book ,nore book awork sheet "}]},{"exam_type":"demo test 1","exam_date":"11 Oct 2021","list":[{"start_date":"11/10/2021","start_time":"15.30","end_time":"15.45","subject_name":"Computer Science","syllabus":"gsdgsgs"}]}]
/// status : "OK"

class GetExamTimetableListResModel {
  GetExamTimetableListResModel({this.data, this.status, this.msg});

  List<Data>? data = [];
  String? status;
  String? msg;

  GetExamTimetableListResModel.fromJson(dynamic json) {
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
}

/// exam_type : "Term1 Test"
/// exam_date : "07 Dec 2021 - 08 Dec 2021"
/// list : [{"start_date":"07/12/2021","start_time":"10.18","end_time":"12.18","subject_name":"Mathematics","syllabus":"Unit 1, Unit 2"},{"start_date":"08/12/2021","start_time":"10.18","end_time":"12.18","subject_name":"English","syllabus":"Unit 1 & 2"}]

class Data {
  Data({this.examType, this.examDate, this.list, this.classStr, this.section});

  Data.fromJson(dynamic json) {
    examType = json['exam_type'];
    examDate = json['exam_date'];
    classStr = json['class'];
    section = json['section'];
    if (json['list'] != null) {
      list = [];
      json['list'].forEach((v) {
        list?.add(ListData.fromJson(v));
      });
    }
  }

  String? examType;
  String? examDate;
  String? classStr;
  String? section;
  List<ListData>? list;
}

/// start_date : "07/12/2021"
/// start_time : "10.18"
/// end_time : "12.18"
/// subject_name : "Mathematics"
/// syllabus : "Unit 1, Unit 2"

class ListData {
  ListData({
    this.startDate,
    this.startTime,
    this.endTime,
    this.subjectName,
    this.syllabus,
  });

  ListData.fromJson(dynamic json) {
    startDate = json['start_date'];
    startTime = json['start_time'];
    endTime = json['end_time'];
    subjectName = json['subject_name'];
    syllabus = json['syllabus'];
  }

  String? startDate;
  String? startTime;
  String? endTime;
  String? subjectName;
  String? syllabus;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['start_date'] = startDate;
    map['start_time'] = startTime;
    map['end_time'] = endTime;
    map['subject_name'] = subjectName;
    map['syllabus'] = syllabus;
    return map;
  }
}

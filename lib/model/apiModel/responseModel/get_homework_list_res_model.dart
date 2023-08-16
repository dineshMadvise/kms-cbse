// ignore_for_file: unnecessary_new, prefer_collection_literals, unnecessary_this

class GetHomeworkListResModel {
  List<HomeWorkData>? dATA = [];
  String? status;
  String? msg;

  GetHomeworkListResModel({this.dATA, this.status, this.msg});

  GetHomeworkListResModel.fromJson(Map<String, dynamic> json) {
    if (json['DATA'] != null) {
      if (json['DATA'] is List<dynamic>) {
        if ((json['DATA'] as List<dynamic>).isEmpty) {
          msg = 'No record found';
        } else {
          json['DATA'].forEach((v) {
            dATA?.add(HomeWorkData.fromJson(v));
          });
        }
      } else {
        msg = json['DATA'];
      }
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

class HomeWorkData {
  String? id;
  String? academicYearId;
  String? hDate;
  String? title;
  String? description;
  String? completeDate;
  String? attachmentType;
  String? docFileId;
  String? attachment;
  String? attchmentDocLink;
  String? fileName;
  String? classId;
  String? sectionId;
  String? subjectId;
  String? teacherId;
  String? status;
  String? approvalStaff;
  String? usedFlag;
  String? deletedFlag;
  String? createdBy;
  String? updatedBy;
  String? createdUserType;
  String? updatedUserType;
  String? createdOn;
  String? updatedOn;
  String? sentFlag;
  String? className;
  String? subjectName;
  String? teacherName;
  String? submissionFile;
  String? remark;
  String? dateOnly;
  int? hwCount;
  List<SubmissionList>? submissionList = [];

  HomeWorkData(
      {this.id,
      this.academicYearId,
      this.hDate,
      this.title,
      this.description,
      this.completeDate,
      this.attachmentType,
      this.docFileId,
      this.attachment,
      this.attchmentDocLink,
      this.fileName,
      this.classId,
      this.sectionId,
      this.subjectId,
      this.teacherId,
      this.status,
      this.approvalStaff,
      this.usedFlag,
      this.deletedFlag,
      this.createdBy,
      this.updatedBy,
      this.createdUserType,
      this.updatedUserType,
      this.createdOn,
      this.updatedOn,
      this.sentFlag,
      this.className,
      this.subjectName,
      this.teacherName,
      this.submissionFile,
      this.remark,
      this.dateOnly,
      this.hwCount,
      this.submissionList});

  HomeWorkData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    academicYearId = json['academic_year_id'];
    hDate = json['h_date'];
    title = json['title'];
    description = json['description'];
    completeDate = json['complete_date'];
    attachmentType = json['attachment_type'];
    docFileId = json['doc_file_id'];
    attachment = json['attachment'] == "" ? null : json['attachment'];
    attchmentDocLink =
        json['attchment_doc_link'] == "" ? null : json['attchment_doc_link'];
    fileName = json['file_name'];
    classId = json['class_id'];
    sectionId = json['section_id'];
    subjectId = json['subject_id'];
    teacherId = json['teacher_id'];
    status = json['status'];
    approvalStaff = json['approval_staff'];
    usedFlag = json['used_flag'];
    deletedFlag = json['deleted_flag'];
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
    createdUserType = json['created_user_type'];
    updatedUserType = json['updated_user_type'];
    createdOn = json['created_on'];
    updatedOn = json['updated_on'];
    sentFlag = json['sent_flag'];
    className = json['class_name'];
    subjectName = json['subject_name'];
    teacherName = json['teacher_name'];
    submissionFile = json['submission_file'];
    remark = json['remark'] == '' ? null : json['remark'];
    dateOnly = json['date_only'];
    hwCount = json['hw_count'];
    if (json['submission_list'] != null) {
      submissionList = <SubmissionList>[];
      json['submission_list'].forEach((v) {
        submissionList!.add(new SubmissionList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['academic_year_id'] = this.academicYearId;
    data['h_date'] = this.hDate;
    data['title'] = this.title;
    data['description'] = this.description;
    data['complete_date'] = this.completeDate;
    data['attachment_type'] = this.attachmentType;
    data['doc_file_id'] = this.docFileId;
    data['attachment'] = this.attachment;
    data['attchment_doc_link'] = this.attchmentDocLink;
    data['file_name'] = this.fileName;
    data['class_id'] = this.classId;
    data['section_id'] = this.sectionId;
    data['subject_id'] = this.subjectId;
    data['teacher_id'] = this.teacherId;
    data['status'] = this.status;
    data['approval_staff'] = this.approvalStaff;
    data['used_flag'] = this.usedFlag;
    data['deleted_flag'] = this.deletedFlag;
    data['created_by'] = this.createdBy;
    data['updated_by'] = this.updatedBy;
    data['created_user_type'] = this.createdUserType;
    data['updated_user_type'] = this.updatedUserType;
    data['created_on'] = this.createdOn;
    data['updated_on'] = this.updatedOn;
    data['sent_flag'] = this.sentFlag;
    data['class_name'] = this.className;
    data['subject_name'] = this.subjectName;
    data['teacher_name'] = this.teacherName;
    data['submission_file'] = this.submissionFile;
    data['remark'] = this.remark;
    data['date_only'] = this.dateOnly;
    data['hw_count'] = this.hwCount;
    if (this.submissionList != null) {
      data['submission_list'] =
          this.submissionList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SubmissionList {
  String? studentPic;
  String? studentName;
  String? remark;
  String? attachment;
  String? parentId;
  String? studentId;
  String? homeworkId;
  String? createdOn;
  String? className;

  SubmissionList(
      {this.studentPic,
      this.studentName,
      this.remark,
      this.attachment,
      this.parentId,
      this.studentId,
      this.homeworkId,
      this.className,
      this.createdOn});

  SubmissionList.fromJson(Map<String, dynamic> json) {
    studentPic = json['student_pic'];
    studentName = json['student_name'];
    remark = json['remark'];
    attachment = json['attachment'];
    parentId = json['parent_id'];
    studentId = json['student_id'];
    homeworkId = json['homework_id'];
    createdOn = json['created_on'];
    className = json['class_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['student_pic'] = this.studentPic;
    data['student_name'] = this.studentName;
    data['remark'] = this.remark;
    data['attachment'] = this.attachment;
    data['parent_id'] = this.parentId;
    data['student_id'] = this.studentId;
    data['homework_id'] = this.homeworkId;
    data['created_on'] = this.createdOn;
    return data;
  }
}

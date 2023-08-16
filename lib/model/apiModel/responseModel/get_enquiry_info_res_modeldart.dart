class GetEnquiryInfoResModel {
  GetEnquiryInfoResModel({
    this.data,
    this.status,
  });

  GetEnquiryInfoResModel.fromJson(dynamic json) {
    if (json['DATA'] != null) {
      data = [];
      json['DATA'].forEach((v) {
        data?.add(EnquiryData.fromJson(v));
      });
    }
    status = json['status'];
  }
  List<EnquiryData>? data;
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

class EnquiryData {
  EnquiryData({
    this.id,
    this.refno,
    this.academicYearId,
    this.status,
    this.name,
    this.surname,
    this.dob,
    this.age,
    this.nationality,
    this.gender,
    this.classId,
    this.previousSchool,
    this.fName,
    this.fQualification,
    this.fPhoneno,
    this.emailid,
    this.fVisa,
    this.fOrganization,
    this.fDesignation,
    this.mName,
    this.mQualification,
    this.mPhoneno,
    this.mVisa,
    this.mOrganization,
    this.mDesignation,
    this.addressline1,
    this.area,
    this.pincode,
    this.howKnow,
    this.specify,
    this.comments,
    this.counselor,
    this.usedFlag,
    this.deletedFlag,
    this.createdBy,
    this.updatedBy,
    this.createdUserType,
    this.updatedUserType,
    this.createdOn,
    this.updatedOn,
    this.studentName,
    this.parentName,
    this.phoneNo,
  });

  EnquiryData.fromJson(dynamic json) {
    id = json['id'];
    refno = json['refno'];
    academicYearId = json['academic_year_id'];
    status = json['status'];
    name = json['name'];
    surname = json['surname'];
    dob = json['dob'];
    age = json['age'];
    nationality = json['nationality'];
    gender = json['gender'];
    classId = json['class_id'];
    previousSchool = json['previous_school'];
    fName = json['f_name'];
    fQualification = json['f_qualification'];
    fPhoneno = json['f_phoneno'];
    emailid = json['emailid'];
    fVisa = json['f_visa'];
    fOrganization = json['f_organization'];
    fDesignation = json['f_designation'];
    mName = json['m_name'];
    mQualification = json['m_qualification'];
    mPhoneno = json['m_phoneno'];
    mVisa = json['m_visa'];
    mOrganization = json['m_organization'];
    mDesignation = json['m_designation'];
    addressline1 = json['addressline1'];
    area = json['area'];
    pincode = json['pincode'];
    howKnow = json['how_know'];
    specify = json['specify'];
    comments = json['comments'];
    counselor = json['counselor'];
    usedFlag = json['used_flag'];
    deletedFlag = json['deleted_flag'];
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
    createdUserType = json['created_user_type'];
    updatedUserType = json['updated_user_type'];
    createdOn = json['created_on'];
    updatedOn = json['updated_on'];
    studentName = json['student_name'];
    parentName = json['parent_name'];
    phoneNo = json['phone_no'];
  }
  String? id;
  String? refno;
  String? academicYearId;
  String? status;
  String? name;
  String? surname;
  String? dob;
  String? age;
  String? nationality;
  String? gender;
  String? classId;
  String? previousSchool;
  String? fName;
  String? fQualification;
  String? fPhoneno;
  String? emailid;
  String? fVisa;
  String? fOrganization;
  String? fDesignation;
  String? mName;
  String? mQualification;
  String? mPhoneno;
  String? mVisa;
  String? mOrganization;
  String? mDesignation;
  String? addressline1;
  String? area;
  String? pincode;
  String? howKnow;
  String? specify;
  String? comments;
  String? counselor;
  String? usedFlag;
  String? deletedFlag;
  String? createdBy;
  String? updatedBy;
  String? createdUserType;
  String? updatedUserType;
  String? createdOn;
  dynamic updatedOn;
  String? studentName;
  String? parentName;
  String? phoneNo;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['refno'] = refno;
    map['academic_year_id'] = academicYearId;
    map['status'] = status;
    map['name'] = name;
    map['surname'] = surname;
    map['dob'] = dob;
    map['age'] = age;
    map['nationality'] = nationality;
    map['gender'] = gender;
    map['class_id'] = classId;
    map['previous_school'] = previousSchool;
    map['f_name'] = fName;
    map['f_qualification'] = fQualification;
    map['f_phoneno'] = fPhoneno;
    map['emailid'] = emailid;
    map['f_visa'] = fVisa;
    map['f_organization'] = fOrganization;
    map['f_designation'] = fDesignation;
    map['m_name'] = mName;
    map['m_qualification'] = mQualification;
    map['m_phoneno'] = mPhoneno;
    map['m_visa'] = mVisa;
    map['m_organization'] = mOrganization;
    map['m_designation'] = mDesignation;
    map['addressline1'] = addressline1;
    map['area'] = area;
    map['pincode'] = pincode;
    map['how_know'] = howKnow;
    map['specify'] = specify;
    map['comments'] = comments;
    map['counselor'] = counselor;
    map['used_flag'] = usedFlag;
    map['deleted_flag'] = deletedFlag;
    map['created_by'] = createdBy;
    map['updated_by'] = updatedBy;
    map['created_user_type'] = createdUserType;
    map['updated_user_type'] = updatedUserType;
    map['created_on'] = createdOn;
    map['updated_on'] = updatedOn;
    map['student_name'] = studentName;
    map['parent_name'] = parentName;
    map['phone_no'] = phoneNo;
    return map;
  }
}

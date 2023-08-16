class NewAdmissionInquiryReqModel {
  String? studName;
  String? admissionClass;
  String? parentMobileNo;

  NewAdmissionInquiryReqModel(
      {this.admissionClass, this.parentMobileNo, this.studName});

  Map<String, dynamic> toJson() => {
        "action": "saveAdmissionInquiry",
        "student_name": studName,
        "admission_class": admissionClass,
        "parent_mobile_no": parentMobileNo
      };
}

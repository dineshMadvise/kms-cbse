class RegisterReqModel {
  String? schName;
  String? contactName;
  String? pNUmber;
  String? email;

  RegisterReqModel({
    this.schName,
    this.contactName,
    this.pNUmber,
    this.email,
  });

  Map<String, dynamic> toJson() => {
        "action": "signup",
        "school_name": schName,
        "contact_name": contactName,
        "phone": pNUmber,
        "email_id": email
      };
}

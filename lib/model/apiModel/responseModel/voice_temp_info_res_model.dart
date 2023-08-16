class VoiceTempInfoResModel {
  VoiceTempInfoResModel({
      this.data, 
      this.status,});

  VoiceTempInfoResModel.fromJson(dynamic json) {
    if (json['DATA'] != null) {
      data = [];
      json['DATA'].forEach((v) {
        data?.add(Data.fromJson(v));
      });
    }
    status = json['status'];
  }
  List<Data>? data;
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

class Data {
  Data({
      this.title, 
      this.voiceFile,});

  Data.fromJson(dynamic json) {
    title = json['title'];
    voiceFile = json['voice_file'];
  }
  String? title;
  String? voiceFile;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['title'] = title;
    map['voice_file'] = voiceFile;
    return map;
  }

}
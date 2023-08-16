class GetGalleryResModel {
  GetGalleryResModel({this.data, this.status, this.msg});

  GetGalleryResModel.fromJson(dynamic json) {
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
    this.title,
    this.description,
    this.date,
    this.posterImg,
    this.galleryImgs,
    this.galleryVideos,
  });

  Data.fromJson(dynamic json) {
    title = json['title'];
    description = json['description'];
    date = json['date'];
    posterImg = json['poster_img'];
    galleryImgs =
        json['gallery_imgs'] != null ? json['gallery_imgs'].cast<String>() : [];
    galleryVideos = json['gallery_videos'] != null
        ? json['gallery_videos'].cast<String>()
        : [];
  }
  String? title;
  String? description;
  String? date;
  String? posterImg;
  List<String>? galleryImgs;
  List<String>? galleryVideos;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['title'] = title;
    map['description'] = description;
    map['date'] = date;
    map['poster_img'] = posterImg;
    map['gallery_imgs'] = galleryImgs;
    map['gallery_videos'] = galleryVideos;
    return map;
  }
}

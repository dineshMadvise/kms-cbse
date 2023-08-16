// ignore_for_file: prefer_final_fields, avoid_print

import 'package:get/get.dart';
import 'package:msp_educare_demo/model/apiModel/requestModel/add_announcement_req_model.dart';
import 'package:msp_educare_demo/model/apis/api_response.dart';
import 'package:msp_educare_demo/model/repo/add_announcement_repo.dart';
import 'package:msp_educare_demo/model/repo/get_announce_count_repo.dart';
import 'package:msp_educare_demo/model/repo/get_announce_list_repo.dart';
import 'package:msp_educare_demo/model/repo/save_announcement_remark_repo.dart';

class AnnouncementViewModel extends GetxController {
  List<String> _selectedSectionList = [];
  List<String> _selectedClassList = [];
  List<String> _selectedClassStudList = [];

  List<String> get selectedClassStudList => _selectedClassStudList;

  List<String> get selectedSectionList => _selectedSectionList;

  List<String> get selectedClassList => _selectedClassList;

  void setClassList(String id) {
    if (_selectedClassList.contains(id)) {
      _selectedClassList.remove(id);
    } else {
      _selectedClassList.add(id);
    }
    update();
  }

  void setClassStudList(String id) {
    if (_selectedClassStudList.contains(id)) {
      _selectedClassStudList.remove(id);
    } else {
      _selectedClassStudList.add(id);
    }
    update();
  }

  void setSectionList(String id) {
    if (_selectedSectionList.contains(id)) {
      _selectedSectionList.remove(id);
    } else {
      _selectedSectionList.add(id);
    }
    update();
  }

  void clearClassList() {
    _selectedClassList.clear();
    // update();
  }

  void clearSelectedSectionList() {
    _selectedSectionList.clear();
    // update();
  }

  void clearClassStudList() {
    _selectedClassStudList.clear();
    // update();
  }

  String _selectedFile = '';

  String get selectedFile => _selectedFile;

  set selectedFile(String value) {
    _selectedFile = value;
    update();
  }

  void resetAddAnnouncement() {
    addAnnouncementListApiResponse = ApiResponse.initial('INITIAL');
  }

  ApiResponse getAnnouncementListApiResponse = ApiResponse.initial('INITIAL');
  ApiResponse addAnnouncementListApiResponse = ApiResponse.initial('INITIAL');
  ApiResponse saveAnnouncementRemarkApiResponse =
      ApiResponse.initial('INITIAL');
  ApiResponse getAnnouncementCountApiResponse = ApiResponse.initial('INITIAL');

  void clearAddAnnounce() {
    addAnnouncementListApiResponse = ApiResponse.initial('INITIAL');
    _selectedFile = '';
  }

  /// GET Announcement LIST
  Future<void> getAnnouncementList() async {
    getAnnouncementListApiResponse = ApiResponse.loading('LOADING');
    update();
    try {
      final response = await GetAnnounceListRepo().getAnnounceList();
      getAnnouncementListApiResponse = ApiResponse.complete(response);
    } catch (e) {
      print('getAnnouncementListApiResponse ERROR :=> $e');
      getAnnouncementListApiResponse = ApiResponse.error('ERROR');
    }
    update();
  }

  /// GET Announcement COUNT
  Future<void> getAnnouncementCount(String id) async {
    if(getAnnouncementCountApiResponse.status!=Status.COMPLETE){
      getAnnouncementCountApiResponse = ApiResponse.loading('LOADING');
      update();
    }


    try {
      final response = await GetAnnounceCountRepo().getAnnounceCount(id);
      getAnnouncementCountApiResponse = ApiResponse.complete(response);
      // getAnnouncementList();
    } catch (e) {
      print('getAnnouncementCountApiResponse ERROR :=> $e');
      getAnnouncementCountApiResponse = ApiResponse.error('ERROR');
    }
    update();
  }

  /// ADD Announcement LIST
  Future<void> addAnnouncementList(AddAnnouncementReqModel reqModel) async {
    addAnnouncementListApiResponse = ApiResponse.loading('LOADING');
    update();
    try {
      final response = await AddAnnouncementRepo().addAnnouncement(reqModel);
      addAnnouncementListApiResponse = ApiResponse.complete(response);
      getAnnouncementList();
    } catch (e) {
      print('addAnnouncementListApiResponse ERROR :=> $e');
      addAnnouncementListApiResponse = ApiResponse.error('ERROR');
    }
    update();
  }

  /// SAVE Announcement REMARK
  Future<void> saveAnnouncementRemark(
      {required String annId, required String remark}) async {
    saveAnnouncementRemarkApiResponse = ApiResponse.loading('LOADING');
    update();
    try {
      final response = await SaveAnnouncementRemarkRepo()
          .saveAnnouncementRemark(annId: annId, remark: remark);
      saveAnnouncementRemarkApiResponse = ApiResponse.complete(response);
    } catch (e) {
      print('saveAnnouncementRemarkApiResponse ERROR :=> $e');
      saveAnnouncementRemarkApiResponse = ApiResponse.error('ERROR');
    }
    update();
  }
}

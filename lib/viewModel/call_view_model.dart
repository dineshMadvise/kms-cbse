import 'package:get/get.dart';
import 'package:msp_educare_demo/model/apiModel/requestModel/add_voice_call_campagin_req_model.dart';
import 'package:msp_educare_demo/model/apis/api_response.dart';
import 'package:msp_educare_demo/model/repo/call_list_repo.dart';

class CallViewModel extends GetxController{


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
  void clearAddAnnounce() {
    getCallListApiResponse = ApiResponse.initial('INITIAL');
    _selectedFile = '';
  }
  ApiResponse getCallListApiResponse = ApiResponse.initial('INITIAL');
  ApiResponse addCallListApiResponse = ApiResponse.initial('INITIAL');
  ApiResponse addTempApiResposne = ApiResponse.initial('INITIAL');
  ApiResponse getVoiceTempInfoApiResposne = ApiResponse.initial('INITIAL');


  /// Get Call List

  Future<void>getCallList()async{
    getCallListApiResponse = ApiResponse.loading('Loading');
    update();
    try{
      final response  = await CallListRepo().getCallList();
      getCallListApiResponse = ApiResponse.complete(response);

    }catch(e){
      print('getCallListApiResponse ERROR  :=>$e');
      getCallListApiResponse = ApiResponse.error('ERROR');
    }
    update();

  }

  /// ADD CALL CAMPAGIN


  Future<void>addCallList(AddVoiceCallCampaginReqModel  reqModel)async{
    addCallListApiResponse = ApiResponse.loading('Loading');
    update();
    try{
      final response  = await CallListRepo().addCallList(reqModel);
      addCallListApiResponse = ApiResponse.complete(response);

    }catch(e){
      print('addCallListApiResponse ERROR  :=>$e');
      addCallListApiResponse = ApiResponse.error('ERROR');
    }
    update();

  }

/// VOICE TEMP INFO
  Future<void>voiceTempInfo(String voiceTempId)async{
    getVoiceTempInfoApiResposne= ApiResponse.loading('Loading');
    update();
    try{
      final response  = await CallListRepo().getVoiceTempInfo(voiceTempId);
      getVoiceTempInfoApiResposne = ApiResponse.complete(response);

    }catch(e){
      print('getVoiceTempInfoApiResposne ERROR  :=>$e');
      getVoiceTempInfoApiResposne = ApiResponse.error('ERROR');
    }
    update();

  }

}
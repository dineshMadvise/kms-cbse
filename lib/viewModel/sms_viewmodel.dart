
import 'package:get/get.dart';
import 'package:msp_educare_demo/model/apiModel/requestModel/add_new_sms_campaign_req_model.dart';
import 'package:msp_educare_demo/model/apis/api_response.dart';
import 'package:msp_educare_demo/model/repo/smsListRepo.dart';

class SmsViewModel extends GetxController {
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
    getSmsListApiResponse = ApiResponse.initial('INITIAL');
    _selectedFile = '';
  }


  ApiResponse getSmsListApiResponse = ApiResponse.initial('INITIAL');
  ApiResponse addSmsListApiResponse = ApiResponse.initial('INITIAL');
  ApiResponse tempIdApiResponse = ApiResponse.initial('INITIAL');

  /// GET SMS LIST

  Future<void> getSmsList() async {
    getSmsListApiResponse = ApiResponse.loading('Loading');
    update();
    try {
      final response = await SmsListRepo().getSmsList();
      getSmsListApiResponse = ApiResponse.complete(response);
    } catch (e) {
      print('GetSmsListRepo ERROR  :=>$e');
      getSmsListApiResponse = ApiResponse.error('ERROR');
    }
    update();
  }

  /// ADD LIST SMS CAMAPAIGN

  Future<void> addSmsList(AddNewSmsCampaignReqModel reqModel) async {
    addSmsListApiResponse = ApiResponse.loading('Loading');
    update();
    try {
      final response = await SmsListRepo().addSmsList(reqModel);
      addSmsListApiResponse = ApiResponse.complete(response);
    } catch (e) {
      print('addSmsListApiResponse ERROR  :=>$e');
      addSmsListApiResponse = ApiResponse.error('ERROR');
    }
    update();
  }

  /// TEMPINFO ID

  Future<void> tempInfoId(String tempId) async {
    tempIdApiResponse = ApiResponse.loading('Loading');
    update();
    try {
      final response = await SmsListRepo().tempInfo(tempId);
      tempIdApiResponse = ApiResponse.complete(response);
    } catch (e) {
      print('tempIdApiResponse ERROR  :=>$e');
      tempIdApiResponse = ApiResponse.error('ERROR');
    }
    update();
  }


}

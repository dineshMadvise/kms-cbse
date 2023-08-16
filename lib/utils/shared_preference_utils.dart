import 'package:get_storage/get_storage.dart';

class PreferenceManagerUtils {
  static GetStorage getStorage = GetStorage();
  static String baseUrl = 'BASE_URL';
  static String schoolCode = 'SCH_CODE';
  static String userData = 'USER_DATA';
  static String fcmToken = 'FCM_TOKEN';
  static String studId = 'STUD_ID';
  static String schLogo = 'SCHOOL_LOGO';
  static String locationList = 'LOCATION_LIST';
  // static String backServiceIsRunning = 'BACK_SERVICE_IS_RUNNING';

  static String privacyPolicy = 'PRIVACY_POLICY';

  /// BASE URL
  static Future setBaseUrl(String value) async {
    await getStorage.write(baseUrl, value);
  }

  static String getBaseUrl() {
    return getStorage.read(baseUrl) ?? '';
  }

  /// PRIVACY POLICY
  static Future setPrivacyPolicy() async {
    await getStorage.write(privacyPolicy, true);
  }

  static bool getPrivacyPolicy() {
    return getStorage.read(privacyPolicy) ?? false;
  }


  /// SCH LOGO
  static Future setSchLogo(String value) async {
    await getStorage.write(schLogo, value);
  }

  static String getSchLogo() {
    return getStorage.read(schLogo) ?? '';
  }

  /// SCHOOL CODE
  static Future setSchoolCode(String value) async {
    await getStorage.write(schoolCode, value);
  }

  static String getSchoolCode() {
    return getStorage.read(schoolCode) ?? '';
  }

  /// LOCATION LIST
  static Future setLocationList(List value) async {
    await getStorage.write(locationList, value);
  }

  static List getLocationList() {
    return getStorage.read(locationList) ?? [];
  }

  /// STUD ID
  static Future setStudData(String value) async {
    await getStorage.write(studId, value);
  }

  static String getStudData() {
    return getStorage.read(studId) ?? '';
  }

  ///LOGIN USER DATA
  static Future setUserData(String value) async {
    await getStorage.write(userData, value);
  }

  static String getUserData() {
    return getStorage.read(userData) ?? "";
  }

  /// FCM TOKEN
  static Future setFcmToken(String value) async {
    await getStorage.write(fcmToken, value);
  }

  static String getFcmToken() {
    return getStorage.read(fcmToken) ?? '';
  }

  /// BACK SERVICE IS RUNNING STATUS
  // static Future setBackServiceIsRunning(bool value) async {
  //   await getStorage.write(backServiceIsRunning, value);
  // }
  //
  // static bool getBackServiceIsRunning() {
  //   return getStorage.read(backServiceIsRunning) ?? false;
  // }


}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:msp_educare_demo/bindings/dashboard_binding.dart';
import 'package:msp_educare_demo/dialog/privacy_policy_dialog.dart';
import 'package:msp_educare_demo/services/app_notification.dart';
import 'package:msp_educare_demo/utils/const_utils.dart';
import 'package:msp_educare_demo/utils/route_utils.dart';
import 'package:msp_educare_demo/utils/shared_preference_utils.dart';

import 'bindings/login_binding.dart';
import 'utils/variable_utils.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  /// GET STORAGE INITIALIZATION
  await GetStorage.init();

  /// FIREBASE NOTIFICATION SETUP
  await AppNotificationHandler.firebaseNotificationSetup();

  /// GET PACKAGE INFO
  await ConstUtils.getAppVersion();

  await NotificationController.initializeLocalNotifications();

  /// INITIALIZE BACKGROUND SERVICE
  // await initializeService();

  /// CALL MAIN METHOD........
  return runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    // if (!PreferenceManagerUtils.getPrivacyPolicy()) {
    //   WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    //     showPrivacyPolicyDialog();
    //   });
    // }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: VariableUtils.appName,
        initialRoute: initialRoute(),
        getPages: RouteUtils.routePages,
        initialBinding: BindingsBuilder(() => AuthBinding()),
      ),
    );
  }

  String initialRoute() {
    if (PreferenceManagerUtils.getUserData() == "null" ||
        PreferenceManagerUtils.getUserData() == '') {
      return RouteUtils.loginHere;
    } else {
      return RouteUtils.dashboard;
    }
  }

  Bindings initBinding() {
    if (PreferenceManagerUtils.getUserData() == "null" ||
        PreferenceManagerUtils.getUserData() == '') {
      return BindingsBuilder(() => AuthBinding());
    } else {
      return BindingsBuilder(() => DashBoardBinding());
    }
  }
}

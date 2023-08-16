// ignore_for_file: avoid_print, unnecessary_null_comparison, unnecessary_new, unrelated_type_equality_checks, unused_local_variable

import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:msp_educare_demo/audio_play_service.dart';
import 'package:msp_educare_demo/utils/const_utils.dart';
import 'package:msp_educare_demo/utils/shared_preference_utils.dart';

class AppNotificationHandler {
  static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      new FlutterLocalNotificationsPlugin();

  /// FIREBASE NOTIFICATION SETUP
  static Future<void> firebaseNotificationSetup() async {
    ///firebase initiallize
    await Firebase.initializeApp();

    ///local notification...
    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    ///IOS Setup
    IOSInitializationSettings initializationSettings =
        const IOSInitializationSettings(
            requestAlertPermission: true,
            requestSoundPermission: true,
            requestBadgePermission: true);
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.initialize(initializationSettings);
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );

    /// Update the iOS foreground notification presentation options to allow
    /// heads up notifications.
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    ///Get FCM Token..
    await getFcmToken();
  }

  ///background notification handler..
  @pragma('vm:entry-point')
  static Future<void> firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    await Firebase.initializeApp();
    logs('MESSAGE DATA :=>${jsonEncode(message.data)}');

    if (message.data != null) {
      if (message.data['type'] == 'Alarm') {
        await flutterLocalNotificationsPlugin.cancelAll();
        AudioPlayService.init("assets/alarmSoundFile.mp3",
            alarmPlayTime: message.data.containsKey('alarmCount')
                ? int.parse(message.data['alarmCount'].toString())
                : 1);
        NotificationController.createNewNotification(
            title: message.notification?.title,
            body: message.notification?.body
        );
      }
    }

    print('Handling a background message ${message.messageId}');
  }

  static AndroidNotificationChannel channel = const AndroidNotificationChannel(
      'KMS', // id
      'High Importance Notifications', // title
      description: 'MSP Educare', // description
      importance: Importance.high,
      playSound: true,
      sound: RawResourceAndroidNotificationSound('notification_sound'));

  ///get fcm token
  static Future<void> getFcmToken() async {
    FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
    try {
      String? token = await firebaseMessaging.getToken();
      await PreferenceManagerUtils.setFcmToken(token!);
      print("=========fcm-token===$token");
    } catch (e) {
      log("=========fcm- Error :$e");
      return;
    }
  }

  ///call when app in fore ground
  static void showMsgHandler() {
    print('showMsgHandler...');
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      ConstUtils.isSecondTimeAlarmPlay = false;
      AudioPlayService.stop();
      RemoteNotification? notification = message.notification;

      AndroidNotification? android = message.notification?.android;
      print(
          'Notification Call :${notification?.apple}${notification!.body}${notification.title}');
      if (notification != null) {
        showMsg(notification, message.data);
      }
    }).onError((e) {
      print('Error Notification : ....$e');
    });
  }

  /// handle notification when app in fore ground..
  static void getInitialMsg() {
    FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage? message) {
      ConstUtils.isSecondTimeAlarmPlay = false;
      AudioPlayService.stop();
      // BottomBarViewModel bottomBarViewModel = Get.find();
      // if (message != null) {
      //   Get.offAll(BottomBar());
      // }
    });
  }

  ///show notification msg
  static void showMsg(
      RemoteNotification notification, Map<String, dynamic> data) {
    if (data['type'] == 'Alarm' && Platform.isAndroid) {
      AudioPlayService.init("assets/alarmSoundFile.mp3",
          alarmPlayTime: data.containsKey('alarmCount')
              ? int.parse(data['alarmCount'].toString())
              : 1);
      NotificationController.createNewNotification(
          title: notification.title, body: notification.body
      );
      return;
    }
    showNotification(notification);
  }

  static void showNotification(
    RemoteNotification notification,
  ) {
    flutterLocalNotificationsPlugin.show(
        notification.hashCode,
        notification.title,
        notification.body,
        const NotificationDetails(
          android: AndroidNotificationDetails(
            'KMS', // id
            'High Importance Notifications', // title
            channelDescription: 'MSP Educare',
            // description
            importance: Importance.high,
            icon: '@drawable/ic_launcher',
            playSound: true,
            //    sound: RawResourceAndroidNotificationSound('notification_sound')
          ),
        ));
  }

  ///call when click on notification
  static void onMsgOpen() {
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('A new onMessageOpenedApp event was published!');
      print('listen->${message.data}');
    });
  }


  ///SEND NOTIFICATION FROM ONE DEVICE TO ANOTHER DEVICE...
// static Future<bool> sendMessage(List<String> receiverFcmToken,
//     {String msg}) async {
//   var serverKey =
//       'AAAAEVELAbc:APA91bE2Oorxbli6zqtxx6iXORel0HzIj_nLIdVRYDuB43Wiz9LVQH7gWrQyO9Judzybz2hSU4SO5BZ2dn9q7zLRjMa8I2khxLahYHcpR_rz6C3xx6jYYYWSp_bMqddWqcR1tQAt0cWZ';
//   try {
//     for (String token in receiverFcmToken) {
//       log("RESPONSE TOKEN  ${token}");
//
//       http.Response response = await http.post(
//         Uri.parse('https://fcm.googleapis.com/fcm/send'),
//         headers: <String, String>{
//           'Content-Type': 'application/json',
//           'Authorization': 'key=$serverKey',
//         },
//         body: jsonEncode(
//           <String, dynamic>{
//             "notification": <String, dynamic>{
//               "body": "Body",
//               "title": 'Title'
//             },
//             "priority": "high",
//             "data": <String, dynamic>{
//               "click_action": "FLUTTER_NOTIFICATION_CLICK",
//               "id": "1",
//               "status": "done"
//             },
//             "to": token,
//
//             /// Single device send notification at the time
//             //"registration_ids": [token1,token2],    /// Multi device send notification at the time     ///use only one "registration_ids" or "to" field
//           },
//         ),
//       );
//       log("RESPONSE CODE ${response.statusCode}");
//
//       log("RESPONSE BODY ${response.body}");
//     }
//   } catch (e) {
//     print("error push notification");
//   }
// }
}

/// ========================= Awesome Notifications ========================= ///
class NotificationController {
  static ReceivedAction? initialAction;

  ///  *********************************************
  ///     INITIALIZATIONS
  ///  *********************************************
  ///
  static Future<void> initializeLocalNotifications() async {
    await AwesomeNotifications().initialize(
      // '@drawable/ic_launcher',
        null,
        [
          NotificationChannel(
            channelKey: 'alerts',
            channelName: 'study',
            channelDescription: 'Notification tests as alerts',
            playSound: false,
            onlyAlertOnce: true,
            locked: true,
            importance: NotificationImportance.High,
            defaultPrivacy: NotificationPrivacy.Private,
          )
        ],
        debug: true);

    // Get initial notification action is optional
    initialAction = await AwesomeNotifications()
        .getInitialNotificationAction(removeFromActionEvents: false);
  }

  ///  *********************************************
  ///     NOTIFICATION EVENTS LISTENER
  ///  *********************************************
  ///  Notifications events are only delivered after call this method
  // static Future<void> startListeningNotificationEvents() async {
  //   AwesomeNotifications().setListeners(
  //     onActionReceivedMethod: onActionReceivedMethod,
  //     /* onDismissActionReceivedMethod: (receivedAction) {
  //       print('ON DISS MISS-----');
  //       AudioPlayService.stop();
  //       return Future.value(true);
  //     },*/
  //   );
  // }
  static Future<void> startListeningNotificationEvents() async {
    AwesomeNotifications().setListeners(
      onActionReceivedMethod: onActionReceivedMethod,
      onDismissActionReceivedMethod: (receivedAction) async {
        if (receivedAction.actionType == 'STOP') {
          // Stop the notification here
          await AwesomeNotifications().cancel(receivedAction.id!);
        }
      },
    );
  }

  ///  *********************************************
  ///     NOTIFICATION EVENTS
  ///  *********************************************
  ///
  @pragma('vm:entry-point')
  static Future<void> onActionReceivedMethod(
      ReceivedAction receivedAction) async {
    print(
        'Message sent via notification input: "${receivedAction.actionType}"');
    ConstUtils.isSecondTimeAlarmPlay = false;
    if (receivedAction.actionType == ActionType.SilentAction ||
        receivedAction.actionType == ActionType.SilentBackgroundAction) {
      // For background actions, you must hold the execution until the end
      print(
          'Message sent via notification input: "${receivedAction.actionType}"');
      AudioPlayService.stop();
    } else {
      // For background actions, you must hold the execution until the end
      print(
          'ELSE Message sent via notification input: "${receivedAction.actionType}"');
      ConstUtils.isSecondTimeAlarmPlay = false;
      AudioPlayService.stop();
    }
  }

  static Future<void> createNewNotification(
      {bool isLocked = true, String? title, String? body}) async {
    ConstUtils.alarmNotificationTitle = title ?? 'Study Time ⏰.⏰.';
    ConstUtils.alarmNotificationBody = body ?? '';
    ConstUtils.isSecondTimeAlarmPlay = true;
    // await Future.delayed(Duration(seconds: 3));
    await AwesomeNotifications().createNotification(
        content: NotificationContent(
            id: 0,
            channelKey: 'alerts',
            title: title ?? 'Study Time ⏰.⏰.',
            body: body ?? "",
            locked: isLocked,
            notificationLayout: NotificationLayout.Inbox,
            payload: {'notificationId': '1234567890'}),
        actionButtons: [
          // NotificationActionButton(
          //   key: 'STOP',
          //   label: 'Stop',
          //   requireInputText: false,
          // ),
        ]);
  }
}

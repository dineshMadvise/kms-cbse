import 'dart:async';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:just_audio/just_audio.dart';
import 'services/app_notification.dart';
import 'utils/const_utils.dart';

class AudioPlayService {
  static final player = AudioPlayer();

  /// =============== INIT AUDIO PLAYER =============== ///
  static Future<void> init(String url, {int alarmPlayTime = 1}) async {
    await player.stop();
    await player.setAsset(url);
    // await play();
    await playTwice(alarmPlayTime);
  }

  /// =============== NETWORK INIT AUDIO PLAYER =============== ///
  static Future<void> initNetwork(String url) async {
    await player.stop();
    await player.setUrl(url);
  }

  /// =============== PLAY =============== ///
  static Future<void> play() async {
    await player.play();
  }

  /// =============== PLAY TWICE =============== ///
  static Future<void> playTwice(int alarmPlayTime) async {
    await player.play().then((value) async {
      print(
          'ConstUtils.isSecondTimeAlarmPlay=>${ConstUtils.isSecondTimeAlarmPlay}');
      for (int index = 1; index < alarmPlayTime; index++) {
        if (ConstUtils.isSecondTimeAlarmPlay) {
          await player.stop();
          await player.setAsset("assets/alarmSound.mp3");
          await player.play();
          print('INDEX ==>$index alarmPlayTime=>$alarmPlayTime');
          if (index == alarmPlayTime - 1) {
            AwesomeNotifications().cancel(0);
            NotificationController.createNewNotification(
                isLocked: false,
                title: ConstUtils.alarmNotificationTitle,
                body: ConstUtils.alarmNotificationBody);
          }
        }
      }
      if (alarmPlayTime == 1) {
        AwesomeNotifications().cancel(0);
        NotificationController.createNewNotification(
            isLocked: false,
            title: ConstUtils.alarmNotificationTitle,
            body: ConstUtils.alarmNotificationBody);
      }
    });
  }

  /// =============== PAUSE =============== ///
  static Future<void> pause() async {
    await player.pause();
  }

  /// =============== STOP =============== ///
  static Future<void> stop() async {
    await player.stop();
  }
}

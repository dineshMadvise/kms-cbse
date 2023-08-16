import 'package:flutter/material.dart';

String basePath = 'assets/icons/';

class IconsWidgets {
  static String home = "${basePath}home.png";

  static String notification = "${basePath}notification.png";

  static Image successPayment = Image.asset(
    "${basePath}successPayment.png",
    scale: 5,
  );

  static Image cancelPayment = Image.asset(
    "${basePath}cancelPayment.png",
    scale: 5,
  );

  static Image routeCircle = Image.asset(
    "${basePath}routeCircle.png",
    scale: 5,
  );

  static Image calendar = Image.asset(
    "${basePath}calendar.png",
    scale: 4,
  );
  static Image clock = Image.asset(
    "${basePath}clock.png",
    scale: 4,
  );
  static Image locationPin = Image.asset(
    "${basePath}locationPin.png",
    scale: 4,
  );

  static String chat = "${basePath}chat.png";

  static String logout = "${basePath}logout.png";
}

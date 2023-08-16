import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:msp_educare_demo/utils/color_utils.dart';

class DecorationUtils {
  /// CONTAINER DECORATION

  // /// BOTTOM (VERTICAL) RADIUS DECORATION
  // static BoxDecoration bottomRadiusDecoration() {
  //   return BoxDecoration(
  //       color: ColorUtils.red,
  //       borderRadius: BorderRadius.vertical(bottom: Radius.circular(40)));
  // }
  //
  // /// TOP (VERTICAL) RADIUS DECORATION
  // static BoxDecoration topRadiusDecoration() {
  //   return BoxDecoration(
  //       color: ColorUtils.red,
  //       borderRadius: BorderRadius.vertical(top: Radius.circular(40)));
  // }
  //
  // /// GRADIENT DECORATION
  // static BoxDecoration gradientDecoration({double? radius}) {
  //   return BoxDecoration(
  //       color: ColorUtils.red,
  //       borderRadius: BorderRadius.circular(radius ?? 35),
  //       gradient: LinearGradient(colors: [
  //         ColorUtils.red,
  //         ColorUtils.red,
  //       ]));
  // }
  //
  // /// SIMPLE DECORATION
  // static BoxDecoration decorationBox({double? radius}) {
  //   return BoxDecoration(
  //     color: ColorUtils.red,
  //     borderRadius: BorderRadius.circular(radius ?? 35),
  //   );
  // }

  /// DROPDOWN INPUT DECORATION
 static InputDecoration inputDecoration() {
    return InputDecoration(
      contentPadding: EdgeInsets.only(
          top: Get.height * 0.018,
          bottom: Get.height * 0.018,
          left: 15,
          right: 5),
      focusedBorder: DecorationUtils.outLinePurpleR8,
      enabledBorder: DecorationUtils.outLineGeryR8,
      disabledBorder: DecorationUtils.outLineGeryR8,
      errorBorder: DecorationUtils.outLineRedR8,
      focusedErrorBorder: DecorationUtils.outLineRedR8,
      fillColor: ColorUtils.white,
      filled: true,
    );
  }

  /// DECORATION WITH BORDER
  static BoxDecoration borderDecorationBox({double? radius, Color? color}) {
    return BoxDecoration(
      border: Border.all(color: color ?? ColorUtils.blue, width: 1),
      borderRadius: BorderRadius.circular(radius ?? 5),
    );
  }

  /// DECORATION
  static BoxDecoration commonDecorationBox({double? radius, Color? color}) {
    return BoxDecoration(
        color: color ?? ColorUtils.white,
        boxShadow: [BoxShadow(color: ColorUtils.shadowGrey, blurRadius: 3)],
        borderRadius: BorderRadius.circular(radius ?? 10));
  }

  ///DIALOG  DECORATION
  static BoxDecoration dialogDecorationBox({double? radius, Color? color}) {
    return BoxDecoration(
        borderRadius: BorderRadius.circular(radius ?? 10),
        color: color ?? ColorUtils.white);
  }

  /// ------------------------------------------------------------------- ///
  /// TEXT FIELD OUTLINE DECORATION
  static InputBorder outLinePurpleR8 = const OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(8.0)),
    borderSide: BorderSide(color: ColorUtils.blue, width: 1.0),
  );
  static InputBorder outLineGeryR8 = OutlineInputBorder(
    borderRadius: const BorderRadius.all(Radius.circular(8.0)),
    borderSide: BorderSide(color: ColorUtils.grey.withOpacity(0.2), width: 1.0),
  );
  static InputBorder outLineRedR8 = const OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(8.0)),
    borderSide: BorderSide(color: Colors.red, width: 1.0),
  );
}

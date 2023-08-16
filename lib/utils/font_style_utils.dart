import 'package:flutter/material.dart';

import 'color_utils.dart';

/// FONT FAMILY
const String poppinsFamily = "Poppins";

/// ------------------------------------------------------------------- ///

/// FONT WEIGHT
class FontWeightClass {
  static const regular = FontWeight.w400;
  static const medium = FontWeight.w500;
  static const semiB = FontWeight.w600;
  static const bold = FontWeight.w700;
  static const extraB = FontWeight.w800;
  static const black = FontWeight.w900;
}

/// ------------------------------------------------------------------- ///
/// FONT TEXT STYLE

class FontTextStyle {
  /// 10
  // ignore: prefer_const_constructors
  static TextStyle poppinsW5S10Grey = poppinsW5S12Grey.copyWith(
    fontSize: 10,
  );
  static TextStyle poppinsW5S10White =
      poppinsW5S12Grey.copyWith(color: ColorUtils.white);
  static TextStyle poppinsW5S10Blue =
      poppinsW5S12Grey.copyWith(color: ColorUtils.blue);
  static TextStyle poppinsW5S10Black =
      poppinsW5S10Blue.copyWith(color: ColorUtils.black);
  static TextStyle poppinsW6S10Purple = poppinsW5S12Grey.copyWith(
      color: ColorUtils.blue, fontWeight: FontWeightClass.semiB);

  /// 12
  // ignore: prefer_const_constructors
  static TextStyle poppinsW5S12Grey = poppinsW5S14Grey.copyWith(
      fontSize: 12,
      fontFamily: poppinsFamily,
      fontWeight: FontWeightClass.regular,
      color: ColorUtils.grey);

  static TextStyle poppinsW6S12Grey = poppinsW5S12Grey.copyWith(
    fontWeight: FontWeightClass.semiB,
  );
  static TextStyle poppinsW5S12DarkGrey =
      poppinsW5S12Grey.copyWith(color: ColorUtils.darkGrey);
  static TextStyle poppinsW5S12Black =
      poppinsW6S12Grey.copyWith(color: ColorUtils.black);
  static TextStyle poppinsW5S12DarkGreen =
      poppinsW6S12Grey.copyWith(color: ColorUtils.darkGreen);
  static TextStyle poppinsW7S12DarkGrey =
      poppinsW5S12DarkGrey.copyWith(fontWeight: FontWeightClass.bold);
  static TextStyle poppinsW6S12White = poppinsW6S18white.copyWith(fontSize: 12);
  static TextStyle poppinsW6S12Black =
      poppinsW6S12White.copyWith(color: ColorUtils.black);
  static TextStyle poppinsW5S12White =
      poppinsW6S12White.copyWith(fontWeight: FontWeightClass.medium);
  static TextStyle poppinsW7S12Purple =
      poppinsW7S12DarkGrey.copyWith(color: ColorUtils.blue);
  static TextStyle poppinsW512Purple =
      poppinsW5S14Purple.copyWith(fontSize: 12);

  /// 13
  // ignore: prefer_const_constructors
  static TextStyle poppinsW6S13LightOrange = poppinsW5S16Grey.copyWith(
      fontSize: 13,
      fontFamily: poppinsFamily,
      fontWeight: FontWeightClass.semiB,
      color: ColorUtils.lightOrange);
  static TextStyle poppinsW6S13Purple =
      poppinsW6S13LightOrange.copyWith(color: ColorUtils.blue);
  static TextStyle poppinsW9S13Purple = poppinsW6S13LightOrange.copyWith(
      color: ColorUtils.blue, fontWeight: FontWeightClass.black);
  static TextStyle poppinsW6S13Grey =
      poppinsW6S13LightOrange.copyWith(color: ColorUtils.grey);
  static TextStyle poppinsW5S13Grey =
      poppinsW6S13Grey.copyWith(fontWeight: FontWeightClass.medium);
  static TextStyle poppinsW7S13DarkGrey = poppinsW6S13Grey.copyWith(
      fontWeight: FontWeightClass.bold, color: ColorUtils.darkGrey);

  /// 14
  // ignore: prefer_const_constructors
  static TextStyle poppinsW5S14Grey = poppinsW5S16Grey.copyWith(fontSize: 14);
  static TextStyle poppinsW5S14DarkGrey =
      poppinsW5S14Grey.copyWith(color: ColorUtils.darkGrey);
  static TextStyle poppinsW7S14Red = poppinsW5S14Grey.copyWith(
      fontWeight: FontWeightClass.bold, color: ColorUtils.red);
  static TextStyle poppinsW7S14DarkGrey =
      poppinsW7S14Red.copyWith(color: ColorUtils.darkGrey);
  static TextStyle poppinsW5S14Purple =
      poppinsW5S14Grey.copyWith(color: ColorUtils.blue);
  static TextStyle poppinsW6S14White =
      poppinsW6S12White.copyWith(color: ColorUtils.white);
  static TextStyle poppinsW6S14Grey =
      poppinsW6S12White.copyWith(color: ColorUtils.grey);
  static TextStyle poppinsW6S14Black =
      poppinsW6S12White.copyWith(color: ColorUtils.black, fontSize: 14);
  static TextStyle poppinsW6S14DarkGreen = poppinsW6S14Black.copyWith(
    color: ColorUtils.darkGreen,
  );
  static TextStyle poppinsW6S14DarkRed = poppinsW6S14Black.copyWith(
    color: ColorUtils.darkRed,
  );
  static TextStyle poppinsW5S14Black = poppinsW6S14Black.copyWith(
      fontWeight: FontWeightClass.medium, fontSize: 14);
  static TextStyle poppinsW5S14White =
      poppinsW5S14Grey.copyWith(color: ColorUtils.white);
  static TextStyle poppinsW7S14Blue =
      poppinsW7S14Red.copyWith(color: ColorUtils.blue);

  /// 16
  // ignore: prefer_const_constructors
  static TextStyle poppinsW5S16Grey = TextStyle(
    fontFamily: poppinsFamily,
    fontSize: 16,
    fontWeight: FontWeightClass.regular,
    color: ColorUtils.grey,
  );
  static TextStyle poppinsW5S16Black =
      poppinsW5S16Grey.copyWith(color: ColorUtils.black);
  static TextStyle poppinsW5S16White =
      poppinsW5S16Grey.copyWith(color: ColorUtils.white);
  static TextStyle poppinsW6S16White =
      poppinsW5S16White.copyWith(fontWeight: FontWeightClass.semiB);
  static TextStyle poppinsW4S16Black =
      poppinsW5S16Black.copyWith(fontWeight: FontWeight.w400);
  static TextStyle poppinsW6S16DarkGrey =
      poppinsW5S16Grey.copyWith(fontWeight: FontWeightClass.bold);
  static TextStyle poppinsW7S16Purple = poppinsW5S16Grey.copyWith(
      fontWeight: FontWeightClass.bold, color: ColorUtils.blue);
  static TextStyle poppinsW7S16Black = poppinsW5S16Black.copyWith(
    fontWeight: FontWeightClass.bold,
  );
  static TextStyle poppinsW6S16Black = poppinsW5S16Black.copyWith(
    fontWeight: FontWeightClass.semiB,
  );

  static TextStyle poppinsW7S16Red = poppinsW7S14Red.copyWith(fontSize: 16);

  /// 18
  // ignore: prefer_const_constructors
  static TextStyle poppinsW5S18Grey = poppinsW5S16Grey.copyWith(fontSize: 18);
  static TextStyle poppinsW5S18Black =
      poppinsW5S18Grey.copyWith(color: ColorUtils.black);
  static TextStyle poppinsW7S18Black =
      poppinsW5S18Black.copyWith(fontWeight: FontWeightClass.bold);
  static TextStyle poppinsW5S18Blue =
      poppinsW5S18Grey.copyWith(color: ColorUtils.blue);
  static TextStyle poppinsW5S14Blue = poppinsW5S18Blue.copyWith(fontSize: 14);
  static TextStyle poppinsW6S18Purple = poppinsW5S18Grey.copyWith(
      fontWeight: FontWeightClass.semiB, color: ColorUtils.blue);
  static TextStyle poppinsW6S14Purple = poppinsW6S18Purple.copyWith(
    fontSize: 14,
  );
  static TextStyle poppinsW5S18Purple =
      poppinsW5S18Grey.copyWith(color: ColorUtils.blue);
  static TextStyle poppinsW5S12sky =
      poppinsW5S18Purple.copyWith(color: ColorUtils.blueSky, fontSize: 12);
  static TextStyle poppinsW6S18white =
      poppinsW6S18Purple.copyWith(color: ColorUtils.white);
  static TextStyle poppinsW6S14white = poppinsW6S18white.copyWith(fontSize: 14);
  static TextStyle poppinsW6S18Black =
      poppinsW6S18Purple.copyWith(color: ColorUtils.black);

  ///19
  // ignore: prefer_const_constructors
  static TextStyle poppinsW5S19DarkGrey =
      poppinsW5S16Grey.copyWith(fontSize: 19, color: ColorUtils.darkGrey);

  ///20
  // ignore: prefer_const_constructors
  static TextStyle poppinsW5S20White =
      poppinsW5S16Grey.copyWith(fontSize: 20, color: ColorUtils.white);

  ///22
  static TextStyle poppinsW7S22Black = poppinsW5S18Black.copyWith(
    fontSize: 22,
    fontWeight: FontWeightClass.bold,
  );

  ///25
  static TextStyle poppinsW9S25Black = poppinsW7S22Black.copyWith(
      fontSize: 25, fontWeight: FontWeightClass.black);

  ///30
  static TextStyle poppinsW7S30Black = poppinsW5S18Black.copyWith(
      fontSize: 30, fontWeight: FontWeightClass.bold);
}

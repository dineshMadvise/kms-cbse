import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:msp_educare_demo/common/commonWidgets/add_or_forword_circle_box.dart';
import 'package:msp_educare_demo/utils/color_utils.dart';
import 'package:msp_educare_demo/utils/const_utils.dart';
import 'package:msp_educare_demo/utils/font_style_utils.dart';
import 'package:msp_educare_demo/utils/typedef_utils.dart' as typeDef;

AppBar customAppbar({
  required String title,
  bool actionVisible = false,
  bool leadingVisible = true,
  bool centerTitle = false,
  typeDef.OnTap? onActionTap,
  typeDef.OnTap? leadingTap,
  Widget? action,
}) {
  return AppBar(
    backgroundColor: ColorUtils.transparent,
    elevation: 0,
    // centerTitle: centerTitle,
    centerTitle: true,
    leading: !leadingVisible
        ? const SizedBox()
        : InkResponse(
      onTap: leadingTap ??
              () {
            Get.back();
          },
      child: const Icon(
        ConstUtils.kBackArrowIcon,
        color: ColorUtils.blue,
      ),
    ),
    title: Text(
      title.toUpperCase(),
      style: FontTextStyle.poppinsW5S16Black,
    ),
    actions: !actionVisible
        ? []
        : [
      Padding(
        padding: const EdgeInsets.only(right: 10),
        child: action ??
            GestureDetector(
                onTap: onActionTap,
                child: const AddOrForwordCircleBox(
                    icon: ConstUtils.kAddIcon)),
      )
    ],
  );
}



// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:msp_educare_demo/common/commonWidgets/add_or_forword_circle_box.dart';
// import 'package:msp_educare_demo/utils/color_utils.dart';
// import 'package:msp_educare_demo/utils/const_utils.dart';
// import 'package:msp_educare_demo/utils/font_style_utils.dart';
// import 'package:msp_educare_demo/utils/typedef_utils.dart' as typeDef;
//
// AppBar customAppbar({
//   required String title,
//   bool actionVisible = false,
//   bool leadingVisible = true,
//   bool centerTitle = false,
//   typeDef.OnTap? onActionTap,
//   typeDef.OnTap? leadingTap,
// }) {
//   return AppBar(
//     backgroundColor: ColorUtils.transparent,
//     elevation: 0,
//     // centerTitle: centerTitle,
//     centerTitle: true,
//     leading: !leadingVisible
//         ? SizedBox()
//         : InkResponse(
//             onTap: leadingTap ??
//                 () {
//                   Get.back();
//                 },
//             child: const Icon(
//               ConstUtils.kBackArrowIcon,
//               color: ColorUtils.blue,
//             ),
//           ),
//     title: Text(
//       title.toUpperCase(),
//       style: FontTextStyle.poppinsW5S16Black,
//     ),
//     actions: !actionVisible
//         ? []
//         : [
//             Padding(
//               padding: const EdgeInsets.only(right: 10),
//               child: GestureDetector(
//                   onTap: onActionTap,
//                   child: AddOrForwordCircleBox(icon: ConstUtils.kAddIcon)),
//             )
//           ],
//   );
// }

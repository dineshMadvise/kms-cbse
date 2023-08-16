// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:msp_educare_demo/common/commonWidgets/dialog_close_btn.dart';
// import 'package:msp_educare_demo/model/apiModel/responseModel/get_attendance_res_model.dart';
// import 'package:msp_educare_demo/utils/color_utils.dart';
// import 'package:msp_educare_demo/utils/const_utils.dart';
// import 'package:msp_educare_demo/utils/decoration_utils.dart';
// import 'package:msp_educare_demo/utils/font_style_utils.dart';
// import 'package:msp_educare_demo/utils/size_config_utils.dart';
// import 'package:msp_educare_demo/utils/variable_utils.dart';
//
// void showAttendanceDialog(Data data) {
//   Get.dialog(Dialog(
//     insetPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
//     child: Container(
//       decoration: DecorationUtils.dialogDecorationBox(),
//       padding: EdgeInsets.symmetric(vertical: 20),
//       child: SingleChildScrollView(
//         physics: BouncingScrollPhysics(),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 20),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(
//                     VariableUtils.attendance.toUpperCase(),
//                     style: FontTextStyle.poppinsW6S13Grey,
//                   ),
//                   DialogCloseBtn()
//                 ],
//               ),
//             ),
//             Divider(),
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 20),
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   SizeConfig.sH5,
//                   Row(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       const CircleAvatar(
//                         radius: 5,
//                         backgroundColor: ColorUtils.lightRed,
//                       ),
//                       SizeConfig.sW10,
//                       Expanded(
//                         child: Text(
//                           data.monthName ?? 'N/A',
//                           style: FontTextStyle.poppinsW7S13DarkGrey,
//                         ),
//                       )
//                     ],
//                   ),
//                   SizeConfig.sH10,
//                   Text(
//                     VariableUtils.totalNoOfWorkingDays,
//                     style: FontTextStyle.poppinsW5S12Grey,
//                   ),
//                   SizeConfig.sH5,
//                   Row(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       Icon(ConstUtils.kWatchIcon),
//                       SizeConfig.sW10,
//                       Text(
//                         "${data.attendanceInfo!.length} " + VariableUtils.days,
//                         style: FontTextStyle.poppinsW7S14DarkGrey,
//                       )
//                     ],
//                   ),
//                   SizeConfig.sH20,
//                   Wrap(
//                     spacing: 25,
//                     runSpacing: 20,
//                     children: [
//                       statusRow(
//                           color: ColorUtils.darkGreen,
//                           title: VariableUtils.present),
//                       statusRow(
//                           color: ColorUtils.darkRed,
//                           title: VariableUtils.absent),
//                       statusRow(
//                           color: ColorUtils.orange,
//                           title: VariableUtils.notMarked),
//                       statusRow(
//                           color: ColorUtils.blueSky,
//                           title: VariableUtils.holiday),
//                     ],
//                   ),
//                   SizeConfig.sH20,
//                   Row(
//                     children: List.generate(
//                         3,
//                         (index) => Expanded(
//                               child: Container(
//                                 height: 35,
//                                 margin: EdgeInsets.symmetric(
//                                     horizontal: index == 1 ? 5 : 0),
//                                 child: Row(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceAround,
//                                   children: [
//                                     Text(
//                                       VariableUtils.date,
//                                       style: FontTextStyle.poppinsW6S14White,
//                                     ),
//                                     Text(
//                                       '#',
//                                       style: FontTextStyle.poppinsW6S14White,
//                                     ),
//                                   ],
//                                 ),
//                                 decoration: BoxDecoration(
//                                     color: ColorUtils.black,
//                                     borderRadius: BorderRadius.vertical(
//                                         top: Radius.circular(5))),
//                               ),
//                             )),
//                   ),
//                   SizeConfig.sH10,
//                   Column(
//                     children: List.generate(
//                         (data.attendanceInfo!.length / 3).ceil(),
//                         (index) => Column(
//                               children: [
//                                 Row(
//                                   children: [
//                                     Expanded(
//                                       child: index == 10
//                                           ? SizedBox()
//                                           : dateStatusRow(
//                                               status: data
//                                                   .attendanceInfo![index]
//                                                   .status!,
//                                               title: data.attendanceInfo![index]
//                                                   .runningDate!),
//                                     ),
//                                     Expanded(
//                                       child: (index + 11) == 21
//                                           ? SizedBox()
//                                           : dateStatusRow(
//                                               status: data
//                                                   .attendanceInfo![index + 10]
//                                                   .status!,
//                                               title: data
//                                                   .attendanceInfo![index + 10]
//                                                   .runningDate!),
//                                     ),
//                                     Expanded(
//                                       child: (index + 21) <=
//                                               data.attendanceInfo!.length
//                                           ? dateStatusRow(
//                                               status: data
//                                                   .attendanceInfo![index + 20]
//                                                   .status!,
//                                               title: data
//                                                   .attendanceInfo![index + 20]
//                                                   .runningDate!)
//                                           : SizedBox(),
//                                     ),
//                                   ],
//                                 ),
//                                 Divider()
//                               ],
//                             )),
//                   )
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     ),
//     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//   ));
// }
//
// Row statusRow({required Color color, required String title}) {
//   return Row(
//     mainAxisSize: MainAxisSize.min,
//     children: [
//       Container(
//         color: color,
//         height: 20,
//         width: 20,
//       ),
//       SizeConfig.sW10,
//       Text(
//         title,
//         style: FontTextStyle.poppinsW5S14DarkGrey,
//       )
//     ],
//   );
// }
//
// Row dateStatusRow({required String title, required String status}) {
//   return Row(
//     mainAxisSize: MainAxisSize.min,
//     mainAxisAlignment: MainAxisAlignment.spaceAround,
//     children: [
//       Text(
//         title,
//         style: FontTextStyle.poppinsW5S14DarkGrey,
//       ),
//       Container(
//         color: statusColor(status),
//         height: 20,
//         width: 20,
//       ),
//     ],
//   );
// }
//
// Color statusColor(String status) {
//   switch (status.capitalize) {
//     case VariableUtils.present:
//       return ColorUtils.green;
//     case VariableUtils.absent:
//       return ColorUtils.darkRed;
//     case VariableUtils.notMarked:
//       return ColorUtils.orange;
//     default:
//       return ColorUtils.blueSky;
//   }
// }

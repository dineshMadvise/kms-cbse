import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:msp_educare_demo/common/commonMethods/get_file_picker.dart';
import 'package:msp_educare_demo/common/commonMethods/loading_indicator.dart';
import 'package:msp_educare_demo/model/repo/update_profile_pic_repo.dart';
import 'package:msp_educare_demo/utils/color_utils.dart';
import 'package:msp_educare_demo/utils/const_utils.dart';
import 'package:msp_educare_demo/utils/extension_utils.dart';
import 'package:msp_educare_demo/viewModel/auth_viewmodel.dart';

class ProfileImageCircle extends StatelessWidget {
  ProfileImageCircle({
    Key? key,
    this.profilePic,
    this.isStudent = false,
  }) : super(key: key);
  final String? profilePic;
  final bool isStudent;
  RxString localProfilePic = "".obs;
  RxBool isLoading = false.obs;

  @override
  Widget build(BuildContext context) {
    return Obx(() => Stack(
      alignment: Alignment.center,
          children: [
            Container(
              width: 35.w,
              height: 35.w,
              decoration: localProfilePic.value.isNotEmpty
                  ? BoxDecoration(
                      shape: BoxShape.circle,
                      color: ColorUtils.blue,
                      image: DecorationImage(
                          image: FileImage(File(localProfilePic.value))))
                  : profilePic != null && profilePic != ""
                      ? BoxDecoration(
                          shape: BoxShape.circle,
                          color: ColorUtils.blue,
                          image: DecorationImage(
                              image: NetworkImage(profilePic!),
                              fit: BoxFit.cover))
                      : BoxDecoration(
                          shape: BoxShape.circle,
                          color: ColorUtils.blue,
                          border: Border.all(color: ColorUtils.blue)),
              alignment: Alignment.bottomRight,
              child: InkWell(
                onTap: onTap,
                child: const CircleAvatar(
                  backgroundColor: ColorUtils.black26,
                  child: Icon(
                    Icons.camera_alt_rounded,
                    color: ColorUtils.white,
                  ),
                ),
              ),
            ),
            if (isLoading.value) getDataLoadingIndicator()
          ],
        ));
  }

  Future<void> onTap() async {
    File imgFile = await getFile(fileType: FileType.image);
    if (imgFile.path != '') {
      final AuthViewModel authViewModel =
          Get.find(tag: AuthViewModel().toString());
      print('imgFile:=>${imgFile.path}');
      localProfilePic.value = imgFile.path;
      isLoading.value = true;
      if (isStudent) {
        final status = await UpdateStudentProfilePicRepo()
            .updateStudentProfilePicRepo(convertFileToBase64(imgFile.path));
        if (status == true) {
          authViewModel.studentDetail(ConstUtils.getStudentData().id!,isRefresh: true);
        }
      } else {
        final status = await UpdateStaffProfilePicRepo()
            .updateStaffProfilePicRepo(convertFileToBase64(imgFile.path));
        if (status == true) {
          authViewModel.teacherDetail(ConstUtils.getUserData().userid!);
        }
      }
      isLoading.value = false;
    }
  }
}

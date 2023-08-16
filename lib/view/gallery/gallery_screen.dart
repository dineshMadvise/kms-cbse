// ignore_for_file: use_key_in_widget_constructors, avoid_print

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:msp_educare_demo/common/commonMethods/custom_appbar.dart';
import 'package:msp_educare_demo/common/commonMethods/loading_indicator.dart';
import 'package:msp_educare_demo/common/commonWidgets/custom_video_player.dart';
import 'package:msp_educare_demo/common/commonWidgets/octo_image_network.dart';
import 'package:msp_educare_demo/dialog/gallery_dialog.dart';
import 'package:msp_educare_demo/model/apiModel/responseModel/get_gallery_res_model.dart';
import 'package:msp_educare_demo/model/apis/api_response.dart';
import 'package:msp_educare_demo/utils/assets/icons_utils.dart';
import 'package:msp_educare_demo/utils/decoration_utils.dart';
import 'package:msp_educare_demo/utils/font_style_utils.dart';
import 'package:msp_educare_demo/utils/size_config_utils.dart';
import 'package:msp_educare_demo/utils/variable_utils.dart';
import 'package:msp_educare_demo/viewModel/gallery_viewmodel.dart';

class GalleryScreen extends StatefulWidget {
  @override
  _GalleryScreenState createState() => _GalleryScreenState();
}

class _GalleryScreenState extends State<GalleryScreen> {
  GalleryViewModel viewModel = Get.find(tag: GalleryViewModel().toString());

  @override
  void initState() {
    init();
    super.initState();
  }

  void init() {
    viewModel.getGallery();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar(
        title: VariableUtils.gallery,
        centerTitle: true,
        // actionVisible: true,
        // onActionTap: () {
        //   RouteUtils.navigateRoute(RouteUtils.addEnquiryScreen);
        // }
      ),
      body: buildBody(),
    );
  }

  Widget buildBody() {
    return SizedBox(
        width: Get.width,
        height: Get.height,
        child: GetBuilder<GalleryViewModel>(
          tag: GalleryViewModel().toString(),
          builder: (controller) {
            if (controller.getGalleryApiResponse.status == Status.LOADING ||
                controller.getGalleryApiResponse.status == Status.INITIAL) {
              return getDataLoadingIndicator();
            }
            if (controller.getGalleryApiResponse.status == Status.ERROR) {
              return getDataErrorMsg();
            }
            GetGalleryResModel model = controller.getGalleryApiResponse.data;
            if (model.status != VariableUtils.ok) {
              return getFieldIsEmptyMsg();
            }
            print('LENGTH:${model.data!.length}');
            return model.data!.isEmpty
                ? getNotApplicableMsg(msg: model.msg)
                : Stack(
                    children: [
                      ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        itemCount: model.data!.length,
                        itemBuilder: (context, index) {
                          final data = model.data![index];
                          return InkWell(
                            onTap: () {
                              showGalleryDialog(data);
                            },
                            child: Container(
                              margin: const EdgeInsets.fromLTRB(20, 10, 20, 20),
                              decoration: DecorationUtils.commonDecorationBox(),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 20),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 10),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(5),
                                      child: OctoImageNetwork(
                                        url: data.posterImg,
                                        height: Get.width * 0.45,
                                        width: Get.width,
                                        circleShape: false,
                                        fit: false,
                                        boxFit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    data.title ?? VariableUtils.none,
                                    style: FontTextStyle.poppinsW6S16DarkGrey,
                                  ),
                                  SizeConfig.sH10,
                                  Text(
                                    data.description ?? VariableUtils.none,
                                    style: FontTextStyle.poppinsW5S16Grey,
                                  ),
                                  SizeConfig.sH10,
                                  buildRow(
                                      icon: IconsWidgets.calendar,
                                      title: data.date ?? VariableUtils.none),
                                  SizeConfig.sH10,
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                      if (controller.getGalleryApiResponse.status ==
                          Status.LOADING)
                        postDataLoadingIndicator()
                    ],
                  );
          },
        ));
  }

  Text richText({required String key, required String value}) {
    return Text.rich(TextSpan(children: [
      TextSpan(text: key, style: FontTextStyle.poppinsW7S12DarkGrey),
      TextSpan(
        text: value,
        style: FontTextStyle.poppinsW5S12Grey,
      )
    ]));
  }

  Widget buildRow({required Widget icon, required String title}) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      // crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        icon,
        SizeConfig.sW5,
        Expanded(
          child: Text(
            title,
            style: FontTextStyle.poppinsW5S14Grey,
          ),
        )
      ],
    );
  }
}

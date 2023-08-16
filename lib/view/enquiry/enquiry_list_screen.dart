// ignore_for_file: use_key_in_widget_constructors, avoid_print

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:msp_educare_demo/common/commonMethods/custom_appbar.dart';
import 'package:msp_educare_demo/common/commonMethods/loading_indicator.dart';
import 'package:msp_educare_demo/common/commonMethods/toast_msg.dart';
import 'package:msp_educare_demo/model/apiModel/responseModel/get_enquiry_info_res_modeldart.dart';
import 'package:msp_educare_demo/model/apiModel/responseModel/get_enquiry_list_res_model.dart';
import 'package:msp_educare_demo/model/apis/api_response.dart';
import 'package:msp_educare_demo/utils/const_utils.dart';
import 'package:msp_educare_demo/utils/decoration_utils.dart';
import 'package:msp_educare_demo/utils/font_style_utils.dart';
import 'package:msp_educare_demo/utils/route_utils.dart';
import 'package:msp_educare_demo/utils/size_config_utils.dart';
import 'package:msp_educare_demo/utils/variable_utils.dart';
import 'package:msp_educare_demo/viewModel/enquiry_viewmodel.dart';

class EnquiryListScreen extends StatefulWidget {
  @override
  _EnquiryListScreenState createState() => _EnquiryListScreenState();
}

class _EnquiryListScreenState extends State<EnquiryListScreen> {
  EnquiryViewModel viewModel = Get.find(tag: EnquiryViewModel().toString());

  @override
  void initState() {
    init();
    super.initState();
  }

  void init() {
    viewModel.getEnquiryList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar(
          title: VariableUtils.enquiry,
          centerTitle: true,
          actionVisible: true,
          onActionTap: () {
            RouteUtils.navigateRoute(RouteUtils.addEnquiryScreen);
          }),
      body: buildBody(),
    );
  }

  Widget buildBody() {
    return SizedBox(
        width: Get.width,
        height: Get.height,
        child: GetBuilder<EnquiryViewModel>(
          tag: EnquiryViewModel().toString(),
          builder: (controller) {
            if (controller.getEnquiryListApiResponse.status == Status.LOADING ||
                controller.getEnquiryListApiResponse.status == Status.INITIAL) {
              return getDataLoadingIndicator();
            }
            if (controller.getEnquiryListApiResponse.status == Status.ERROR) {
              return getDataErrorMsg();
            }
            GetEnquiryListResModel model =
                controller.getEnquiryListApiResponse.data;
            if (model.status != VariableUtils.ok) {
              return getFieldIsEmptyMsg();
            }
            print('LENGTH:${model.data!.length}');
            return model.data!.isEmpty
                ? getNotApplicableMsg(msg: model.msg)
                : Stack(
                    children: [
                      ListView.builder(
                        physics:const BouncingScrollPhysics(),
                        itemCount: model.data!.length,
                        itemBuilder: (context, index) {
                          final data = model.data![index];
                          return InkWell(
                            onTap: () {
                              onListTileTap(data.id!);
                            },
                            child: Container(
                              margin:const EdgeInsets.fromLTRB(20, 10, 20, 20),
                              decoration: DecorationUtils.commonDecorationBox(),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 20),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  richText(
                                      key: VariableUtils.studentName + ' : ',
                                      value: data.studentName ??
                                          VariableUtils.none),
                                  SizeConfig.sH10,
                                  richText(
                                      key: VariableUtils.parentName + ' : ',
                                      value: data.parentName!),
                                  SizeConfig.sH10,
                                  richText(
                                      key: VariableUtils.admissionForClass +
                                          ' : ',
                                      value: data.admissionForClass ??
                                          VariableUtils.none),
                                  SizeConfig.sH10,
                                  richText(
                                      key: VariableUtils.status,
                                      value: data.status ?? VariableUtils.none),
                                  SizeConfig.sH10,

                                  buildRow(
                                      icon:const Icon(
                                        ConstUtils.kCallIcon,
                                        size: 20,
                                      ),
                                      title: data.contactNo!),
                                  SizeConfig.sH5,
                                  buildRow(
                                      icon:const Icon(ConstUtils.kLocationIcon),
                                      title: data.area!),

                                  // richText(
                                  //     key: VariableUtils.area + ' : ',
                                  //     value: data.area ?? VariableUtils.none),
                                  // SizeConfig.sH10,
                                  // richText(
                                  //     key: VariableUtils.pNumber + ' : ',
                                  //     value: data.contactNo ?? VariableUtils.none),
                                  // SizeConfig.sH10,

                                  // SizeConfig.sH10,
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                      if (controller.getEnquiryInfoApiResponse.status ==
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

  Future<void> onListTileTap(String id) async {
    await viewModel.getEnquiryInfo(id);
    if (viewModel.getEnquiryInfoApiResponse.status == Status.COMPLETE) {
      GetEnquiryInfoResModel res = viewModel.getEnquiryInfoApiResponse.data;
      if (res.status != VariableUtils.ok) {
        showToast(msg: VariableUtils.equipmentInfoNotGet);
      } else {
        RouteUtils.navigateRoute(RouteUtils.addEnquiryScreen,
            args: res.data!.first);
      }
    } else {
      showToast(msg: VariableUtils.somethingWantWrong);
    }
  }
}

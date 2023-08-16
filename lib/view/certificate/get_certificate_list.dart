// ignore_for_file: use_key_in_widget_constructors, prefer_final_fields, avoid_print

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:msp_educare_demo/common/commonMethods/custom_appbar.dart';
import 'package:msp_educare_demo/common/commonMethods/download_file.dart';
import 'package:msp_educare_demo/common/commonMethods/loading_indicator.dart';
import 'package:msp_educare_demo/model/apiModel/responseModel/get_certificate_list.dart';
import 'package:msp_educare_demo/model/apis/api_response.dart';
import 'package:msp_educare_demo/utils/color_utils.dart';
import 'package:msp_educare_demo/utils/const_utils.dart';
import 'package:msp_educare_demo/utils/font_style_utils.dart';
import 'package:msp_educare_demo/utils/variable_utils.dart';
import 'package:msp_educare_demo/viewModel/certificate_viewmodel.dart';

class GetCertificateList extends StatefulWidget {
  @override
  _GetCertificateListState createState() => _GetCertificateListState();
}

class _GetCertificateListState extends State<GetCertificateList> {
  CertificateViewModel _viewModel =
      Get.find(tag: CertificateViewModel().toString());

  @override
  void initState() {
    init();
    super.initState();
  }

  void init() {
    _viewModel.getCertificateList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar(title: VariableUtils.certificate, centerTitle: true),
      body: buildBody(),
    );
  }

  Widget buildBody() {
    return GetBuilder<CertificateViewModel>(
        tag: CertificateViewModel().toString(),
        builder: (controller) {
          if (controller.getCertificateListApiResponse.status ==
                  Status.LOADING ||
              controller.getCertificateListApiResponse.status ==
                  Status.INITIAL) {
            return getDataLoadingIndicator();
          }
          if (controller.getCertificateListApiResponse.status == Status.ERROR) {
            return getDataErrorMsg();
          }
          GetCertificateListResModel model =
              controller.getCertificateListApiResponse.data;
          if (model.status != VariableUtils.ok) {
            return getFieldIsEmptyMsg();
          }
          print('LENGTH:${model.data!.length}');
          return model.data!.isEmpty
              ? getNotApplicableMsg(msg: model.msg)
              : Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                  child: SizedBox(
                    width: Get.width,
                    height: Get.height,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: DataTable(
                            columnSpacing: 30,
                            headingRowHeight: 40,
                            horizontalMargin: 10,
                            headingRowColor: MaterialStateColor.resolveWith(
                                (states) => ColorUtils.black2),
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: ColorUtils.grey, width: 0.2)),
                            // border: TableBorder.all(
                            //     color: ColorUtils.grey, width: 0.2),
                            columns: ConstUtils.kCertificateTableRowList
                                .map(
                                  (e) => DataColumn(
                                      label: Text(
                                    e,
                                    style: FontTextStyle.poppinsW6S14White,
                                    textAlign: TextAlign.left,
                                  )),
                                )
                                .toList(),
                            rows: model.data!
                                .map(
                                  (e) => DataRow(cells: [
                                    DataCell(
                                      Center(
                                        child: Text(
                                            "${model.data!.indexOf(e) + 1}",
                                            textAlign: TextAlign.center),
                                      ),
                                    ),
                                    DataCell(Center(
                                        child: Text(e.certificateName ??
                                            VariableUtils.none))),
                                    DataCell(Center(
                                        child: Text(e.createdOn ??
                                            VariableUtils.none))),
                                    DataCell(InkWell(
                                      onTap: () {
                                        downloadFile(e.certificate!);
                                      },
                                      child:const Icon(
                                        ConstUtils.kDownloadIcon,
                                        color: ColorUtils.blue,
                                      ),
                                    )),
                                  ]),
                                )
                                .toList()),
                      ),
                    ),
                  ),
                );
        });
  }
}

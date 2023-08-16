import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';

import 'package:msp_educare_demo/common/commonMethods/url_launch.dart';
import 'package:msp_educare_demo/utils/font_style_utils.dart';
import 'package:msp_educare_demo/utils/size_config_utils.dart';

class DialogTitleDesColumn extends StatelessWidget {
  final String title, value;

  const DialogTitleDesColumn({
    Key? key,
    required this.title,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: FontTextStyle.poppinsW6S12Grey,
        ),
        SizeConfig.sH5,
        Linkify(
          onOpen: (link){
            if( value.contains('http://') || value.contains('https://')){
              urlLaunch(link.url);
            }
          },
          text: value,
        )
        // InkWell(
        //   onTap: value.contains('http://') || value.contains('https://')
        //       ? () {
        //           urlLaunch(value);
        //         }
        //       : null,
        //   child: Text(
        //     value,
        //     style: FontTextStyle.poppinsW5S12Grey,
        //   ),
        // ),
      ],
    );
  }
}

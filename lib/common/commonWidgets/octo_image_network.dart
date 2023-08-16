/// KEY : octoImg
/// Desc. : Add OctoImage For Loading Network Image
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:msp_educare_demo/utils/assets/images_utils.dart';
import 'package:msp_educare_demo/utils/color_utils.dart';
import 'package:octo_image/octo_image.dart';

// ///FIRST IMPORT OCTO IMAGE PACKAGE & GETX PACKAGE

class OctoImageNetwork extends StatelessWidget {
  final String? url;
  final double? height;
  final double? width;
  final double? radius;
  final bool circleShape;
  final bool fit;
  final BoxFit? boxFit;

  const OctoImageNetwork(
      {Key? key,
      this.url,
      this.height,
      this.width,
      this.circleShape = true,
      this.fit = false,
      this.radius,
      this.boxFit})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('URL : => $url');

    return OctoImage(
      image: NetworkImage(url!),
      imageBuilder: (context, child) {
        return circleShape
            ? CircleAvatar(
                radius: radius,
                backgroundImage: NetworkImage(url!),
              )
            : Container(
                height: height,
                width: width,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(url!),
                      fit: fit ? BoxFit.cover : boxFit ?? BoxFit.fitWidth),
                ),
              );
      },
      placeholderBuilder: OctoPlaceholder.blurHash(
        'LEHV6nWB2yk8pyo0adR*.7kCMdnj',
      ),
      /* progressIndicatorBuilder: (context, progress) {
      double value;
      if (progress != null && progress.expectedTotalBytes != null) {
        value = progress.cumulativeBytesLoaded / progress.expectedTotalBytes;
      }
      return CircularProgressIndicator(value: value);
    },*/
      errorBuilder: (context, error, stackTrace) {
        return Center(
          child: circleShape
              ? CircleAvatar(
                  radius: radius,
                  backgroundColor: ColorUtils.lightPurple,
                  backgroundImage: ImagesWidgets.personIcon,
                  // child: ImagesWidgets.eventPersonIcon,
                )
              /*Icon(
                  Icons.error_outline,
                  color: ColorUtils.white,
                )*/
              : Text(
                  'Image not load',
                  textAlign: TextAlign.center,
                ),
        );
      },
      // errorBuilder: OctoError.icon(color: Colors.grey),
      fit: BoxFit.contain,
      height: height,
      width: width,
    );
  }
}
//
// Widget imageNotFound() {
//   return CircleAvatar(
//     radius: Get.width * 0.075,
//     backgroundImage: AssetImage('assets/image/person.jpg'),
//   );
// }
//
// Container imageNotLoadRectangle() {
//   return Container(
//     width: Get.width,
//     height: Get.height * 0.225,
//     decoration: BoxDecoration(
//       borderRadius: BorderRadius.circular(15),
//       color:,
//     ),
//     child: Center(child: Text('Image not load')),
//   );
// }

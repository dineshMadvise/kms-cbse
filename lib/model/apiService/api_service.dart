import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart' as dio;
import 'package:msp_educare_demo/model/apiService/base_service.dart';
import 'package:msp_educare_demo/model/apis/api_exception.dart';
import 'package:msp_educare_demo/utils/enum_utils.dart';

/// USE DIO TO API CALLING
class ApiService extends BaseService {
  var response;
  dio.Dio _dio = dio.Dio();

  Future<dynamic> getResponse(
      {required APIType apiType,
        Map<String, dynamic>? body,
        bool fileUpload = false}) async {
    try {
      String url = getInSchBaseURL+"mobapi";
      String encodeBody = jsonEncode(body);
      // Map<String, String> header = {'Content-Type': 'application/json'};
      print("URL ---> ${Uri.parse(url)}");
      print('REQ : => $encodeBody');
      // log('Header :$headerTokenGet');

      ///------------------------------------ GET METHOD -------------------------------------///

      if (apiType == APIType.aGet) {
        dio.Response result;

        ///Type-1 : QUERY PARAMETER PASS IN THIS queryParameters    like, URL?name=demo@data=dem  , Pass this type parameter in body map format
        result = await _dio.get(
          url,
          queryParameters: body,
        );

        ///Type-2 :  QUERY PARAMETER PASS IN THIS URL    like, URL?name=demo@data=dem
        // result = await _dio.get(baseURL + url);
        response = returnResponse(
          result.statusCode!,
          jsonEncode(result.data),
        );
        log("Get response......$response");
      }

      ///------------------------------------ FILE UPLOAD METHOD -------------------------------------///
      else if (fileUpload) {
        /// IN OPTIONS YOU CAN SET HEADER PARAMETER....
        dio.FormData formData = new dio.FormData.fromMap(body!);

        dio.Response result = await dio.Dio().post(url,
            data: formData,
            options: dio.Options(
              contentType: "form-data", /*headers: headerWithToken*/
            ));

        response = returnResponse(result.statusCode!, jsonEncode(result.data));
        log("File Upload response......$response");
      }

      ///------------------------------------ POST METHOD -------------------------------------///
      else {
        dio.Response result;
        result = await _dio.post(
          url,
          data: body,
        );
        print('STATUS CODE :${result.statusCode}');
        print('RESPONSE : => ${result.data}');
        response = returnResponse(
          result.statusCode!,
          jsonEncode(result.data),
        );
        log("Post response......$response");
      }

      return response is String ? jsonDecode(response) : response;
    } catch (e) {
      log('Error=>.. $e');
      return null;
    }
  }

  returnResponse(int status, String result) {
    switch (status) {
      case 200:
        return jsonDecode(result);
      case 400:
        throw BadRequestException('Bad Request');
      case 401:
        throw UnauthorisedException('Unauthorised user');
      case 404:
        throw ServerException('Server Error');
      case 500:
      default:
        throw FetchDataException('Internal Server Error');
    }
  }
}

// /// USE HTTP TO API CALLING
// class ApiService extends BaseService {
//   var response;
//
//   Future<dynamic> getResponse(
//       {@required APIType? apiType,
//       @required String? url,
//       Map<String, dynamic>? body,
//       bool fileUpload = false}) async {
//     try {
//       log("URL ---> ${Uri.parse(baseURL + url!)}");
//
//       ///------------------------------------ GET METHOD -------------------------------------///
//       if (apiType == APIType.aGet) {
//         var result = await http.get(
//           Uri.parse(baseURL + url), /* headers: headerTokenGet*/
//         );
//         response = returnResponse(
//           result.statusCode,
//           result.body,
//         );
//         log("Get response......$response");
//       }
//
//       ///------------------------------------ FILE UPLOAD METHOD -------------------------------------///
//
//       else if (fileUpload) {
//         /// REQUEST BODY FOR FILE UPLOAD. HERE PASS MULTIPLE (LIST) IMAGES
//         /*   {
//   'status_headline': {
//     'data': 'demo',
//     'isFile': false
//   },
//   'status_text': {
//     'data': 'statusText',
//     'isFile': false
//   },
//   'customer_id': {
//     'data': '115',
//     'isFile': false
//   },
//   'feed_url[]': {
//     'data': [           /// THIS IS LIST OF IMAGES
//       '/data/user/0/com.xo.beauty_app/cache/image_picker6027980340142521761.jpg'
//     ],
//     'isFile': true
//   },
//
// }*/
//
//         var postUri = Uri.parse(baseURL + url);
//         var request = new http.MultipartRequest("POST", postUri);
//         List<String> keysList = body!.keys.toList();
//         List<dynamic> valueList = body.values.toList();
//         for (int index = 0; index < body.keys.toList().length; index++) {
//           if (valueList[index]['isFile']) {
//             request.files.add(new http.MultipartFile.fromString(
//               keysList[index],
//               jsonEncode(await valueList[index]['data']),
//             ));
//           } else {
//             request.fields[keysList[index]] = valueList[index]['data'];
//           }
//         }
//         request.headers
//             .addAll(header(status: APIHeaderType.fileUploadWithToken));
//         http.StreamedResponse result = await request.send();
//         print('response Code:::${result.statusCode}');
//         if (result.statusCode == 200) {
//           var responseData = await result.stream.toBytes();
//           var responseString = String.fromCharCodes(responseData);
//           response = returnResponse(result.statusCode, responseString);
//           log("File Upload response......$response");
//         } else {
//           return null;
//         }
//       }
//
//       ///------------------------------------ POST METHOD -------------------------------------///
//
//       else {
//         String encodeBody = jsonEncode(body);
//         var result = await http.post(
//           Uri.parse(baseURL + url),
//           /* headers: headerWithToken,*/
//           body: encodeBody,
//         );
//         response = returnResponse(result.statusCode, result.body);
//         log("response......$response");
//       }
//       return response;
//     } catch (e) {
//       log('Error=>.. $e');
//     }
//   }
//
//   dynamic returnResponse(int status, String result) {
//     switch (status) {
//       case 200:
//         return jsonDecode(result);
//       case 400:
//         throw BadRequestException('Bad Request');
//       case 401:
//         throw UnauthorisedException('Unauthorised user');
//       case 404:
//         throw ServerException('Server Error');
//       case 500:
//       default:
//         throw FetchDataException('Internal Server Error');
//     }
//   }
// }

Map<String, String> header({APIHeaderType? status}) {
  if (status == APIHeaderType.fileUploadWithToken) {
    return {
      'Content-Type': "form-data",
      "Authorization":
      'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIzIiwianRpIjoiY2Q1OWRmMmRjZTVlN2IyNjc0ZGY2OTVjNzM1OWZkNGM0MTY3ZGE4Y2VjNjkxYWUzNTYyNjZlZWZmOTRmMzgwZTY5YTM3Yjg1OGEyN2EwZjciLCJpYXQiOjE2Mjg0MDA2NjUuOTMwMzEyLCJuYmYiOjE2Mjg0MDA2NjUuOTMwMzE4LCJleHAiOjE2NTk5MzY2NjUuODcwNjcxLCJzdWIiOiIxNDgiLCJzY29wZXMiOltdfQ.P2ck7V0qJALgeEk9xUbpI_lHgUHcO7L5qwvGfjK8wC4omfZvOWfm8hTl9qTj9CSkhcDhW84XnSULJqwN4__dADsqWja_8O7ZyIkeBQqqfIjSrjhw3YYttU3LQpf4xDuwhbw6XElhaSmxMzqdC9Im4TDDlyyU29Wzk_-cB0Pux3X0dfq0xAJzG8wO1IafNmCIPyCi_L13UbAvINh_ok-CfDFoGog9siEj182_QhkIxlvnF788hnO8xTmieFoCxIYYHmkafzs3ccT6hSXg7aPfliqMIJ10LP9b3mwZNFAx7Xhocx_lvNnnZlF1LCsPmgYRKBgPlXll4xPi4_LhCLErpNmvB6JepiFOXDwKANgdiP4MyCA-4SOLj4r4vfCO0_BIUkXWMHylV6bekVmsV_AbrblZd8k6Q0uxqq14vFsSz5BYqqbfXsWJ-2JyLX-hE_OrbmkU3-3zRry7v2hwjBkJIh-xMF6TtDaSlpGDJLxNA0QwgcIOLQVm8ILXAYFVwP0gKN5X4H2AbR0yCRTF9eT5fXwHMPwx04Tv98cXF299dhz21gJOtWKOurmB5wBdQ2DGN7P6KbriPxsQ0AxKLaYgN5fDikBGsFzxYyYI7tvTjv2hMqGeJyE50BSNj8DMSObW0UIo9uRPGGtPCTVBMvGWwRCj6dfnFINPiH2xBEQmwn8'
    };
  } else if (status == APIHeaderType.fileUploadWithoutToken) {
    return {
      'Content-Type': "form-data",
    };
  } else if (status == APIHeaderType.jsonBodyWithToken) {
    return {
      'Content-Type': 'application/json',
      "Authorization":
      'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIzIiwianRpIjoiY2Q1OWRmMmRjZTVlN2IyNjc0ZGY2OTVjNzM1OWZkNGM0MTY3ZGE4Y2VjNjkxYWUzNTYyNjZlZWZmOTRmMzgwZTY5YTM3Yjg1OGEyN2EwZjciLCJpYXQiOjE2Mjg0MDA2NjUuOTMwMzEyLCJuYmYiOjE2Mjg0MDA2NjUuOTMwMzE4LCJleHAiOjE2NTk5MzY2NjUuODcwNjcxLCJzdWIiOiIxNDgiLCJzY29wZXMiOltdfQ.P2ck7V0qJALgeEk9xUbpI_lHgUHcO7L5qwvGfjK8wC4omfZvOWfm8hTl9qTj9CSkhcDhW84XnSULJqwN4__dADsqWja_8O7ZyIkeBQqqfIjSrjhw3YYttU3LQpf4xDuwhbw6XElhaSmxMzqdC9Im4TDDlyyU29Wzk_-cB0Pux3X0dfq0xAJzG8wO1IafNmCIPyCi_L13UbAvINh_ok-CfDFoGog9siEj182_QhkIxlvnF788hnO8xTmieFoCxIYYHmkafzs3ccT6hSXg7aPfliqMIJ10LP9b3mwZNFAx7Xhocx_lvNnnZlF1LCsPmgYRKBgPlXll4xPi4_LhCLErpNmvB6JepiFOXDwKANgdiP4MyCA-4SOLj4r4vfCO0_BIUkXWMHylV6bekVmsV_AbrblZd8k6Q0uxqq14vFsSz5BYqqbfXsWJ-2JyLX-hE_OrbmkU3-3zRry7v2hwjBkJIh-xMF6TtDaSlpGDJLxNA0QwgcIOLQVm8ILXAYFVwP0gKN5X4H2AbR0yCRTF9eT5fXwHMPwx04Tv98cXF299dhz21gJOtWKOurmB5wBdQ2DGN7P6KbriPxsQ0AxKLaYgN5fDikBGsFzxYyYI7tvTjv2hMqGeJyE50BSNj8DMSObW0UIo9uRPGGtPCTVBMvGWwRCj6dfnFINPiH2xBEQmwn8'
    };
  } else if (status == APIHeaderType.onlyToken) {
    return {
      "Authorization":
      'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIzIiwianRpIjoiY2Q1OWRmMmRjZTVlN2IyNjc0ZGY2OTVjNzM1OWZkNGM0MTY3ZGE4Y2VjNjkxYWUzNTYyNjZlZWZmOTRmMzgwZTY5YTM3Yjg1OGEyN2EwZjciLCJpYXQiOjE2Mjg0MDA2NjUuOTMwMzEyLCJuYmYiOjE2Mjg0MDA2NjUuOTMwMzE4LCJleHAiOjE2NTk5MzY2NjUuODcwNjcxLCJzdWIiOiIxNDgiLCJzY29wZXMiOltdfQ.P2ck7V0qJALgeEk9xUbpI_lHgUHcO7L5qwvGfjK8wC4omfZvOWfm8hTl9qTj9CSkhcDhW84XnSULJqwN4__dADsqWja_8O7ZyIkeBQqqfIjSrjhw3YYttU3LQpf4xDuwhbw6XElhaSmxMzqdC9Im4TDDlyyU29Wzk_-cB0Pux3X0dfq0xAJzG8wO1IafNmCIPyCi_L13UbAvINh_ok-CfDFoGog9siEj182_QhkIxlvnF788hnO8xTmieFoCxIYYHmkafzs3ccT6hSXg7aPfliqMIJ10LP9b3mwZNFAx7Xhocx_lvNnnZlF1LCsPmgYRKBgPlXll4xPi4_LhCLErpNmvB6JepiFOXDwKANgdiP4MyCA-4SOLj4r4vfCO0_BIUkXWMHylV6bekVmsV_AbrblZd8k6Q0uxqq14vFsSz5BYqqbfXsWJ-2JyLX-hE_OrbmkU3-3zRry7v2hwjBkJIh-xMF6TtDaSlpGDJLxNA0QwgcIOLQVm8ILXAYFVwP0gKN5X4H2AbR0yCRTF9eT5fXwHMPwx04Tv98cXF299dhz21gJOtWKOurmB5wBdQ2DGN7P6KbriPxsQ0AxKLaYgN5fDikBGsFzxYyYI7tvTjv2hMqGeJyE50BSNj8DMSObW0UIo9uRPGGtPCTVBMvGWwRCj6dfnFINPiH2xBEQmwn8'
    };
  } else {
    return {
      'Content-Type': 'application/json',
    };
  }
}

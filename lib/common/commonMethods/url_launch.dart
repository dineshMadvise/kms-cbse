import 'package:url_launcher/url_launcher.dart';

Future<void> urlLaunch(String url) async {
  if (!await launch(url)) throw 'Could not launch $url';
}

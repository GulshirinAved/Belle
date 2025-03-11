import 'dart:developer';
import 'dart:io';

import 'package:url_launcher/url_launcher.dart';

class URLLauncherHelper {
  static Future<void> sendSms(String? phoneNumber, String smsText) async {
    if (phoneNumber == null || phoneNumber.isEmpty) {
      return;
    }
    try {
      if (Platform.isAndroid) {
        String uri =
            'sms:+993$phoneNumber?body=${Uri.encodeComponent(smsText)}';
        await launchUrl(Uri.parse(uri));
      } else if (Platform.isIOS) {
        String uri =
            'sms:+993$phoneNumber&body=${Uri.encodeComponent(smsText)}';
        await launchUrl(Uri.parse(uri));
      }
    } catch (e) {
      log(e.toString());
    }
  }

  static Future<void> phoneCall(String? phoneNumber) async {
    if (phoneNumber == null || phoneNumber.isEmpty) {
      return;
    }
    final url = Uri.parse('tel:+993$phoneNumber');
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }
}

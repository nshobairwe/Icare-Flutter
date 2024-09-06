import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/sms.dart';

class SMService {
  static Future<SmsResponse> fetchSmsData() async {
    var url = Uri.parse('http://192.168.137.51:8081/sms/receive');

    // Sending the request as form data
    var response = await http.post(
      url,
      headers: {
        "Content-Type": "application/x-www-form-urlencoded",
      },
      body: {
        "action": "outgoing",  // Sending form data key-value pairs
      },
    );

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');


    if (response.statusCode == 200) {
      return SmsResponse.fromJson(
          jsonDecode(response.body)
      );

    } else {
      throw Exception('Failed to load SMS data: ${response.statusCode}');
    }
  }
}

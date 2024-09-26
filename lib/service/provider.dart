import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:background_sms/background_sms.dart';
import 'package:permission_handler/permission_handler.dart';
import '../models/sms.dart';

class SMService {
  // Request SMS permission
  static Future<bool> _requestSmsPermission() async {
    var status = await Permission.sms.status;
    if (!status.isGranted) {
      status = await Permission.sms.request();
    }
    return status.isGranted;
  }

  // Function to send SMS in the background using background_sms
  static Future<void> sendBackgroundSMS(
      String phoneNumber,
      String messageContent,
      Function(String) onSuccess, // Callback for success message
      ) async {
    // Ensure SMS permission is granted
    if (await _requestSmsPermission()) {
      SmsStatus result = await BackgroundSms.sendMessage(
        phoneNumber: phoneNumber,
        message: messageContent,
        simSlot: 1,  // Change this if you're using a different SIM slot
      );

      if (result == SmsStatus.sent) {
        // print("SMS sent successfully to $phoneNumber");
        onSuccess("SMS Sent Successfully");
      } else {
        print("Failed to send SMS to $phoneNumber");
        onSuccess("Failed to send SMS");
      }
    } else {
      print("SMS permission not granted");
      onSuccess("SMS permission not granted");
    }
  }

  // Fetch data and send SMS for each message
  static Future<void> fetchSmsData(Function(String) onSuccess) async {

    var url = Uri.parse('http://192.168.43.65:8081/sms/receive');

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
      // Parse the JSON response
      var data = jsonDecode(response.body);

      // Iterate through the events and send SMS for each message
      for (var event in data['events']) {
        for (var message in event['messages']) {
          String phoneNumber = message['to'];
          String messageContent = message['message'];

          await sendBackgroundSMS(phoneNumber, messageContent, (successMessage) async {
            // Handle success message
            onSuccess(successMessage);
          });
        }
      }
    } else {
      throw Exception('Failed to load SMS data: ${response.statusCode}');
    }
  }
}

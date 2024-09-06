import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:icare/models/sms.dart';
import 'package:icare/screen/sms_setting.dart';
import 'package:icare/service/provider.dart';

class LogViewScreen extends StatefulWidget {
  @override
  _LogViewScreenState createState() => _LogViewScreenState();
}

class _LogViewScreenState extends State<LogViewScreen> {
  late Future<SmsResponse> futureSmsResponse;

  @override
  void initState() {
    super.initState();
    futureSmsResponse = SMService.fetchSmsData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(45.0),
        child: AppBar(
          title: Text('EnvayaSMS: Log View'),
        ),
      ),
      body: Column(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SmsSetting()));
            },
            child: Container(
              color: Colors.grey[600],
              child: Center(
                child: Column(
                  children: [
                    Text(
                      'EnvayaSMS disabled',
                      style: TextStyle(
                        fontSize: 15.0,
                      ),
                    ),
                    Text(
                      'New messages will not be forwarded to server',
                      style: TextStyle(
                        fontSize: 15.0,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: FutureBuilder<SmsResponse>(
              future: futureSmsResponse,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.events.isEmpty) {
                  return Center(child: Text('No SMS data found'));
                }

                // Display the events and messages
                return ListView.builder(
                  itemCount: snapshot.data!.events.length,
                  itemBuilder: (context, eventIndex) {
                    Event event = snapshot.data!.events[eventIndex];
                    print('Event: ${event.event}, Messages: ${event.messages.length}');

                    return ExpansionTile(
                      title: Text('Event: ${event.event}'),
                      children: event.messages.map((message) {
                        print('Message to: ${message.to}, Content: ${message.message}');
                        return ListTile(
                          title: Text('To: ${message.to}'),
                          subtitle: Text(message.message),
                        );
                      }).toList(),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

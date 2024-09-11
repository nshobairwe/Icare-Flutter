import 'package:flutter/material.dart';

import 'package:icare/screen/sms_setting.dart';

class LogViewScreen extends StatefulWidget {
  @override
  _LogViewScreenState createState() => _LogViewScreenState();
}

class _LogViewScreenState extends State<LogViewScreen> {

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
        ],
      ),
    );
  }


}

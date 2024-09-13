import 'dart:async'; // Import this to use Future.delayed
import 'package:flutter/material.dart';

import 'package:icare/screen/sms_setting.dart';

class LogViewScreen extends StatefulWidget {
  final DateTime? evayaEnabledTime;
  final String? evayaSmsStarted;
  final String? OutgoingSmsTime;
  final String? checkingForSms;
  final String? smsSent;

  const LogViewScreen({
    Key? key,
    this.evayaEnabledTime,
    this.evayaSmsStarted,
    this.OutgoingSmsTime,
    this.checkingForSms,
    this.smsSent,
  }) : super(key: key);

  @override
  _LogViewScreenState createState() => _LogViewScreenState();
}

class _LogViewScreenState extends State<LogViewScreen> {
  // Track which texts should be visible
  List<bool> _visibleTexts = [false, false, false, false, false];

  @override
  void initState() {
    super.initState();
    _showTextsWithDelay();
  }

  void _showTextsWithDelay() {
    // Create a delay for each text to appear
    Future.delayed(Duration(seconds: 1), () {
      setState(() {
        _visibleTexts[0] = true;
      });
    });

    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        _visibleTexts[1] = true;
      });
    });

    Future.delayed(Duration(seconds: 3), () {
      setState(() {
        _visibleTexts[2] = true;
      });
    });

    Future.delayed(Duration(seconds: 4), () {
      setState(() {
        _visibleTexts[3] = true;
      });
    });
    Future.delayed(Duration(seconds: 5), () {
      setState(() {
        _visibleTexts[4] = true;
        print("smsSent is set to visible");
      });
    });
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
          Column(
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
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                if (_visibleTexts[0]) Text('[${widget.evayaEnabledTime}]'),
                if (_visibleTexts[1]) Text('${widget.evayaSmsStarted}'),
                if (_visibleTexts[2]) Text('${widget.OutgoingSmsTime}'),
                if (_visibleTexts[3]) Text('${widget.checkingForSms}'),
                if(_visibleTexts[4]) Text('${widget.smsSent}')
               ],
            ),
          ),
        ],
      ),
    );
  }
}

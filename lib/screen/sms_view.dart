import 'dart:async';
import 'package:flutter/material.dart';
import 'package:icare/screen/sms_setting.dart';

class LogViewScreen extends StatefulWidget {
  final DateTime? evayaEnabledTime;
  final String? evayaSmsStarted;
  final String? OutgoingSmsTime;
  final String? checkingForSms;
  final String? smsSent;
  final String? runningNumber;
  final String? smsForwadedToServer;


  const LogViewScreen({
    Key? key,
    this.evayaEnabledTime,
    this.evayaSmsStarted,
    this.OutgoingSmsTime,
    this.checkingForSms,
    this.smsSent,
    this.runningNumber, this.smsForwadedToServer,
  }) : super(key: key);

  @override
  _LogViewScreenState createState() => _LogViewScreenState();
}

class _LogViewScreenState extends State<LogViewScreen> {
  List<bool> _visibleTexts = [false, false, false, false];
  String evayaDisabled = 'EnvayaSMS disabled';
  String smsNotForwadedToServer = 'New messages will not be forwarded to a server';
  List<Timer> _timers = []; // List to hold all the timers

  @override
  void initState() {
    super.initState();
    _showTextsWithDelay();
  }

  @override
  void dispose() {
    // Cancel all timers when the widget is disposed
    for (var timer in _timers) {
      timer.cancel();
    }
    super.dispose();
  }

  void _showTextsWithDelay() {
    _timers.add(
      Timer(Duration(seconds: 1), () {
        if (mounted) {
          setState(() {
            _visibleTexts[0] = true;
          });
        }
      }),
    );

    _timers.add(
      Timer(Duration(seconds: 2), () {
        if (mounted) {
          setState(() {
            _visibleTexts[1] = true;
          });
        }
      }),
    );

    _timers.add(
      Timer(Duration(seconds: 3), () {
        if (mounted) {
          setState(() {
            _visibleTexts[2] = true;
          });
        }
      }),
    );

    _timers.add(
      Timer(Duration(seconds: 4), () {
        if (mounted) {
          setState(() {
            _visibleTexts[3] = true;
          });
        }
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    String displayedText = widget.runningNumber?.isNotEmpty == true
        ? widget.runningNumber!
        : evayaDisabled;
    String displaySmsForwaded = widget.smsForwadedToServer?.isNotEmpty == true
              ? widget.smsForwadedToServer!
              : smsNotForwadedToServer;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(45.0),
        child: AppBar(
          title: Text('EnvayaSMS: Log View'),
        ),
      ),
      body: Container(
        child: Column(
          children: [
            Container(
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => SmsSetting()));
                    },
                    child: Container(
                      color: Colors.grey[600],
                      padding: EdgeInsets.all(16.0),
                      child: Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              displayedText,
                              style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(height: 8.0),
                            Text(
                              displaySmsForwaded,
                              style: TextStyle(
                                fontSize: 14.0,
                                color: Colors.white70,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                alignment: Alignment.topLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    if (_visibleTexts[0]) Text('[${widget.evayaEnabledTime}]'),
                    if (_visibleTexts[1]) Text('${widget.evayaSmsStarted}'),
                    if (_visibleTexts[2]) Text('${widget.OutgoingSmsTime}'),
                    if (_visibleTexts[3]) Text('${widget.checkingForSms}'),

                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

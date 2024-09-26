import 'dart:async';
import 'package:flutter/material.dart';
import 'package:icare/screen/sms_setting.dart';
import 'package:provider/provider.dart';

import '../models/sms_model.dart';

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
    this.runningNumber,
    this.smsForwadedToServer,
  }) : super(key: key);

  @override
  _LogViewScreenState createState() => _LogViewScreenState();
}

class _LogViewScreenState extends State<LogViewScreen> {
  List<bool> _visibleTexts = [false, false, false, false, false];
  String evayaDisabled = 'EnvayaSMS disabled';
  String smsNotForwadedToServer = 'New messages will not be forwarded to a server';
  List<Timer> _timers = [];

  @override
  void initState() {
    super.initState();
    _showTextsWithDelay();
  }

  @override
  void dispose() {
    for (var timer in _timers) {
      timer.cancel();
    }
    super.dispose();
  }

  void _showTextsWithDelay() {
    for (int i = 0; i < _visibleTexts.length; i++) {
      _timers.add(
        Timer(Duration(seconds: i + 1), () {
          if (mounted) {
            setState(() {
              _visibleTexts[i] = true;
            });
          }
        }),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
   // final smsModel = Provider.of<SmsModel>(context, listen: false);
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
      body: Consumer<SmsModel>(
        builder: (context, smsModel, child) {
          return Container(
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SmsSetting()),
                    );
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
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                        alignment: Alignment.topLeft,
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,

                            children: [
                              if (_visibleTexts[0]) Text('${widget.evayaEnabledTime ?? 'No Data'}'),
                    if (_visibleTexts[1]) Text('${widget.evayaSmsStarted ?? 'No Data'}'),
                if (_visibleTexts[2]) Text('${widget.OutgoingSmsTime ?? 'No Data'}'),
                if (_visibleTexts[3]) Text('${widget.checkingForSms ?? 'No Data'}'),
                Text('${smsModel.smsSent}'),
              ],
            ),
          ),
          ),
          ],
          ),
          );
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:icare/screen/sms_view.dart';
import 'package:provider/provider.dart';

import 'models/sms_model.dart';
import 'screen/sms_setting.dart';


void main() {
  runApp(
      ChangeNotifierProvider(
        create: (context) => SmsModel(),
        child: MyApp(),
      )
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.grey[500], // AppBar background color
          iconTheme: IconThemeData(
            color: Colors.white, // AppBar icon color
          ),
          titleTextStyle: TextStyle(
            color: Colors.white, // AppBar title color
          ),
        ),
        scaffoldBackgroundColor: Colors.grey[900], // Scaffold background color
        textTheme: TextTheme(
          bodyMedium: TextStyle(color: Colors.white), // General text color
        ),
      ),
      home: const LogViewScreen(
        evayaEnabledTime: null,
        checkingForSms: null,
        evayaSmsStarted: null,
        OutgoingSmsTime: null,

      )
    );
  }
}



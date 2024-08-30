import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:icare/settings/sms_setting.dart';

void main() {
  runApp(MyApp());
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
      home: LogViewScreen(),
    );
  }
}

class LogViewScreen extends StatefulWidget {
  @override
  _LogViewScreenState createState() => _LogViewScreenState();
}

class _LogViewScreenState extends State<LogViewScreen> {
  @override
  void initState() {
    super.initState();
    // Set the system UI overlay style here
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.black, // Status bar background color
      statusBarIconBrightness: Brightness.light, // Status bar icon color
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(45.0),
        child: AppBar(
          title: Text('EnvayaSMS:Log View'),
        ),
      ),
      body: Column(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) =>
                  SmsSetting())
                  );
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

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:jpush_flutter/jpush_flutter.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'JPush Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      debugShowCheckedModeBanner: false,
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    _initJPush();
  }

  _initJPush() async {
    JPush jPush = new JPush();
    jPush.setup(
      appKey: "bcc3d18e3b34f08315860bea",
      channel: "developer-default",
      production: false,
      debug: true, // 设置是否打印 debug 日志
    );

    if (Platform.isIOS) {
      jPush.applyPushAuthority(new NotificationSettingsIOS(sound: true, alert: true, badge: true));
    }

    print("=======JPushId:${await jPush.getRegistrationID()}");
    jPush.addEventHandler(
      // 接收通知回调方法。
      onReceiveNotification: (Map<String, dynamic> message) async {
        print("flutter onReceiveNotification: $message");
      },
      // 点击通知回调方法。
      onOpenNotification: (Map<String, dynamic> message) async {
        print("flutter onOpenNotification: $message");
      },
      // 接收自定义消息回调方法。
      onReceiveMessage: (Map<String, dynamic> message) async {
        print("flutter onReceiveMessage: $message");
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Text("极光推送Demo"),
      ),
    );
  }
}

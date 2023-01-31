import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teamtrack/View/home/home_screen.dart';
import 'package:teamtrack/splash_screen.dart';
import 'package:teamtrack/util/app_constants.dart';
import 'package:teamtrack/splash_screen.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:teamtrack/AppLayer/Overseer.dart';
import 'package:teamtrack/AppLayer/Provider.dart' as pro;
import 'package:get/get.dart';
import 'AppLayer/Overseer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:teamtrack/helper/notification_helper.dart';


enum Size {
  small,
  medium,
  large
}

enum BorderType {
  start,
  middle,
  end,
  theend
}
Future<void> main() async {

  HttpOverrides.global = MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();
 // await Firebase.initializeApp();
  try {
    if (GetPlatform.isMobile) {
      final RemoteMessage? remoteMessage = await FirebaseMessaging.instance.getInitialMessage();


      FirebaseMessaging.onBackgroundMessage(myBackgroundMessageHandler);
    }
  }catch(e) {}

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return pro.Provider(
        data: Overseer(),
        child: GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: AppConstant.APP_NAME,
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: SplashScreen(),
        ));
  }
}


class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
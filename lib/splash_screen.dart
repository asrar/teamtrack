import 'dart:async';

import 'package:teamtrack/AppLayer/Provider.dart';
import 'package:teamtrack/Login/UserManager.dart';
import 'package:teamtrack/View/home/home_screen.dart';
import 'package:teamtrack/admin/admin_home_screen.dart';
import 'package:teamtrack/util/dimensions.dart';
import 'package:teamtrack/Login/sign_in.dart';
import 'package:teamtrack/View/Project/project_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';



import '../../util/images.dart';
import 'AppLayer/Overseer.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  String userStatus = "";
  String role = "";

  @override
  void initState() {
    super.initState();
    userLoggedIn().whenComplete(() async{
      Timer(Duration(seconds: 4), (){
            print("--- printing after splash loading ---> $userStatus");
            if(!userStatus.contains("user-logged-true") ) {
              print(" -- going to login screen ");
              Get.to(SignIn(),);
            }else{
              print("-- splash role Id is ${Overseer.roleId}");
              if(role == "admin") {
                  Get.offAll(AdminHomeScreen());

              }else {
                print(" -- going to Main screen ");
                if(Overseer.myProjects.length==0) {
                  print("----- At the moment project 0");
                  UserManager manager = Provider.of(context).fetch(UserManager);
                  manager.loadProjectsData$.listen((event) async {
                    print("print Data Loaded AKS");
                  });
                }
                Get.to(ProjectScreen());
              }
            }
            //  Get.to(userStatus == null ?LoginScreen():BottomBar());
          }
      );
   });
  }
  Future userLoggedIn() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var obtainUser = sharedPreferences.getString('username');
    var obtainRole = sharedPreferences.getString('role');
    ///
    if(sharedPreferences.getString('image') != null){
      Overseer.userImage  = sharedPreferences.getString('image')!;
      Overseer.userPhone = sharedPreferences.getString('phone')!;
      Overseer.userEmail = sharedPreferences.getString('email')!;
      print("this is new thing about user condition");
    }
    print("Obtainer User"+"$obtainUser");
    print("Obtainer Role"+"$obtainRole");

    setState(() {
      userStatus = obtainUser.toString();
      role = obtainRole.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Image(
          width: MediaQuery.of(context).size.width,
          image: AssetImage(Images.logo),
        ),
      ),
    );
  }
}

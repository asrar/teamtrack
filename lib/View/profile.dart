import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:teamtrack/AppLayer/Overseer.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  SharedPreferences? sharedP;
  var image;

  @override
  Future<void> initState() async {
    // TODO: implement initState
    sharedP = await SharedPreferences.getInstance();
    if(sharedP!.getString("image") != null){
      image = sharedP!.getString("image");
    }
     super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize:
            Size.fromHeight(278),
        child: AppBar(
          elevation: 0,
          centerTitle: true,
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                  // begin: Alignment.topCenter,
                  // end: Alignment.bottomCenter,
                  colors: <Color>[Color(0xff5E70D8), Color(0xffCA57E3)]),
            ),
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.1,
                    ),
                  image == null ?  Container(
                      margin: EdgeInsets.only(left: 30,top: 41),
                      child: CircleAvatar(
                        maxRadius: 50,
                        // minRadius: ,
                        backgroundImage: AssetImage("assets/images/waleed.jpeg"),
                      ),
                      height: 100,
                      width: 100,
                    ): Container(
                    margin: EdgeInsets.only(left: 30,top: 41),
                    child: CircleAvatar(
                      maxRadius: 50,
                      // minRadius: ,
                      backgroundImage: AssetImage("assets/images/waleed.jpeg"),
                    ),
                    height: 100,
                    width: 100,
                  ),
                  ],
                ),
                Container(
                  width: MediaQuery.of(context).size.width*0.6,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: MediaQuery.of(context).size.height*0.16,),
                      tabContainer(context: context,title: Overseer.userName, ontap: () {}),
                      tabContainer(context: context,title: Overseer.userPhone, ontap: () {}),
                      tabContainer(context: context,title: Overseer.userEmail, ontap: () {}),
                    ],
                  ),
                )

              ],
            ),
          ),
          iconTheme: IconThemeData(color: Colors.white),
          title: Text(
            Overseer.userName,
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.deepOrange),
          ),
          // bottom: ,
        ),
      ),
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: Overseer.gradientBody()
        ),
        // child: ,
      ),
    );
  }

  Widget tabContainer({required BuildContext context,required String title, required Function() ontap}) {
    return GestureDetector(
        onTap: ontap,
        child: Container(
          // height: Get.height * 0.060,
          // width: double.infinity,
          margin: EdgeInsets.symmetric(vertical: 3),
          padding: EdgeInsets.only(left: 10,right: 10),
          decoration: BoxDecoration(
              // color: Colors.deepOrange,
            gradient: Overseer.gradientBody(),
              borderRadius: BorderRadius.circular(15)),
          child: Text(
            title,
            textAlign: TextAlign.start,
            style: TextStyle(
            color: Colors.white,
            fontFamily: 'poppins',
            fontWeight: FontWeight.normal,
            fontSize: 16),
          ),
        ));
  }
}

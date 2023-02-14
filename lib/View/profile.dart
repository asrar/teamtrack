import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teamtrack/AppLayer/Overseer.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        flexibleSpace: Overseer.appGradient(),
        iconTheme: IconThemeData(color: Colors.white),
        title:  Text(Overseer.userName ,style: TextStyle(fontSize: 18,
            fontWeight: FontWeight.bold ,color: Colors.deepOrange),),
      ),
      body: Container(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20,),
            Center(
              child: CircleAvatar(
                maxRadius: 50,
                // minRadius: ,
                backgroundImage: AssetImage("assets/images/waleed.jpeg"),),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Text(
                'Name:',
                textAlign: TextAlign.start,
                style: TextStyle(
                    color: Colors.deepOrange,
                    fontFamily: 'poppins',
                    fontWeight: FontWeight.normal,
                    fontSize: 16),
              ),
            ),
            tabContainer(title: Overseer.userName,ontap: (){}),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Text(
                'Phone No:',
                textAlign: TextAlign.start,
                style: TextStyle(
                    color: Colors.deepOrange,
                    fontFamily: 'poppins',
                    fontWeight: FontWeight.normal,
                    fontSize: 16),
              ),
            ),
            tabContainer(title: Overseer.userPhone,ontap: (){}),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Text(
                'Email:',
                textAlign: TextAlign.start,
                style: TextStyle(
                    color: Colors.deepOrange,
                    fontFamily: 'poppins',
                    fontWeight: FontWeight.normal,
                    fontSize: 16),
              ),
            ),
            tabContainer(title: Overseer.userEmail,ontap: (){}),
            // tabContainer(title: Overseer.userImage,ontap: (){}),


          ],
        ),
      ),
    );
  }
  Widget tabContainer({required String title, required Function() ontap}) {
    return GestureDetector(
        onTap: ontap,
        child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Card(
              elevation: 5,
              color: Colors.deepOrange,
              child: Container(
                height: Get.height * 0.060,
                width: Get.width * 0.85,
                decoration: BoxDecoration(
                    color: Colors.deepOrange,
                    borderRadius: BorderRadius.circular(15)),
                child: Center(
                    child: Text(
                      title,
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'poppins',
                          fontWeight: FontWeight.normal,
                          fontSize: 16),
                    )),
              ),
            )));
  }
}

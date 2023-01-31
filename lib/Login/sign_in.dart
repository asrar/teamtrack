import 'package:intl/intl.dart';
import 'package:teamtrack/View/Project/ProjectManager.dart';
import 'package:teamtrack/View/home/home_screen.dart';
import 'package:teamtrack/admin/GetMTStockManager.dart';
import 'package:teamtrack/admin/admin_home_screen.dart';
import 'package:teamtrack/util/app_constants.dart';
import 'package:teamtrack/util/dimensions.dart';

import 'package:teamtrack/widgets/custom_button.dart';
import 'package:teamtrack/widgets/custom_textField.dart';
import 'package:flutter/material.dart';
import 'package:teamtrack/AppLayer/Provider.dart';
import 'package:get/get.dart';
//import 'package:shared_preferences/shared_preferences.dart';

import 'package:teamtrack/Login/UserManager.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../AppLayer/Overseer.dart';

class SignIn extends StatefulWidget {
  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  @override
  Widget build(BuildContext context) {
    UserManager manager = Provider.of(context).fetch(UserManager);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.only(
            left: Dimensions.PADDING_SIZE_LARGE,
            top: Dimensions.PADDING_SIZE_EXTRA_LARGE,
            right: Dimensions.PADDING_SIZE_LARGE,
            bottom: Dimensions.PADDING_SIZE_DEFAULT),
        child: Form(
          key: new Key("form"),
          child: ListView(children: [
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        top: Dimensions.PADDING_SIZE_EXTRA_LARGE),
                    child: Text(
                      'Team Track Sign In',
                      style: TextStyle(
                          fontSize: 30,
                          fontFamily: 'Comfortaa',
                          letterSpacing: 1,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Please fill in the information to complete the sign in process',
                    style: TextStyle(
                      fontFamily: 'Comfortaa',
                      fontSize: 18,
                      letterSpacing: 1,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Email Address',
                    style: TextStyle(
                        fontFamily: 'Comfortaa',
                        fontSize: 20,
                        letterSpacing: 1,
                        fontWeight: FontWeight.w800),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  StreamBuilder<String>(
                      stream: manager.email$,
                      builder: (context, snapshot) {
                        return CustomTextField(
                            onChanged: (value) {
                              manager.inEmail.add(value);
                            },
                            errortext: snapshot.error == null
                                ? ""
                                : snapshot.error.toString(),
                            textFieldText: 'xyz@gmail.com',
                            passwordTxt: false);
                      }),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    'Password',
                    style: TextStyle(
                        fontFamily: 'Comfortaa',
                        fontSize: 20,
                        letterSpacing: 1,
                        fontWeight: FontWeight.w800),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  StreamBuilder<String>(
                      stream: manager.password$,
                      builder: (context, snapshot) {
                        return CustomTextField(
                            onChanged: (value) {
                              manager.inPassword.add(value);
                            },
                            errortext: snapshot.error == null
                                ? ""
                                : snapshot.error.toString(),
                            textFieldText: 'password',
                            passwordTxt: true);
                      }),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 15.0, top: 50),
              child: StreamBuilder<Object>(
                  stream: manager.isFormValid$,
                  builder: (context, snapshot) {
                    print("this is first call on submit ${snapshot.hasData}");
                    return InkWell(
                      onTap: () {
                        print("this is 2nd call on submit");
                        if(manager.email$.last ==""){
                          Get.snackbar(
                            "Error",
                            "Please Enter an Email Id",
                            dismissDirection: DismissDirection.horizontal,
                            isDismissible: true,
                            backgroundColor: Colors.red,
                            duration: Duration(seconds: 1),
                          );
                        }else if(manager.password$.last =="") {
                          Get.snackbar(
                            "Error",
                            "Please Enter a  Password",
                            dismissDirection: DismissDirection.horizontal,
                            isDismissible: true,
                            backgroundColor: Colors.red,
                            duration: Duration(seconds: 1),
                          );

                        }
                        else{
                          print("-- printing email id-${manager.email$.isEmpty.toString()}-");
                        Get.snackbar(
                        "Submitting",
                        "Verifying User Details",
                        dismissDirection: DismissDirection.horizontal,
                        isDismissible: true,
                        backgroundColor: Colors.green,
                        duration: Duration(seconds: 1),
                        );
                        }
                        print("this is 2.5 call");
                        print(" the actual datat is ${snapshot.hasData}");
                        if (snapshot.hasData) {
                          print("this is 3rd call after submit");
                          manager.isFormSubmit$.listen((event) async {
                            if (Overseer.is_user_valid) {
                              SharedPreferences sharedP = await SharedPreferences.getInstance();
                              sharedP.setString('username',"user-logged-true");
                              Get.snackbar(
                                "Congratulation",
                                "Successfully LogIn with Proof Tech App",
                                dismissDirection: DismissDirection.horizontal,
                                isDismissible: true,
                                backgroundColor: Colors.amber,
                                duration: Duration(seconds: 1),
                              );

                              // final SharedPreferences _sharedPreferences =
                              //     await SharedPreferences.getInstance();
                              // _sharedPreferences.setInt(
                              //     'userId', Overseer.userId);

                              print("-------- the real role is ${Overseer.roleId}");
                              if(Overseer.roleId.contains("1")) {
                                GetMTStockManager adminManager = Provider.of(context).fetch(GetMTStockManager);
                                adminManager.myList.listen((event) async {
                                  SharedPreferences sharedP = await SharedPreferences.getInstance();
                                  sharedP.setString('username',"user-logged-true");
                                  Get.offAll(AdminHomeScreen());
                                });



                              }else {
                                ProjectManager projectManager = Provider.of(context).fetch(ProjectManager);
                                projectManager.freshProjectData.listen((event) {

                                  print("overseer team length ${Overseer.myteamList.length}");
                                  print("got the freshed team data length ${Overseer.rollCallTeamList.length}");
                                  for(int i =0; i<Overseer.rollCallTeamList.length; i++)
                                  {
                                    if(Overseer.rollCallTeamList[i].startRollCall != null)
                                      print("List A (${Overseer.myteamList[i].lName}) ------ List B (${Overseer.rollCallTeamList[i].lName}  [${getRollCallTime(Overseer.rollCallTeamList[i].startRollCall!.createdAt!)}])");
                                  }

                                });
                                Get.offAll(HomeScreen());
                              }
                              // Navigator.push(context,
                              //     MaterialPageRoute(builder: (context) {
                              //   return DoctorListScreen();
                           //   }));
                              // print("${_sharedPreferences.getInt('userId')}");

                            } else if (snapshot.hasError) {
                              SharedPreferences sharedP = await SharedPreferences.getInstance();
                              sharedP.setString('username',"user-not-logged-true");
                              print("Login Failed");
                              Get.snackbar(
                                "Error",
                                "Get some Error..",
                                dismissDirection: DismissDirection.horizontal,
                                isDismissible: true,
                                backgroundColor: Colors.amber,
                                duration: Duration(seconds: 2),
                              );
                            }
                          });
                        } else {
                          print('This is 4th call');
                          Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      },
                      child: CustomButton(
                          textColor: Colors.white,
                          buttonName: 'Sign in',
                          bgColor: Color(0xff5492FD)),
                    );
                  }),
            ),

          ]),
        ),
      ),
    );
  }

  String getRollCallTime(String time){
    print("orignal time is ${time}");
    time = time.substring(time.indexOf('T')+1,time.indexOf('.'));
    time = time+"Z";
    var dateValue = new DateFormat("HH:mm:ssZ").parseUTC(time).toLocal();
    String formattedDate = DateFormat("hh:mm a").format(dateValue);
    debugPrint("formattedDate = "+formattedDate);

    print("parsing time is this ${time}");

    //  String formattedDate = formatter.format(now);
    // print("final time convert is ${formattedDate}");
    return formattedDate;
  }
}

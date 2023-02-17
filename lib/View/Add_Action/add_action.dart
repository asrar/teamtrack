import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teamtrack/View/Add_Action/AddActionManager.dart';

import '../../AppLayer/Overseer.dart';
import '../../AppLayer/Provider.dart';
import '../../logs/LogsManager.dart';
import '../../widgets/custom_textField.dart';
import '../../widgets/custom_textField.dart';
import '../home/home_screen.dart';

class Add_Action_Screen extends StatefulWidget {
  const Add_Action_Screen({Key? key}) : super(key: key);

  @override
  _Add_Action_ScreenState createState() => _Add_Action_ScreenState();
}

class _Add_Action_ScreenState extends State<Add_Action_Screen> {
  String title = "";
  String detail = "";
  String reason = "";

  @override
  Widget build(BuildContext context) {
    AddActionManager manager = Provider.of(context).fetch(AddActionManager);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Color(0xffeb5f30),
        flexibleSpace: Overseer.appGradient(),
        actions: [
          Container(
            height: double.infinity,
            width: Get.width * 0.25,
            decoration: BoxDecoration(
                 borderRadius: BorderRadius.circular(5)),
            child: Center(
              child: TextButton(
                onPressed: () {
                  Get.to(HomeScreen());
                },
                child: Text(
                  Overseer.projectName,
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ),
          ),
        ],
        title: const Text(
          "Dev Comment",
          style: TextStyle(fontFamily: 'poppins'),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        leading: Column(
          children: [
            SizedBox(
              height: Get.height * 0.025,
            ),
            const Text(
              "",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.only(left: 20, top: 10, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children:  [
              SizedBox(
                height: 6,
              ),
              Text(
                "Add Comment to User Flow",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'poppins',
                    fontSize: 20),
              ),
              SizedBox(
                height: 6,
              ),
              StreamBuilder<String>(
                stream: manager.title$,
                builder: (context, snapshot) {
                  return CustomTextField(
                      onChanged: (value) {
                        manager.inTitle.add(value);
                      },
                      errortext: snapshot.error == null
                          ? ""
                          : snapshot.error.toString(),
                      textFieldText: 'Title',
                      passwordTxt: false
                  );
                }
              ),
              SizedBox(
                height: 10,
              ),
              StreamBuilder<String>(
                stream: manager.reason$,
                builder: (context, snapshot) {
                  return CustomTextField(
                      onChanged: (value) {
                        manager.inReason.add(value);
                      },
                      errortext: snapshot.error == null
                          ? ""
                          : snapshot.error.toString(),
                      textFieldText: 'Any Reason',
                      passwordTxt: false
                  );
                }
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: 200,
              child: StreamBuilder<String>(
                stream: manager.details$,
                builder: (context, snapshot) {
                  return TextField(
                    maxLines: 10,
                    keyboardType: TextInputType.multiline,
                    cursorColor: Colors.black,
                    onChanged: (value) {
                      manager.inDetails.add(value);
                    },

                    decoration: InputDecoration(
                        errorText: snapshot.error == null
                            ? ""
                            : snapshot.error.toString(),

                        // enabledBorder: OutlineInputBorder(
                        //   borderSide: const BorderSide(
                        //       color: Colors.black, width: 2.0),
                        //   borderRadius: BorderRadius.circular(10.0),
                        // ),
                        // focusedBorder: OutlineInputBorder(
                        //   borderSide: const BorderSide(
                        //       color: Colors.black, width: 2.0),
                        //   borderRadius: BorderRadius.circular(10.0),
                        // ),
                        border: InputBorder.none,
                        labelText: 'Detail',
                        labelStyle: TextStyle(
                          color: Colors.black,
                        )
                        // hintText: 'Enter Your Name',
                        ),

                  );
                }
              )
              ),
              SizedBox(
                height: 20,
              ),
              StreamBuilder<Object>(
                  stream: manager.isFormValidCheck$,
                  builder: (context, snapshot) {
                   //  print("-- testing submit > ${snapshot.hasData}");
                      return InkWell(
                          onTap: () {
                           // title = manager.;
                            print("the real check ${snapshot.hasData}");
                            if(snapshot.hasError){
                              Get.snackbar(
                                "Error",
                                "Get some Error..",
                                dismissDirection: DismissDirection.horizontal,
                                isDismissible: true,
                                backgroundColor: Colors.amber,
                                duration: Duration(seconds: 2),
                              );
                            }else {
                              LogsManager logger = Provider.of(context).fetch(
                                  LogsManager);

                              logger.inLogType.add(Overseer.logKeys[24]);
                              // adding title and description
                              logger.inLogTitle.add(" Added Comment for \" ${manager.title.value} \" For Reason \" ${manager.reason.value} \" "
                                   " Details \" ${manager.details.value} \"  ");
                              logger.inLogDescription.add("Adding Comment.");
                              // adding value for Actor1
                              logger.inLogActor1.add(Overseer.supervisorName);
                              logger.inLogActor1Id.add(Overseer.supervisorId);
                              // adding value for Actor2

                              logger.inLogActor2.add("");
                              logger.inLogActor2Id.add(0);

                              logger.inQuantity.add("");

                              // adding value for Item1
                              logger.inLogItem1.add("");
                              logger.inLogItem1Id.add(0);

                              // adding value for Item2
                              logger.inLogItem2.add(Overseer.projectName);
                              logger.inLogItem2Id.add(Overseer.projectId);

                              logger.logLevel.add(1);

                              print(" Pre call of event ");
                              logger.logger$.listen((event) async {
                                if(snapshot.hasData) {
                                  print(" snapshop data is ${snapshot.data} ");
                                }
                                print(" post call of event ");
                                Get.snackbar("Comment Added",
                                    "You Just added a Comment to this User Flow");

                              });


                          //   Navigator.pop(context);
                            }
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                                // color: Color(0xffeb5f30),
                              gradient: Overseer.gradientBody(),
                                borderRadius: BorderRadius.all(
                                    Radius.circular(10))

                            ),
                            child: Center(
                              child: Text(
                                'Submit', style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'poppins',
                                  fontWeight: FontWeight.w800,
                                  letterSpacing: 1
                              ),
                              ),
                            ),
                          )
                      );

                }
              )],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teamtrack/View/Project/ProjectManager.dart';
import 'package:teamtrack/View/home/home_screen.dart';
import 'package:teamtrack/model/project_model.dart';

import '../../AppLayer/Overseer.dart';
import '../../AppLayer/Provider.dart';

class ProjectScreen extends StatefulWidget {
  const ProjectScreen({Key? key}) : super(key: key);

  @override
  _ProjectScreenState createState() => _ProjectScreenState();
}

class _ProjectScreenState extends State<ProjectScreen> {
  int selected_index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        automaticallyImplyLeading: false,
        flexibleSpace: Overseer.appGradient(),
        title: Text(
          "Project",
          style: TextStyle(fontFamily: 'Poppins', letterSpacing: 1),
        ),
        iconTheme: IconThemeData(color: Colors.white),
        // leading: Container(
        //   height: double.infinity,
        //   width: Get.width * 1.19,
        //   // decoration: BoxDecoration(
        //   //     color: Colors.green, borderRadius: BorderRadius.circular(5)),
        //   child: TextButton(
        //     onPressed: () {
        //       //          removePreviousRollCall();
        //       //          removePreviousEndDay();
        //       //          tabbedIndex = 0;
        //       //          isPresent = true;
        //       setState(() {});
        //     },
        //     child: Center(
        //       child: Text(
        //         "GET",
        //         style: TextStyle(color: Colors.black),
        //       ),
        //     ),
        //   ),
        // ),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Container(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                  child: Text(
                    "Select Project",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w800,
                      fontFamily: 'Poppins',
                      fontSize: 20,
                    ),
                  )),
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: Overseer.myProjects.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              selected_index = index;
                            });
                          },
                          child: Card(
                            child: Container(
                              // height: Get.height * 0.05,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                gradient: selected_index == index
                                    ? Overseer.gradientBody()
                                    : LinearGradient(colors: <Color>[
                                        Colors.white,
                                        Colors.white
                                      ]),
                                // color: selected_index == index
                                //     ? Color(0xffeb5f30).withOpacity(0.3)
                                //     : Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.2),
                                    spreadRadius: 2,
                                    blurRadius: 3,
                                    offset: Offset(
                                        3, 3), // changes position of shadow
                                  ),
                                ],
                              ),
                              child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 10),
                                  child: projectContainer(
                                      titleTxt: Overseer.myProjects[index].name,
                                      sbTitleTxt: Overseer
                                          .myProjects[index].description)),
                            ),
                          ),
                        );
                      })),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: MediaQuery.of(context).size.height * 0.11,
        child: InkWell(
            onTap: () {
              Overseer.firstLoginReq = false;
              Overseer.projectName = Overseer.myProjects[selected_index].name;
              Overseer.project = Overseer.myProjects[selected_index];
              //Overseer.userId = _userList[0].data.id;
//    print("Over seer User ID ${Overseer.userId} Sign In User ID ${_userList[0].data.Projects1.length}");
//    Overseer.userName = _userList[0].data.fName  +" "+ _userList[0].data.lName;
              //  Overseer.supervisorName = _userList[0].data.fName  +" "+ _userList[0].data.lName;
              //  Overseer.supervisorId = _userList[0].data.id;
              Overseer.projectName = Overseer.myProjects[selected_index].name;

              Overseer.projectId = Overseer.myProjects[selected_index].id;
              print(
                  "  Real project name is ---  ${Overseer.projectName}  ----");
              print(" REAL PROJECT ID IS ---  ${Overseer.projectId} ----");
              Overseer.myteamList = Overseer.myProjects[selected_index].team;
              Overseer.myMaterialList =
                  Overseer.myProjects[selected_index].material;
              Overseer.myToolList = Overseer.myProjects[selected_index].tools;
              for (int i = 0; i < Overseer.myToolList.length; i++) {
                print(Overseer.myToolList[i].name);
                print(
                    "--- stock length ${Overseer.myToolList[i].stock.length}");
                for (int y = 0; y < Overseer.myToolList[i].stock.length; y++) {
                  print(
                      "***** Stock entry ${Overseer.myToolList[i].stock[y].quantity} ");
                }
              }
              //Overseer.myProjects = Overseer..Projects1;
              Overseer.myActivities =
                  Overseer.myProjects[selected_index].type.myActivities;
              Overseer.myProjectActicity =
                  Overseer.myProjects[selected_index].type.name;

              ProjectManager projectManager =
                  Provider.of(context).fetch(ProjectManager);
              projectManager.freshProjectData.listen((event) {
                print("overseer team length ${Overseer.myteamList.length}");
                print(
                    "got the freshed team data length ${Overseer.rollCallTeamList.length}");
              });

              Get.offAll(HomeScreen());
            },
            child: Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                        gradient: Overseer.gradientBody(),
                        // color: Color(0xffeb5f30),
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: Center(
                        child: Text(
                      'Select',
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          letterSpacing: 1,
                          fontFamily: 'Poppins'),
                    )),
                  ),
                ))),
      ),
    );
  }

  Widget projectContainer(
      {required String titleTxt, required String sbTitleTxt}) {
    return ListTile(
      title: Text(titleTxt,
          style: TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w900,
              letterSpacing: 1)),
      subtitle: Text(
        sbTitleTxt,
        style: TextStyle(fontFamily: 'Poppins'),
      ),
    );
  }
}

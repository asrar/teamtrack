import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teamtrack/AppLayer/Overseer.dart';
import 'package:teamtrack/Login/sign_in.dart';
import 'package:teamtrack/View/Activities/activities_screen.dart';
import 'package:teamtrack/View/Add_Action/add_action.dart';
import 'package:teamtrack/View/Add_Expanse/add_expanse_screen.dart';
import 'package:teamtrack/View/Project/ProjectManager.dart';
import 'package:teamtrack/View/Project/project_screen.dart';
import 'package:teamtrack/View/Team/team.dart';
import 'package:teamtrack/View/material/material_project.dart';
import 'package:teamtrack/View/tool/tool_project.dart';
import 'package:shared_preferences/shared_preferences.dart';
//import 'package:flutter/tool';
import '../../AppLayer/Provider.dart';
import '../../Login/UserManager.dart';
import '../logs/logsview.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}



Future userLoggedIn(BuildContext context) async {



}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    print("---- projects length in data is >>> ${Overseer.myProjects.length}");
    if(Overseer.myProjects.length==0) {
      print("----- At the moment project 0");
      UserManager manager = Provider.of(context).fetch(UserManager);
      manager.loadProjectsData$.listen((event) async {
      print("print Data Loaded AKS");
      });
    }
    return DefaultTabController(
      length: 2,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            centerTitle: true,
            backgroundColor: Colors.black,
            iconTheme: IconThemeData(color: Colors.white),
            leading: Column(
              children: [

               Padding(padding: EdgeInsets.only(top: 10),
               child: Text(
                     "",
                     style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold ,color: Colors.deepOrange),
                   )) ,
              ],
            ),
            actions: [
              IconButton(
                onPressed: () {
                  Get.offAll(() => SignIn());

                },
                icon: const Icon(Icons.exit_to_app,color: Colors.deepOrange,),
              ),
            ],
            title: const Text("Team Track" ,style: TextStyle(fontSize: 18,
                fontWeight: FontWeight.bold ,color: Colors.deepOrange),),
            bottom: PreferredSize(
                child: Text(Overseer.userName,
                    style: TextStyle(color: Colors.yellow)),
                preferredSize: Size.zero),
          ),



          body: Container(
            height: Get.height * .90 ,
            color: Colors.white,

            child: Column(
              children: [

                Container(

                  padding: EdgeInsets.only(top: 15),
                  decoration: BoxDecoration(color: Colors.black),
                  height: Get.height * 0.15,
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        height: Get.height * 0.060,
                        width: Get.width * 0.85,
                        decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(15)),
                        child: Center(
                          child: TextButton(
                            onPressed: () {
                              Get.to(ProjectScreen());
                            },
                            child: Text(
                              Overseer.projectName == "" || Overseer.firstLoginReq ? "Please Select project" : Overseer.projectName,
                              style: TextStyle(color: Colors.white,
                              fontSize: 15),
                            ),
                          ),
                        ),
                      ),
                    SizedBox(height: 5,),
                      Container(
                        padding: EdgeInsets.all(5),
                        child: LinearProgressIndicator(

                          backgroundColor: Colors.white,
                          value: 0.33,
                          valueColor: AlwaysStoppedAnimation(Colors.green)),)
                      ,
                      Text("Project Progress",
                        style: TextStyle(color: Colors.yellow),

                      ),
                      
                      
                    ],
                  ),
                ),
                const TabBar(

                  tabs: [
                    Tab(
                      child: Text(
                        "Activities",
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                    Tab(
                      child:
                          Text("Logs", style: TextStyle(color: Colors.black)),
                    ),
                  ],
                  // isScrollable: true,
                  indicatorColor: Colors.deepOrange,
                  indicatorWeight: 5,
                ),
                Container(
                  // color: Colors.green,
                  height: Get.height * 0.58,
                  color: Colors.white,

                  child: TabBarView(children: [
                    SingleChildScrollView(
                      child: Column(
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          tabContainer(

                            title: "Team",
                            ontap: () {
                             if(Overseer.firstLoginReq == false) {
                               Get.to(TeamScreen());
                             }
                            },
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          tabContainer(
                            title: "Activities",
                            ontap: () {
    if(Overseer.firstLoginReq == false) {
      Get.to(ActivitiesScreen());
    }
                            },
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          tabContainer(
                            title: "Use Case",
                            ontap: () {
                              ProjectManager projectManager = Provider.of(context).fetch(ProjectManager);
                              projectManager.freshProjectData.listen((event) {

                              });
    if(Overseer.firstLoginReq == false) {
      Get.to(MaterialsProject(title: "Project Material"));
    }
                            },
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          tabContainer(
                            title: "Test Case",
                            ontap: () {
    if(Overseer.firstLoginReq == false) {
      Get.to(ToolsProject(title: "Project Tools"));
    }
                            },
                          ),

                          SizedBox(
                            height: 10,
                          ),
                          tabContainer(
                            title: "Developer Comment",
                            ontap: () {
    if(Overseer.firstLoginReq == false) {
      Get.to(Add_Action_Screen());
    }
                            },
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          tabContainer(
                            title: "Remaining Item",
                            ontap: () {
                              Get.to(AddExpanseScreen());
                            },
                          ),

                        ],
                      ),
                    ),
                    // 2nd tabbar view view
                    logsview(title: "Project Logs",),
                  ]),
                )
              ],
            ),
          ),
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

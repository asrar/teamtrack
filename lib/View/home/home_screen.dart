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
import 'package:teamtrack/View/profile.dart';
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

Future userLoggedIn(BuildContext context) async {}

class _HomeScreenState extends State<HomeScreen> {
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
    print("---- projects length in data is >>> ${Overseer.myProjects.length}");
    if (Overseer.myProjects.length == 0) {
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
          appBar: PreferredSize(
            preferredSize:
            Size.fromHeight(200),
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
                          height: MediaQuery.of(context).size.height * 0.02,
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
                          SizedBox(height: MediaQuery.of(context).size.height*0.07,),
                          tabContainer12(context: context,title: Overseer.userName, ontap: () {}),
                          tabContainer12(context: context,title: Overseer.userPhone, ontap: () {}),
                          tabContainer12(context: context,title: Overseer.userEmail, ontap: () {}),
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
            // height: Get.height * .90,
            color: Colors.white,
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.only(top: 15),
                  decoration: BoxDecoration(

                      gradient: LinearGradient(
                        // begin: Alignment.topCenter,
                        // end: Alignment.bottomCenter,
                          colors: <Color>[Color(0xff5E70D8), Color(0xffCA57E3)]),
                      color: Colors.black),
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
                              Overseer.projectName == "" ||
                                      Overseer.firstLoginReq
                                  ? "Please Select project"
                                  : Overseer.projectName,
                              style:
                                  TextStyle(color: Colors.white, fontSize: 15),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                        padding: EdgeInsets.all(5),
                        child: LinearProgressIndicator(
                            backgroundColor: Colors.white,
                            value: 0.33,
                            valueColor: AlwaysStoppedAnimation(Colors.green)),
                      ),
                      Text(
                        "Project Progress",
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
                  height: Get.height * 0.45,
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
                              if (Overseer.firstLoginReq == false) {
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
                              if (Overseer.firstLoginReq == false) {
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
                              ProjectManager projectManager =
                                  Provider.of(context).fetch(ProjectManager);
                              projectManager.freshProjectData
                                  .listen((event) {});
                              if (Overseer.firstLoginReq == false) {
                                Get.to(MaterialsProject(
                                    title: "Project Material"));
                              }
                            },
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          tabContainer(
                            title: "Test Case",
                            ontap: () {
                              if (Overseer.firstLoginReq == false) {
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
                              if (Overseer.firstLoginReq == false) {
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
                    logsview(
                      title: "Project Logs",
                    ),
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
  Widget tabContainer12({required BuildContext context,required String title, required Function() ontap}) {
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

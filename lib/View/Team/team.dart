import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teamtrack/AppLayer/Overseer.dart';
import 'package:teamtrack/logs/LogsManager.dart';
import 'package:teamtrack/View/Project/ProjectManager.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../AppLayer/Provider.dart';
import '../Project/ProjectManager.dart';
import 'package:teamtrack/View/Project/ProjectManager.dart';
import 'package:scroll_loop_auto_scroll/scroll_loop_auto_scroll.dart';

import '../home/home_screen.dart';

class TeamScreen extends StatefulWidget {
  const TeamScreen({Key? key}) : super(key: key);

  @override
  _TeamScreenState createState() => _TeamScreenState();
}

class _TeamScreenState extends State<TeamScreen> {
  int tabbedIndex = -1;
  bool isPresent = false;
  bool isEndDay = false;
  @override
  Widget build(BuildContext context) {
    LogsManager manager = Provider.of(context).fetch(LogsManager);

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
    Overseer.setTodayDate();
    int hour = new DateTime.now().hour;

    print("need of the hour is ${hour}");
    if(hour==7) {
   //   setTodaysTeamRollCallText();
  //    removePreviousRollCall();
    }
    //setTodaysTeamRollCallText();sia
    validForRollCall();
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Color(0xffeb5f30),
        actions: [
          Container(
            height: Get.height * 0.03,
            width: Get.width * 0.25,
            decoration: BoxDecoration(
                color: Colors.green, borderRadius: BorderRadius.circular(5)),
            child: Center(
              child: TextButton(
                onPressed: () {
                  Get.offAll(HomeScreen());
                },
                child: Text(
                  Overseer.projectName,
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ),
          ),

        ],
        title: Text(
          "Team",
          style: TextStyle(fontFamily: 'poppins'),
        ),
        iconTheme: IconThemeData(color: Colors.white),
        leading: Column(
          children: [
            SizedBox(
              height: Get.height * 0.001,
            ),
            Container(
              height: Get.height * 0.097,
              width: Get.width * 0.99,
              decoration: BoxDecoration(
                  color: Colors.green, borderRadius: BorderRadius.circular(5)),
              child: Padding(
                padding: EdgeInsets.only(bottom: 25),

                child: TextButton(
                  onPressed: () {
          //          removePreviousRollCall();
          //          removePreviousEndDay();
          //          tabbedIndex = 0;
          //          isPresent = true;
                    setState(() {});
                  },
                  child: Text(
                    "SET",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
      body: Container(
        width: double.infinity,
        child: ListView.builder(
            itemCount: Overseer.myteamList.length,
            itemBuilder: (context, index) {
              return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Card(
                          elevation: 5,
                          child: Container(
                            height: Get.height * .26,
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 20),
                            decoration: BoxDecoration(
                              color: Overseer.myteamList[index].roleId
                                      .contains("4")
                                  ? Colors.deepOrangeAccent
                                  : Colors.white,
                            ),
                            child: Row(
                              children: [
                                InkWell(
                                  onTap: () {
                                    Get.back();
                                  },
                                  child: Container(
                                    height: 70,
                                    width: 70,
                                    // color:Colors.green  ,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        image: DecorationImage(
                                          image: AssetImage(
                                              'assets/images/waleed.jpeg'),
                                        )),
                                  ),
                                ),
                                SizedBox(
                                  width: Get.width * 0.05,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      Overseer.myteamList[index].fName +
                                          " " +
                                          Overseer.myteamList[index].lName,
                                      style: TextStyle(
                                          fontFamily: 'poppins',
                                          fontWeight: FontWeight.w900,
                                          letterSpacing: 1),
                                    ),
                                    Text(
                                        Overseer.myteamList[index].roleId
                                                .contains("5")
                                            ? "Worker"
                                            : "SuperVisor",
                                        style: TextStyle(
                                            fontFamily: 'poppins',
                                            letterSpacing: 1)),
                                    SizedBox(
                                      height: 20,
                                    ),
                                     Row(
                                            children: [
                                              Container(
                                                height: Get.height * 0.05,
                                                width: Get.width * 0.25,
                                                decoration: BoxDecoration(
                                                    color: Colors.green,
                                                    borderRadius:
                                                        BorderRadius.circular(5)),
                                                child: Center(
                                                  child: StreamBuilder<Object>(
                                                      stream: manager
                                                          .isRollCallTapped$
                                                          .asStream(),
                                                      builder:
                                                          (context, snapshot) {



                                                        // manager.inLogType.add("leave this");
                                                            print(" index is ${index}--- range error is ${Overseer.rollCallTeamList.length}");





                                                        print("---- real roll call index startrollcall index ${index} length ${Overseer.rollCallTeamList.length}");
                                                        return snapshot.hasData
                                                            ? Overseer.rollCallTeamList[index].startRollCall == null ?
                                                        TextButton(
                                                                onPressed: () async{
                                                                  tabbedIndex = index;
                                                                  print("index is $index");
                                                                  print("tab index is $tabbedIndex");



                                                                  tabbedIndex == index;
                                                                  print(Overseer.myteamList);
                                                                  print("---------<<<${index}>>>>>--------");
                                                                  print(Overseer.teamRollCallTime);


                                                                  Overseer.iSTodayRollCallDone = true;

                                                                //  SharedPreferences prefs = await SharedPreferences.getInstance();
                                                                //  prefs.setInt("",1);


                                                                   tabbedIndex =
                                                                      index;
                                                                  isPresent =
                                                                      false;
                                                                  if (snapshot
                                                                      .hasData) {
                                                                    print("--- adding role call is this ");
                                                                    // adding Type
                                                                    manager.inLogType.add(Overseer.logKeys[15]);
                                                                    // adding title and description
                                                                    manager.inLogTitle.add("Roll Call for ${Overseer.myteamList[tabbedIndex].fName + " " +
                                                                        Overseer.myteamList[tabbedIndex].lName} on ${getToday()}");
                                                                    manager.inLogDescription.add("Adding Roll call.");
                                                                    // adding value for Actor1
                                                                    manager.inLogActor1.add(Overseer.supervisorName);
                                                                    manager.inLogActor1Id.add(Overseer.supervisorId);
                                                                    // adding value for Actor2
                                                                    manager.inLogActor2.add(Overseer.myteamList[tabbedIndex].fName + " " +
                                                                        Overseer.myteamList[tabbedIndex].lName);
                                                                    manager.inLogActor2Id.add(Overseer.myteamList[tabbedIndex].id);
                                                                    manager.inQuantity.add("");

                                                                    // adding value for Item1
                                                                    manager.inLogItem1.add("");
                                                                    manager.inLogItem1Id.add(0);

                                                                    // adding value for Item2
                                                                    manager.inLogItem2.add(Overseer.projectName);
                                                                    manager.inLogItem2Id.add(Overseer.projectId);

                                                                    manager.logLevel.add(1);



                                                                    manager.logger$.listen((event) async {
                                                                      setState(() {
                                                                        print("refreshing screen");
                                                                      });
                                                                      print("actually tapped");
                                                                    });
                                                                  } else {
                                                                    print(
                                                                        "you are late and now allowed now to enter team member Roll Call");
                                                                  }

                                                                  Get.snackbar(
                                                                    "Roll Call Added",
                                                                    "Roll Call Added",
                                                                    dismissDirection: DismissDirection.horizontal,
                                                                    isDismissible: true,
                                                                    backgroundColor: Colors.blue,
                                                                    duration: Duration(seconds: 2),
                                                                  );
                                                                  refresh();


                                                                  //  Get.back();
                                                                },
                                                                child: Text(
                                                                  "Present",
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .white),
                                                                ),
                                                              )
                                                            : Text("${getRollCallTime(Overseer.rollCallTeamList[index].startRollCall!.createdAt!)}"
                                                            ,style: TextStyle(
                                                            color: Colors
                                                            .white),
                                                        )
                                                            : Text(
                                                                "NOT ALLOWED");
                                                      }),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),

                                              ////////  END DAY ----starts

                                              Container(
                                                height: Get.height * 0.05,
                                                width: Get.width * 0.25,
                                                decoration: BoxDecoration(
                                                    color: Colors.red,
                                                    borderRadius:
                                                    BorderRadius.circular(5)),
                                                child: Center(
                                                  child: StreamBuilder<Object>(
                                                      stream: manager
                                                          .isEndDayTapped$
                                                          .asStream(),
                                                      builder:
                                                          (context, snapshot) {



                                                        // manager.inLogType.add("leave this");





                                                            print("----- printing before end button ${Overseer.rollCallTeamList.length}");
                                                        return
                                                          snapshot.hasData
                                                            ? Overseer.rollCallTeamList[index].endRollcall == null ?
                                                        TextButton(
                                                          onPressed: () async{
                                                            tabbedIndex = index;
                                                            print("index is $index");
                                                            print("tab index is $tabbedIndex");
                                                            print(">>>>>>>>>>>>>>>>>>> <<<<<<<<<<<<<<<<<");



                                                            tabbedIndex == index;
                                                            print(Overseer.myteamList);
                                                            print("---------<<<${index}>>>>>--------");
                                                            print(Overseer.teamEndDayTime);

                                                            Overseer.iSTodayEndDayDone = true;

                                                            //  SharedPreferences prefs = await SharedPreferences.getInstance();
                                                            //  prefs.setInt("",1);


                                                            tabbedIndex =
                                                                index;
                                                            isEndDay =
                                                            false;
                                                            if (snapshot
                                                                .hasData) {
                                                              // adding Type
                                                              manager.inLogType.add(Overseer.logKeys[21]);
                                                              // adding title and description
                                                              manager.inLogTitle.add("End Day for ${Overseer.myteamList[tabbedIndex].fName + " " +
                                                                  Overseer.myteamList[tabbedIndex].lName} on ${getToday()}");
                                                              manager.inLogDescription.add("End Day work.");
                                                              // adding value for Actor1
                                                              manager.inLogActor1.add(Overseer.supervisorName);
                                                              manager.inLogActor1Id.add(Overseer.supervisorId);
                                                              // adding value for Actor2
                                                              manager.inLogActor2.add(Overseer.myteamList[tabbedIndex].fName + " " +
                                                                  Overseer.myteamList[tabbedIndex].lName);
                                                              manager.inLogActor2Id.add(Overseer.myteamList[tabbedIndex].id);
                                                              manager.inQuantity.add("");

                                                              // adding value for Item1
                                                              manager.inLogItem1.add("");
                                                              manager.inLogItem1Id.add(0);

                                                              // adding value for Item2
                                                              manager.inLogItem2.add(Overseer.projectName);
                                                              manager.inLogItem2Id.add(Overseer.projectId);

                                                              manager.logLevel.add(1);



                                                              manager.logger$.listen((event) async {
                                                                setState(() {});

                                                                print("actually tapped");
                                                              });
                                                            } else {
                                                              print(
                                                                  "you are late and now allowed now to enter team member Roll Call");
                                                            }

                                                            Get.snackbar(
                                                              "Day Ended",
                                                              "Day Ended",
                                                              dismissDirection: DismissDirection.horizontal,
                                                              isDismissible: true,
                                                              backgroundColor: Colors.blue,
                                                              duration: Duration(seconds: 2),
                                                            );
                                                            refresh();

                                                            //  Get.back();
                                                          },
                                                          child: Text(
                                                            "End Day",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white),
                                                          ),
                                                        )
                                                            : Text("${getRollCallTime(Overseer.rollCallTeamList[index].endRollcall!.createdAt!)}")
                                                            : Text(
                                                            "NOT ALLOWED");
                                                      }),
                                                ),
                                              ),

                                              ///////    -----ends
                                            ],
                                          )
                                  ],
                                )
                              ],
                            ),
                          ))
                    ],
                  ));
            }),
      ),
    );
  }
  String getToday(){
    var now = new DateTime.now();
    var formatter = new DateFormat('yyyy-MM-dd');
    String formattedDate = formatter.format(now);
    return formattedDate;
  }

  String getTime(){
    var now = new DateTime.now();
    var formatter = new DateFormat('hh:mm:ss a ');
    String formattedDate = formatter.format(now);
    return formattedDate;
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
  void setTodaysTeam(String member,int present) async {

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt(member,present);
    Overseer.teamActivityStatus[member] = present;

  }
  void setTodaysEndDayTeam(String member,int present) async {

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt(member,present);
    Overseer.teamEndDayStatus[member] = present;

  }

  void setTodaysTeamTime(String member,String present) async {

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(member,present);
    Overseer.teamRollCallTime[member] = present;

    print("resetting");
    print(Overseer.teamRollCallTime);

  }

  void setTodaysTeamEndDayTime(String member,String present) async {

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(member,present);
    Overseer.teamEndDayTime[member] = present;

    print("resetting");
    print(Overseer.teamEndDayTime);

  }

  void setTodaysTeamRollCallText() async {

    Overseer.TodayRollCallText = getToday();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("today_rollcall",getToday());


  }

  void setTodaysTeamEndDayText() async {

    Overseer.TodayEndDayText = getToday();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("today_endday",getToday());


  }

  Future<bool> validForEndDay() async {

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? todayText = prefs.getString("today_endday");
    print(" endday text (from userpref ) is ${todayText}");
    print(" getToday() is ${getToday()}");
    if(todayText!=null) {
      if (todayText.contains(getToday())) {
        Overseer.iSTodayEndDayDone = true;
        return false;
      }else{
        // removePreviousRollCall();
        Overseer.iSTodayEndDayDone = false;
        return true;
      }
    }

    return false;
  }

  Future<bool> validForRollCall() async {

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? todayText = prefs.getString("today_rollcall");
    print(" todaytext (from userpref ) is ${todayText}");
    print(" getToday() is ${getToday()}");
    if(todayText!=null) {
      if (todayText.contains(getToday())) {
        Overseer.iSTodayRollCallDone = true;
        return false;
      }else{
       // removePreviousRollCall();
        Overseer.iSTodayRollCallDone = false;
        return true;
      }
    }

    return false;
  }


  Future<void> removePreviousRollCall() async {

    for(int i = 0 ; i<= Overseer.teamActivityStatus.length;i++) {
    setTodaysTeam(Overseer.myteamList[i].fName + " " +
        Overseer.myteamList[i].lName+"-"+Overseer.myteamList[i].id.toString(),0);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt(Overseer.myteamList[i].fName + " " +
        Overseer.myteamList[i].lName+"-"+Overseer.myteamList[i].id.toString(), 0);

    setTodaysTeamTime(Overseer.myteamList[i].fName + " " +
        Overseer.myteamList[i].lName+"-"+Overseer.myteamList[i].id.toString(),"0");


  }
  }

  Future<void> removePreviousEndDay() async {

    for(int i = 0 ; i<= Overseer.teamEndDayStatus.length;i++) {


      setTodaysEndDayTeam(Overseer.myteamList[i].fName + " " +
          Overseer.myteamList[i].lName+"-"+Overseer.myteamList[i].id.toString()+"-endday",0);

      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setInt(Overseer.myteamList[i].fName + " " +
          Overseer.myteamList[i].lName+"-"+Overseer.myteamList[i].id.toString()+"-endday", 0);

      setTodaysTeamEndDayTime(Overseer.myteamList[i].fName + " " +
          Overseer.myteamList[i].lName+"-"+Overseer.myteamList[i].id.toString()+"-endday","0");


    }
  }
refresh(){
    setState((){
    });
}

}

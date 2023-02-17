import 'package:get/get.dart';
import 'package:teamtrack/Login/LoginModel.dart';
import 'package:teamtrack/View/home/home_screen.dart';
import 'package:teamtrack/View/material/material_count_grid.dart';
import 'package:teamtrack/View/material/materials_used.dart';
import 'package:teamtrack/model/logsmodel.dart';
import 'package:flutter/material.dart';
import '/View/Project/ProjectModel.dart' as project;
import 'package:teamtrack/View/logs/detail_page.dart';

import '../../AppLayer/Overseer.dart';

class MaterialsProject extends StatefulWidget {
  MaterialsProject({required this.title}) : super();

  final String title;

  @override
  _MaterialsProjectState createState() => _MaterialsProjectState();
}

class _MaterialsProjectState extends State<MaterialsProject> {
  List? lessons;

  @override
  void initState() {
    lessons = getLessons();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("-- old material list count: ${Overseer.myMaterialList.length} ");
    print(
        "-- new project material list count: ${Overseer.myProjectMaterialList.length} ");
    ListTile makeListTile(project.Material material) {
      Overseer.activeMaterialQuantityAndUnit = "";

      for (int i = 0; i < material.stock.length; i++) {
        String unitPackage = "";
        String unitQuantity = "";

        if (material.stock[i].unitpacakge != null) {
          unitPackage = material.stock[i].unitpacakge!.title;
        }
        if (material.stock[i].packageQuantity != null) {
          unitQuantity = material.stock[i].packageQuantity!;
          if (material.stock[i].quantity.trim().contains("-")) {
            unitQuantity = unitQuantity.substring(1);
          } else {
            print("getting returned unit quantity");
            // unitQuantity = material.stock[i].unitQuantity;
          }
        }
        if (material.stock[i].quantity.trim().contains("-")) {
          Overseer.activeMaterialQuantityAndUnit =
              Overseer.activeMaterialQuantityAndUnit +
                  " " +
                  (material.stock[i].quantity).trim().substring(1) +
                  "" +
                  material.unitTitle +
                  " :  ${unitQuantity}${unitPackage} ";
        } else {
          Overseer.activeMaterialQuantityAndUnit =
              Overseer.activeMaterialQuantityAndUnit +
                  "[ Returned: " +
                  (material.stock[i].quantity).trim() +
                  "" +
                  material.unitTitle +
                  " :  ${unitQuantity}${unitPackage} ]";
        }
      }
      print("--quantity---- ${Overseer.activeMaterialQuantityAndUnit}");
      return ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        // leading: Container(
        //   padding: EdgeInsets.only(right: 12.0),
        //   decoration: new BoxDecoration(
        //       border: new Border(
        //           right: new BorderSide(width: 1.0, color: Colors.white24))),
        //   child: Icon(Icons.autorenew, color: Colors.white),
        // ),
        title: Text(
          material.name,
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
        ),
        // subtitle: Text("Intermediate", style: TextStyle(color: Colors.white)),

        subtitle: Row(
          children: <Widget>[
            Expanded(
              flex: 4,
              child: Padding(
                  padding: EdgeInsets.only(left: 10.0),
                  child: Text("${Overseer.activeMaterialQuantityAndUnit}",
                      style: TextStyle(color: Colors.black))),
            )
          ],
        ),
        trailing:
            Icon(Icons.keyboard_arrow_right, color: Colors.black, size: 30.0),
        onTap: () {
          Overseer.activeMaterialQuantityAndUnit = "";
          for (int i = 0; i < material.stock.length; i++) {
            String unitPackage = "";
            String unitQuantity = "";

            if (material.stock[i].unitpacakge != null) {
              unitPackage = material.stock[i].unitpacakge!.title;
            }
            if (material.stock[i].packageQuantity != null) {
              unitQuantity = material.stock[i].packageQuantity!;
              if (material.stock[i].quantity.trim().contains("-")) {
                unitQuantity = unitQuantity.substring(1);
              } else {
                //    unitQuantity = material.stock[i].unit!;
              }
            }
            if (material.stock[i].quantity.trim().contains("-")) {
              Overseer.activeMaterialQuantityAndUnit =
                  Overseer.activeMaterialQuantityAndUnit +
                      " *" +
                      (material.stock[i].quantity).trim().substring(1) +
                      "" +
                      material.unitTitle +
                      " :  ${unitQuantity}${unitPackage}";
            } else {
              Overseer.activeMaterialQuantityAndUnit =
                  Overseer.activeMaterialQuantityAndUnit +
                      " *[Returned: " +
                      (material.stock[i].quantity).trim() +
                      "" +
                      material.unitTitle +
                      " :  ${unitQuantity}${unitPackage}]";
            }
          }

          print(
              "--quantity from cell---- ${Overseer.activeMaterialQuantityAndUnit}");

          Overseer.activeMaterial = material.name;
          Overseer.activeMaterialId = material.id;
          Overseer.activeUnit = material.unitTitle;
          Get.to(MaterialsUsed());
        },
      );
    }

    Card makeCard(project.Material material) {
      return Card(
        elevation: 8.0,
        margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
        child: Container(
          decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(10)),
          child: makeListTile(material),
        ),
      );
    }

    final makeBody = Container(
      // decoration: BoxDecoration(color: Color.fromRGBO(58, 66, 86, 1.0)),
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: Overseer.isMaterialToolRefreshed
            ? Overseer.myProjectMaterialList.length
            : Overseer.myMaterialList.length,
        itemBuilder: (BuildContext context, int index) {
          if (Overseer.isMaterialToolRefreshed) {
            return makeCard(Overseer.myProjectMaterialList[index]);
          } else {
            Overseer.myProjectMaterialList[index] =
                Overseer.myMaterialList[index] as project.Material;
            return makeCard(Overseer.myProjectMaterialList[index]);
          }
        },
      ),
    );

    final makeBottom = Container(
      height: 15.0,
      child: BottomAppBar(
        color: Color.fromRGBO(58, 66, 86, 1.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.home, color: Colors.white),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.blur_on, color: Colors.white),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.hotel, color: Colors.white),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.account_box, color: Colors.white),
              onPressed: () {},
            )
          ],
        ),
      ),
    );
    final topAppBar = AppBar(
      elevation: 0.1,
      backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
      title: Text(widget.title),
      flexibleSpace: Overseer.appGradient(),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.close),
          onPressed: () {
            Get.offAll(HomeScreen());
          },
        )
      ],
      leading: Container(
        height: double.infinity,
        width: Get.width * 1.19,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(5)),
        child: TextButton(
          onPressed: () {
            //          removePreviousRollCall();
            //          removePreviousEndDay();
            //          tabbedIndex = 0;
            //          isPresent = true;
            setState(() {});
          },
          child: Center(
            child: Text(
              "GET",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
    );

    return Scaffold(
      backgroundColor: Color(0xffF6F7FB),
      appBar: topAppBar,
      body: makeBody,
      // bottomNavigationBar: makeBottom,
    );
  }
}

List getLessons() {
  return [
    Lesson(
        title: "Isoflex (White)",
        level: "4 buckets",
        indicatorValue: 0.33,
        price: 20,
        content: "Activity A has been done by team B within time."),
    Lesson(
        title: "Iso Primer",
        level: "10 Buckets",
        indicatorValue: 0.99,
        price: 50,
        content: "Activity A has been done by team B within time...."),
    Lesson(
        title: "FM 16 (Thinner)",
        level: "5 Liters",
        indicatorValue: 0.66,
        price: 30,
        content: "Activity A has been done by team B within time."),
    Lesson(
        title: "TEVO 2010",
        level: "2 Kg",
        indicatorValue: 0.66,
        price: 30,
        content: "Activity A has been done by team B within time.."),
    Lesson(
        title: "Backup Rod 5mm",
        level: "2 Sft",
        indicatorValue: 1.0,
        price: 50,
        content:
            "Start by taking a couple of minutes to read the info in this section. Launch your app and click on the Settings menu.  While on the settings page, click the Save button.  You should see a circular progress indicator display in the middle of the page and the user interface elements cannot be clicked due to the modal barrier that is constructed."),
    Lesson(
        title: "Engine Challenges",
        level: "Advanced",
        indicatorValue: 1.0,
        price: 50,
        content:
            "Start by taking a couple of minutes to read the info in this section. Launch your app and click on the Settings menu.  While on the settings page, click the Save button.  You should see a circular progress indicator display in the middle of the page and the user interface elements cannot be clicked due to the modal barrier that is constructed."),
    Lesson(
        title: "Self Driving Car",
        level: "Advanced",
        indicatorValue: 1.0,
        price: 50,
        content:
            "Start by taking a couple of minutes to read the info in this section. Launch your app and click on the Settings menu.  While on the settings page, click the Save button.  You should see a circular progress indicator display in the middle of the page and the user interface elements cannot be clicked due to the modal barrier that is constructed.  ")
  ];
}

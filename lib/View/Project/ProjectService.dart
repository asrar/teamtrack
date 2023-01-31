import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

import 'package:teamtrack/AppLayer/Overseer.dart';
import 'package:teamtrack/View/Project/ProjectManager.dart';

import '../../util/app_constants.dart';
import 'ProjectModel.dart';

class ProjectService {
  static Future<List<ProjectModel>> refreshProjectData() async {

    List<ProjectModel> refreshedData = List.empty();
    http.Response response;

    String _url = "${AppConstant.baseURL}/supervisor/getproject/${Overseer.projectId}";

    print("Rfresh project data $_url");

    response = await http.post(Uri.parse(_url), headers: {
      'Access-Control-Allow-Origin': '*',
      'Accept': 'application/json',
      'Content-type': 'application/json',
    });

    String content = response.body;
    // Overseer.printWrapped("WRAPPED PRINTING STARTS HERE ------ " + content);
    if (response.statusCode != 200) {

    } else {
      print(
          "########################## not error  but else #####################################");
      var jString = [content];
      //print("printig from service >>> 1-1 done"+jString.toString().substring(jString.toString().lastIndexOf("csrf_token")));

      String arr = jString.toString();
      List collection = json.decode(arr);
      print("status code logine before try"+response.statusCode.toString());
      try {
        print("status code logine inside try"+response.statusCode.toString());
        print("//printig from service >>> ");
        if (response.statusCode != 200) {
          return refreshedData;
        } else {

          List collection = json.decode(arr);
          print("get project data parsing start");
          refreshedData =
          collection.map((json) => ProjectModel.fromJson(json)).toList();

          print("get project data  parisng end from project service");
           Overseer.rollCallTeamList = refreshedData[0].data.team;
          print("--------------- get fresh Team memeber  data ------${Overseer.rollCallTeamList.length}");
          for(int i =0; i<Overseer.rollCallTeamList.length; i++)
          {
            if(Overseer.rollCallTeamList[i].startRollCall != null)
              print("*-* (${Overseer.rollCallTeamList[i].fName}  ${Overseer.rollCallTeamList[i].lName}  ");
          }



           Overseer.myProjectMaterialList = refreshedData[0].data.material;
          Overseer.myProjectToolsList = refreshedData[0].data.tools;
          print("-- new project material count from service: ${Overseer.myProjectMaterialList.length} ");
          Overseer.isMaterialToolRefreshed = true;
        return refreshedData;
        }

        print("end of listen with status " + Overseer.login_status);
      } catch (NoSuchMethodError) {
        return refreshedData;
        print("NoSuchMethodError caught ..hahahaha  ${NoSuchMethodError}");
      }

    } // end of main top if ( does not contain error )
    return refreshedData;
  }

}
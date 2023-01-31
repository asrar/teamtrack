import 'package:teamtrack/View/logs/logsview.dart';
import 'package:teamtrack/View/Project/ProjectModel.dart';
import 'package:teamtrack/View/Project/ProjectService.dart';

import 'package:rxdart/rxdart.dart';
import 'package:flutter/material.dart';
import 'package:teamtrack/AppLayer/Overseer.dart';
import 'dart:async';


class ProjectManager  {

  Stream<List<ProjectModel>> get freshProjectData async* {

    yield await ProjectService.refreshProjectData();
  }


}


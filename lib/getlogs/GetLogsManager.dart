import 'package:teamtrack/View/logs/logsview.dart';
import 'package:teamtrack/getlogs/GetLogsModel.dart';
import 'package:rxdart/rxdart.dart';
import 'package:flutter/material.dart';
import 'package:teamtrack/AppLayer/Overseer.dart';
import 'dart:async';
import 'package:teamtrack/getlogs/GetLogsService.dart';

class GetLogsManager  {

  Stream<List<GetLogsModel>> get logsList async* {

    yield await GetLogsService.log();
  }


}


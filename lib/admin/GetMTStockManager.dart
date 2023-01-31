import 'package:teamtrack/admin/logsview.dart';
import 'package:teamtrack/admin/GetMTStockModel.dart';
import 'package:rxdart/rxdart.dart';
import 'package:flutter/material.dart';
import 'package:teamtrack/AppLayer/Overseer.dart';
import 'dart:async';
import 'package:teamtrack/admin/GetMTStockService.dart';

class GetMTStockManager  {

  Stream<bool> get myList async* {
   print("CALLING MANAGER FOR ADMIN");
    yield await GetMTStockService.getData();
  }
  Stream<List<AdminMaterails>> get myAdminMaterialList async* {
    GetMTStockService.getData();
    yield List<AdminMaterails>.empty();
  }

}


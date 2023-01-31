import 'package:teamtrack/AppLayer/Overseer.dart';
import 'package:flutter/material.dart';
import 'package:teamtrack/AppLayer/Provider.dart';
import 'package:teamtrack/logs/LogsManager.dart';
import 'package:rxdart/rxdart.dart';
import 'dart:async';
import 'Myvalidation.dart';
//import 'UserService.dart';
import 'dart:io';


class AddExpenseManager with Myvalidation {


  final title = BehaviorSubject<String>();
  final reason = BehaviorSubject<String>();
  final cost = BehaviorSubject<int>();
  final details = BehaviorSubject<String>();

  Stream<String> get title$ => title.stream.transform(passwordLength);
  Sink<String> get inTitle => title.sink;

  Stream<int> get cost$ => cost.stream.transform(validCost);
  Sink<int> get inCost => cost.sink;
  
  Stream<String> get reason$ => reason.stream.transform(passwordLength);
  Sink<String> get inReason => reason.sink;

  Stream<String> get details$ => details.stream.transform(passwordLength);
  Sink<String> get inDetails => details.sink;



  Stream<bool> get isFormValidCheck$ {

    if(title.hasValue) {
      print("the real title is _${title.value} ");
    }
    if(reason.hasValue) {
      print("the real reason   is ${reason.value} ");
    }
    if(details.hasValue) {
      print("the real details   is ${details.value} ");
    }
    return CombineLatestStream([title$, reason$,cost$,details$], (values) => true);
  }






// Stream<bool> get isUserAuth$ async* {
//   print("inside isUserAUTH  ");
//   //UserProfileManager manager_user = new UserProfileManager();
//   String query = "email=${title.value}&password=${reason.value}";
//
//   print('query is this ${query}');
// }


}

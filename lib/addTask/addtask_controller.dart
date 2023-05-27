import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:taskmanager/db/database.dart';

import '../models/task.dart';

class AddTaskController extends GetxController {
  void onReady() {
    super.onReady();
  }

  var startTime =
      DateFormat("hh:mm a").format(DateTime.now()).toString().obs as RxString;
  var endTime =
      DateFormat("hh:mm a").format(DateTime.now()).toString().obs as RxString;
  var selectedDate = DateTime.now().obs;
  var selectedRemind = 5.obs;
  var selectedRepeat = "None".obs;
  var selectedColor = 0.obs;
  var taskList = <Task>[].obs;
  var isCompleteText = "".obs;

  Future<int> addTask(Task? task) async {
    return await DBhelper.insert(task);
  }

  void getTask() async {
    List<Map<String, dynamic>> tasks = await DBhelper.query();
    taskList.assignAll(tasks.map((data) => new Task.fromJson(data)).toList());
  }

  void delete(Task task) {
    DBhelper.delete(task);
  }

  void updateisComplete(Task task) {
    DBhelper.update(task.id);
  }
}

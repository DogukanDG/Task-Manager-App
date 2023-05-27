import 'dart:ui';

import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:taskmanager/addTask/addTask.dart';
import 'package:taskmanager/notification_service.dart';

import 'addTask/addtask_controller.dart';
import 'models/task.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  AddTaskController addtaskController = Get.put(AddTaskController());
  var notifyHelper;
  DateTime selectedDate = DateTime.now();
  @override
  void initState() {
    super.initState();
    notifyHelper = NotifyHelper();
    notifyHelper.initializeNotification();
    notifyHelper.requestIOSPermissions();
  }

  @override
  Widget build(BuildContext context) {
    addtaskController.getTask();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: IconButton(
              icon: Icon(Icons.add),
              onPressed: () async {
                await Get.to(AddTask());
                addtaskController.getTask();
              },
            ),
          ),
          /*IconButton(
              onPressed: () {
                showTask();
                addtaskController.getTask();
                print(addtaskController.taskList.length);
              },
              icon: Icon(Icons.add_box))*/
        ],
        leading: Padding(
          padding: EdgeInsets.only(left: 16),
          child: CircleAvatar(
            radius: 2,
            backgroundImage: AssetImage("assets/images/images.png"),
          ),
        ),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 16, right: 16, top: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Today",
                      style: GoogleFonts.lato(
                          fontSize: 20, fontWeight: FontWeight.bold)),
                  Text(
                    "${DateFormat("MMMM d,y").format(DateTime.now())}",
                    style:
                        GoogleFonts.lato(fontSize: 20, color: Colors.grey[500]),
                  ),
                ],
              ),
            ),
            timepicker(),
            showTask(),
            /* Expanded(
              child: Padding(
                padding: EdgeInsets.only(left: 16, right: 16, top: 15),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.red),
                  height: 200,
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 16, top: 10, right: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Title",
                              style:
                                  TextStyle(fontSize: 18, color: Colors.white),
                            ),
                            Text(
                              "22/08/2022",
                              style:
                                  TextStyle(fontSize: 18, color: Colors.white),
                            )
                          ],
                        ),
                      ),
                      Container(
                        height: 2,
                        color: Colors.white,
                        width: double.infinity,
                      ),
                      Container(
                          padding: EdgeInsets.only(left: 16, top: 5, right: 16),
                          child: Text(
                            "this is my note,this is my note,this is my note,this is my note,this is my note,this is my note,this is my notethis is my note,this is my notethis is my note,this is my note,this is my note",
                            style: TextStyle(color: Colors.white, fontSize: 15),
                          ))
                    ],
                  ),
                ),
              ),
            ),*/
          ],
        ),
      ),
    );
  }

  showTask() {
    return Expanded(
      child: Obx(
        () => ListView.builder(
          itemCount: addtaskController.taskList.length,
          itemBuilder: (context, index) {
            Task task = addtaskController.taskList[index];
            if (task.repeat == 'Daily') {
              DateTime date = DateFormat.jm().parse(task.startTime.toString());
              var myTime = DateFormat("HH:mm").format(date);
              notifyHelper.scheduledNotification(
                  int.parse(myTime.toString().split(":")[0]),
                  int.parse(myTime.toString().split(":")[1]),
                  task);
              return GestureDetector(
                onTap: () {
                  bottomSheet(context, addtaskController.taskList[index]);
                  //addtaskController.delete(addtaskController.taskList[index]);
                  addtaskController.getTask();
                  print(task.date);
                  print(selectedDate);
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: addtaskController.taskList[index].color == 0
                        ? Colors.red
                        : addtaskController.taskList[index].color == 1
                            ? Color(0xff293462)
                            : addtaskController.taskList[index].color == 2
                                ? Color(0xff5BB318)
                                : addtaskController.taskList[index].color == 3
                                    ? Colors.orange
                                    : addtaskController.taskList[index].color ==
                                            4
                                        ? Color(0xff3E00FF)
                                        : Colors.white,
                  ),
                  margin: EdgeInsets.only(top: 10, right: 16, left: 16),
                  width: double.infinity,
                  height: Get.height / 5,
                  child: Padding(
                    padding: EdgeInsets.only(left: 16, right: 16, top: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "${addtaskController.taskList[index].title}",
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text("${DateFormat.yMd().format(selectedDate)}",
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.white,
                                )),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          height: 50,
                          child: Text(
                            "${addtaskController.taskList[index].note}",
                            style: GoogleFonts.lato(color: Colors.white),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.watch_later_outlined,
                                  color: Colors.white,
                                  size: 20,
                                ),
                                SizedBox(
                                  width: 4,
                                ),
                                Text(
                                  "${addtaskController.taskList[index].startTime} -" +
                                      " ${addtaskController.taskList[index].endTime}",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                            Obx(
                              () => Container(
                                child: addtaskController
                                            .taskList[index].isCompleted ==
                                        1
                                    ? Text(
                                        "Complete",
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      )
                                    : Text(
                                        "Not Complete",
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }
            if (task.repeat == 'Weekly') {
              if (DateFormat.yMd().parse(task.date.toString()) ==
                  DateFormat.yMd()
                      .format(selectedDate.add(Duration(days: 7)))) {
                return GestureDetector(
                  onTap: () {
                    bottomSheet(context, addtaskController.taskList[index]);
                    //addtaskController.delete(addtaskController.taskList[index]);
                    addtaskController.getTask();
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: addtaskController.taskList[index].color == 0
                          ? Colors.red
                          : addtaskController.taskList[index].color == 1
                              ? Color(0xff293462)
                              : addtaskController.taskList[index].color == 2
                                  ? Color(0xff5BB318)
                                  : addtaskController.taskList[index].color == 3
                                      ? Colors.orange
                                      : addtaskController
                                                  .taskList[index].color ==
                                              4
                                          ? Color(0xff3E00FF)
                                          : Colors.white,
                    ),
                    margin: EdgeInsets.only(top: 10, right: 16, left: 16),
                    width: double.infinity,
                    height: Get.height / 5,
                    child: Padding(
                      padding: EdgeInsets.only(left: 16, right: 16, top: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "${addtaskController.taskList[index].title}",
                                style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text("${DateFormat.yMd().format(selectedDate)}",
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: Colors.white,
                                  ))
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            height: 50,
                            child: Text(
                              "${addtaskController.taskList[index].note}" +
                                  "${addtaskController.taskList[index].isCompleted}",
                              style: GoogleFonts.lato(color: Colors.white),
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.watch_later_outlined,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                  SizedBox(
                                    width: 4,
                                  ),
                                  Text(
                                    "${addtaskController.taskList[index].startTime} -" +
                                        " ${addtaskController.taskList[index].endTime}",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ],
                              ),
                              Obx(
                                () => Container(
                                  child: addtaskController
                                              .taskList[index].isCompleted ==
                                          1
                                      ? Text(
                                          "Complete",
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        )
                                      : Text(
                                          "Not Complete",
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        ),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                );
              }
            }
            if (task.date == DateFormat.yMd().format(selectedDate)) {
              return GestureDetector(
                onTap: () {
                  bottomSheet(context, addtaskController.taskList[index]);
                  //addtaskController.delete(addtaskController.taskList[index]);
                  addtaskController.getTask();
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: addtaskController.taskList[index].color == 0
                        ? Colors.red
                        : addtaskController.taskList[index].color == 1
                            ? Color(0xff293462)
                            : addtaskController.taskList[index].color == 2
                                ? Color(0xff5BB318)
                                : addtaskController.taskList[index].color == 3
                                    ? Colors.orange
                                    : addtaskController.taskList[index].color ==
                                            4
                                        ? Color(0xff3E00FF)
                                        : Colors.white,
                  ),
                  margin: EdgeInsets.only(top: 10, right: 16, left: 16),
                  width: double.infinity,
                  height: Get.height / 5,
                  child: Padding(
                    padding: EdgeInsets.only(left: 16, right: 16, top: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "${addtaskController.taskList[index].title}",
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text("${DateFormat.yMd().format(selectedDate)}",
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.white,
                                ))
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          height: 50,
                          child: Text(
                            "${addtaskController.taskList[index].note}",
                            style: GoogleFonts.lato(color: Colors.white),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.watch_later_outlined,
                                  color: Colors.white,
                                  size: 20,
                                ),
                                SizedBox(
                                  width: 4,
                                ),
                                Text(
                                  "${addtaskController.taskList[index].startTime} -" +
                                      " ${addtaskController.taskList[index].endTime}",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                            Obx(
                              () => Container(
                                child: addtaskController
                                            .taskList[index].isCompleted ==
                                        1
                                    ? Text(
                                        "Complete",
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      )
                                    : Text(
                                        "Not Complete",
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              );
            } else
              return Container();
          },
        ),
      ),
    );
  }

  Widget timepicker() {
    return Padding(
      padding: EdgeInsets.only(top: 10, left: 16),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            border: Border.all(color: Colors.black),
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10), bottomLeft: Radius.circular(10))),
        child: DatePicker(DateTime.now(),
            height: 100,
            width: 80,
            initialSelectedDate: DateTime.now(),
            selectionColor: Color(0xff293462), onDateChange: (time) {
          selectedDate = time;
          addtaskController.getTask();
          print(selectedDate);
        }),
      ),
    );
  }

  Container bottomSheetContainer(Color color, String text) {
    return Container(
      margin: EdgeInsets.only(left: 16, right: 16),
      height: 45,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: color,
      ),
      child: Center(
        child: Text(
          text,
          style: TextStyle(
              color: Colors.white, fontSize: 17, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  bottomSheet(BuildContext context, Task task) {
    Get.bottomSheet(Container(
      color: Colors.white,
      height: Get.height / 3,
      child: Column(
        children: [
          SizedBox(
            height: 50,
          ),
          GestureDetector(
              onTap: () {
                addtaskController.updateisComplete(task);
                addtaskController.getTask();
                Get.back();
              },
              child: task.isCompleted == 1
                  ? Container()
                  : task.isCompleted == 0
                      ? bottomSheetContainer(
                          Color(0xff5463FF), "Task Completed")
                      : Container()),
          SizedBox(
            height: 10,
          ),
          GestureDetector(
            onTap: () {
              addtaskController.delete(task);
              addtaskController.getTask();
              Get.back();
            },
            child: bottomSheetContainer(Color(0xffFF5959), "Delete"),
          ),
          SizedBox(
            height: 30,
          ),
          GestureDetector(
              onTap: () {
                Get.back();
              },
              child: Container(
                margin: EdgeInsets.only(left: 16, right: 16),
                height: 45,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                ),
                child: Center(
                  child: Text(
                    "Close",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 17,
                    ),
                  ),
                ),
              )),
        ],
      ),
    ));
  }
}

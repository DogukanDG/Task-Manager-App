import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:taskmanager/addTask/addtask_controller.dart';
import 'package:taskmanager/input_field.dart';

import '../models/task.dart';

class AddTask extends StatefulWidget {
  const AddTask({Key? key}) : super(key: key);

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  TextEditingController titleController = TextEditingController();
  TextEditingController noteController = TextEditingController();

  List<String> repeatList = ["None", "Daily"];
  AddTaskController taskController = Get.put(AddTaskController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(left: 16, right: 16, top: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Add task",
                style:
                    GoogleFonts.lato(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              inputField(
                title: "Title",
                hint: "Enter title here",
                editingController: titleController,
              ),
              inputField(
                title: "Note",
                hint: "Enter your note here",
                editingController: noteController,
              ),
              inputField(
                title: "Date",
                hint: DateFormat('d MMMM yyy')
                    .format(taskController.selectedDate.value),
                widget: IconButton(
                  onPressed: () async {
                    taskController.selectedDate.value = await showDatePicker(
                          context: context,
                          initialDate: taskController.selectedDate.value,
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2100),
                        ) ??
                        taskController.selectedDate.value;
                  },
                  icon: Icon(
                    Icons.date_range,
                    color: Colors.blue,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width / 2.4,
                    child: inputField(
                      title: "Start Time",
                      hint: taskController.startTime.value,
                      widget: IconButton(
                          onPressed: () async {
                            await getTimeFromUser(true);
                          },
                          icon: Icon(
                            Icons.access_alarm_sharp,
                            color: Colors.blue,
                          )),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width / 2.4,
                    child: inputField(
                      title: "End Time",
                      hint: taskController.endTime.value,
                      widget: IconButton(
                        onPressed: () async {
                          await getTimeFromUser(false);
                        },
                        icon: Icon(
                          Icons.access_alarm_sharp,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              /*Obx(() => inputField(
                  title: "Remind",
                  hint:
                      "${taskController.selectedRemind.value} minutes earlier",
                  widget: DropdownButton(
                    underline: Container(
                      height: 0,
                    ),
                    iconEnabledColor: Colors.blue,
                    iconSize: 32,
                    elevation: 4,
                    value: taskController.selectedRemind.value,
                    items: [5, 10, 15, 20]
                        .map((e) => DropdownMenuItem(
                              child: Text(e.toString()),
                              value: e,
                            ))
                        .toList(),
                    onChanged: (val) {
                      taskController.selectedRemind.value =
                          int.parse(val.toString());
                      //print(ekstreaddPageController.type.value);
                      print(taskController.selectedRemind.value);
                    },
                    autofocus: true,
                  ))),*/
              Obx(() => inputField(
                  title: "Repeat",
                  hint: "${taskController.selectedRepeat.value}",
                  widget: DropdownButton(
                    underline: Container(
                      height: 0,
                    ),
                    iconEnabledColor: Colors.blue,
                    iconSize: 32,
                    elevation: 4,
                    value: taskController.selectedRepeat.value,
                    items: ["None", "Daily"]
                        .map((e) => DropdownMenuItem(
                              child: Text(e),
                              value: e,
                            ))
                        .toList(),
                    onChanged: (val) {
                      taskController.selectedRepeat.value = val.toString();
                      print(taskController.selectedRepeat.value);
                    },
                  ))),
              SizedBox(
                height: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Color",
                    style: GoogleFonts.lato(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Wrap(
                        spacing: 4,
                        children: List<Widget>.generate(
                          5,
                          (int index) => GestureDetector(
                            onTap: () {
                              if (index == 0) {
                                taskController.selectedColor.value = 0;
                              } else if (index == 1) {
                                taskController.selectedColor.value = 1;
                              } else if (index == 2) {
                                taskController.selectedColor.value = 2;
                              } else if (index == 3) {
                                taskController.selectedColor.value = 3;
                              } else if (index == 4) {
                                taskController.selectedColor.value = 4;
                              }
                              print(taskController.selectedColor.value);
                            },
                            child: Obx(() => CircleAvatar(
                                  backgroundColor: index == 0
                                      ? Colors.red
                                      : index == 1
                                          ? Color(0xff293462)
                                          : index == 2
                                              ? Color(0xff5BB318)
                                              : index == 3
                                                  ? Colors.orange
                                                  : index == 4
                                                      ? Color(0xff3E00FF)
                                                      : Colors.white,
                                  child: taskController.selectedColor.value ==
                                          index
                                      ? Icon(
                                          Icons.done,
                                          color: Colors.white,
                                          size: 15,
                                        )
                                      : Container(),
                                  radius: 14,
                                )),
                          ),
                        ),
                      ),
                      ElevatedButton(
                          onPressed: () {
                            if (titleController.text.isNotEmpty &&
                                noteController.text.isNotEmpty) {
                              addTasktoDatabase();
                              Get.back();
                            } else if (titleController.text.isEmpty &&
                                noteController.text.isEmpty) {
                              Get.snackbar(
                                icon: Icon(Icons.warning_amber),
                                snackPosition: SnackPosition.BOTTOM,
                                backgroundColor: Colors.white,
                                "Error",
                                "Please fill the Title and Note",
                              );
                            }
                          },
                          child: Text("Add"))
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  getTimeFromUser(@required isStartTime) async {
    var pickedTime = await showTimePicker(
        context: context,
        initialEntryMode: TimePickerEntryMode.input,
        initialTime: TimeOfDay(
            hour: int.parse(taskController.startTime.split(":")[0]),
            minute: int.parse(
                taskController.startTime.split(":")[1].split(" ")[0])));
    String formatedTime = pickedTime!.format(context);
    if (isStartTime == null) {
      print("Time canceled");
    } else if (isStartTime == true) {
      taskController.startTime.value = formatedTime.toString();
    } else if (isStartTime == false) {
      taskController.endTime.value = formatedTime.toString();
    }
    print(taskController.startTime);
    print(taskController.endTime);
  }

  addTasktoDatabase() async {
    int value = await taskController.addTask(Task(
      note: noteController.text,
      title: titleController.text,
      date: DateFormat.yMd().format(taskController.selectedDate.value),
      color: taskController.selectedColor.value,
      endTime: taskController.endTime.value,
      startTime: taskController.startTime.value,
      remind: taskController.selectedRemind.value,
      repeat: taskController.selectedRepeat.value,
      isCompleted: 0,
    ));
    print("my id is $value");
  }
}

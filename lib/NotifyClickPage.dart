import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class NotifyClick extends StatelessWidget {
  final String payload;
  const NotifyClick(
    this.payload, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(Icons.arrow_back),
        ),
        title: Text("${this.payload.toString().split(".")[0]}"),
      ),
      body: Center(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.blue,
          ),
          height: 300,
          width: 400,
          child: Center(
              child: Text("${this.payload.toString().split(".")[1]}",
                  style: TextStyle(fontSize: 20, color: Colors.white))),
        ),
      ),
    );
  }
}

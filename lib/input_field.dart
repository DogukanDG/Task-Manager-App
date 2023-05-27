import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class inputField extends StatelessWidget {
  final String title;
  final String hint;
  final TextEditingController? editingController;
  final Widget? widget;
  const inputField({
    Key? key,
    required this.title,
    required this.hint,
    this.editingController,
    this.widget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(top: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style:
                  GoogleFonts.lato(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Container(
              margin: EdgeInsets.only(top: 10),
              height: 52,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey, width: 1)),
              child: Padding(
                padding: EdgeInsets.only(left: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: editingController,
                        readOnly: widget == null ? false : true,
                        cursorColor: Colors.black,
                        autofocus: false,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: hint,
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white))),
                      ),
                    ),
                    widget == null
                        ? Container()
                        : Container(
                            child: widget,
                          ),
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}

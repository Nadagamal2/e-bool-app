import 'package:e_book/utils/app_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

Widget myDivider() => Padding(
  padding: const EdgeInsetsDirectional.only(
    start: 15.0,
    end: 15.0,
  ),
  child: Container(
    width: double.infinity,
    height: .2,
    color: Colors.grey[300],
  ),
);

void navigateTo(context,Widget)=> Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context)=> Widget,
  ),
);
void showToast({required String message}){
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: Styles.secondryColor,
      textColor: Styles.backgroudColor,
      fontSize: 16.0
  );
}
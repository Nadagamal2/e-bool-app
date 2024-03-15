import 'package:e_book/utils/app_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PdfScreen extends StatelessWidget {
  String pdf;
    PdfScreen({Key? key,required this.pdf}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 65.h,
        elevation: 0,
        backgroundColor:Colors.red,


        centerTitle: true,
        title: Text(
          "PDF Reader",
          style: TextStyle(
              fontSize: 20.sp,
              color: Styles.fontColor,
              fontWeight: FontWeight.w500
          ),
        ),
      ),
      body:SfPdfViewer.network(pdf),
    );
  }
}

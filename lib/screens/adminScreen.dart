import 'package:animate_do/animate_do.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_book/screens/pdf_reader.dart';
import 'package:e_book/screens/setting_screen.dart';
import 'package:e_book/screens/update_data.dart';
import 'package:e_book/utils/component.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import '../utils/app_style.dart';
import 'add_books.dart';

class AdminScreen extends StatelessWidget {
  const AdminScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Styles.backgroudColor,
      appBar: AppBar(
        toolbarHeight: 65.h,
        elevation: 0,
        backgroundColor: Styles.backgroudColor,
        centerTitle: true,
        actions: [

          InkWell(
              onTap: () {
               navigateTo(context, SettingScreen());
              },
              child: Icon(
                Icons.settings,
                color: Styles.fontColor
                ,
                size: 25.sp,
              )),
          Gap(15.h),
        ],

        title: Text(
          "My Books",
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.w500
          ),
        ),
      ),
        floatingActionButton: new FloatingActionButton(
            elevation: 0.0,
            child: new Icon(Icons.add,color: Styles.backgroudColor,),
            backgroundColor: Styles.defualtColor,
            onPressed: (){
              navigateTo(context, AddBooks());
            }
        ),
      body: Column(
        children: [
          Divider(),
          StreamBuilder<QuerySnapshot>(
              stream:
              FirebaseFirestore.instance.collection('books').snapshots(),
              builder: (context, snapshot) {
                List<Widget> bookWidgets = [];
                if (snapshot.hasData) {
                  final books = snapshot.data!.docs.reversed.toList();
                  for (var book in books) {
                    final bookWidget = Padding(
                      padding:   EdgeInsets.symmetric(horizontal: 15.h,vertical: 10.h),
                      child: Container(
                        padding: EdgeInsets.all(10.h),


                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Styles.primaryColor2,
                          borderRadius: BorderRadius.circular(15.r),

                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            InkWell(
                              onTap:(){
                                navigateTo(context, PdfScreen(pdf: '${book['pdf']}',));
                                print('object');



                              },
                              child: Row(

                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Image(image: NetworkImage('${book['image']}'),height: 120.h,width: 100.h,fit: BoxFit.fill,),
                                  Gap(5.h),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('Author Name :',style: TextStyle(
                                          fontWeight: FontWeight.w600
                                      ),),
                                      SizedBox(
                                          width: 100.h,
                                          child: Text(book['author'])),
                                      Gap(5.h),
                                      Text('Title :',style: TextStyle(
                                        fontWeight: FontWeight.w600
                                      ),),
                                      SizedBox(
                                          width: 100.h,
                                          child: Text(book['title'])),
                                    ],
                                  ),

                                  //Text(client['password']),
                                ],
                              ),
                            ),
                            Column(
                              children: [
                                IconButton(onPressed: (){

                                  navigateTo(context, UpdateBooks());

                                }, icon: Icon(Icons.edit,color: Styles.defualtColor,size: 20.sp,)),
                                IconButton(onPressed: (){
                                  final coll = FirebaseFirestore
                                      .instance
                                      .collection('books').doc('test');

                                 coll.delete();

                                  showToast(message: 'Deleted Successfully');

                                }, icon: Icon(Icons.delete,color: Styles.defualtColor,size: 20.sp))
                              ],
                            )
                          ],
                        ),
                      ),
                    );
                    bookWidgets.add(bookWidget);

                  }
                }

                return Expanded(
                  child: FadeInRight(
                    child: ListView(
                      padding: EdgeInsets.all(5.h),
                      physics: BouncingScrollPhysics(),
                      children: bookWidgets,
                    ),
                  ),
                );
              }
          ),



        ],
      ),
    );
  }

}

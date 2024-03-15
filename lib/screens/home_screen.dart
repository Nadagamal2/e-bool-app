

import 'package:animate_do/animate_do.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_book/screens/login_screen.dart';
import 'package:e_book/screens/pdf_reader.dart';
import 'package:e_book/screens/setting_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

 import '../utils/CategoryWidget.dart';
import '../utils/Data.dart';
import '../utils/app_style.dart';
import '../utils/component.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100.h,
        elevation: 0,
        backgroundColor: Styles.defualtColor,
        shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
        bottom: Radius.circular(30),
    ),),
        actions: [

          InkWell(
              onTap: () {
                showDialog(
                  context: context,
                  builder:(context)=>AlertDialog(
                    title: Text("Logout",  style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600
                      ,color: Styles.defualtColor,
                    ),),
                    content: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text( "Are you sure to leave ?",
                          style: TextStyle(
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w500
                          ),
                        ),
                        const SizedBox(height: 32,),

                      ],

                    ),
                    actions: [
                      TextButton(onPressed: ()=>  Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                          SignIn()), (Route<dynamic> route) => false), child: Text(
                        "Ok",
                        style: TextStyle(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w500,
                            color: Styles.defualtColor
                        ),
                      )),
                      TextButton(onPressed: ()=>Navigator.pop(context), child: Text(
                        "Cancel",style: TextStyle(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w500,
                          color: Styles.defualtColor
                      ),
                      )),
                    ],

                  ),
                );
              },
              child: Icon(
                Icons.logout,
                color: Styles.backgroudColor
                ,
                size: 25.sp,
              )),
          Gap(15.h),
        ],
      //  centerTitle: true,
        title: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Welcome !",
              style: TextStyle(
                  fontSize: 25.sp,
                  color: Styles.backgroudColor,

                  fontWeight: FontWeight.w500
              ),
            ),
            Text(
              "Discover your favorite book",
              style: TextStyle(
                  fontSize: 20.sp,
                  color: Styles.backgroudColor,
                  fontWeight: FontWeight.w500
              ),
            ),
          ],
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
         
          Gap(15.h),
          SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            child: Row(
              children: categoryData
                  .map(
                    (e) => CategoryWidget(
                    iconPath: e["icon"]!,
                    btnName: e["lebel"]!),
              )
                  .toList(),
            ),
          ),
          Gap(20.h),

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
                        child: InkWell(
                          onTap: (){
                            navigateTo(context, PdfScreen(pdf: '${book['pdf']}',));
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

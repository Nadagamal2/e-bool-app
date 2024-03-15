import 'package:animate_do/animate_do.dart';
import 'package:e_book/utils/app_style.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

import '../all_users.dart';
import '../utils/component.dart';
import 'login_screen.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Styles.backgroudColor,
      appBar: AppBar(
        toolbarHeight: 65.h,
        elevation: 0,
        backgroundColor: Styles.backgroudColor,


        centerTitle: true,
        title: Text(
          "Settings",
          style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.w500
          ),
        ),
      ),
      body: FadeInRight(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Divider(),
            Gap(20.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.h),
              child: Column(
                children: [
                  InkWell(
                    onTap: () {
                      navigateTo(context, AllUsers());
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Styles.primaryColor2,
                        borderRadius: BorderRadius.circular(15.h),
                      ),
                      padding: EdgeInsets.all(10.h),
                      child: Row(
                        children: [
                          Icon(
                            Icons.group,
                            color: Styles.defualtColor,
                          ),
                          Gap(20.h),
                          Text(
                            'All Users',
                            style: TextStyle(
                              fontSize: 15.sp,
                              color: Styles.fontColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Gap(15.h),
                  Gap(15.h),
                  SizedBox(
                    width: double.infinity,
                    height: 40.h,
                    child: ElevatedButton(
                      onPressed: () {
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
                      child: Text(
                        'Log Out',
                        style: TextStyle(
                          color: Styles.backgroudColor,
                          fontSize: 16.sp,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Styles.defualtColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.r),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

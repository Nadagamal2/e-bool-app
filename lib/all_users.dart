import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_book/utils/app_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class AllUsers extends StatelessWidget {
  const AllUsers({Key? key}) : super(key: key);

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
          "All Users",
          style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w500),
        ),
      ),
      body: Column(
        children: [
          Divider(),
          StreamBuilder<QuerySnapshot>(
              stream:
              FirebaseFirestore.instance.collection('users').snapshots(),
              builder: (context, snapshot) {
                List<Widget> clientWidgets = [];
                if (snapshot.hasData) {
                  final clients = snapshot.data!.docs.reversed.toList();
                  for (var client in clients) {
                    final clientWidget = Padding(
                      padding:   EdgeInsets.symmetric(horizontal: 15.h,vertical: 10.h),
                      child: Container(
                        padding: EdgeInsets.all(10.h),

                        height: 50.h,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Styles.primaryColor2,
                          borderRadius: BorderRadius.circular(15.r),

                        ),
                        child: Row(

                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(Icons.person,color: Styles.defualtColor,size: 40.sp,),
                                Gap(10.h),
                                Text(client['name']),
                              ],
                            ),
                            Text(client['email']),
                            //Text(client['password']),
                          ],
                        ),
                      ),
                    );
                    clientWidgets.add(clientWidget);

                  }
                }

                return Expanded(
                  child: ListView(
                    children: clientWidgets,
                  ),
                );
              }
          )
        ],
      ),
    );
  }
}

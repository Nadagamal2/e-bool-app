import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../utils/app_style.dart';

class CategoryWidget extends StatelessWidget {
  final String iconPath;
  final String btnName;
  const CategoryWidget(
      {super.key, required this.iconPath, required this.btnName});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:   EdgeInsets.only(right: 10.h,left: 10.h),
      child: InkWell(
        onTap: () {},
        child: Container(
          padding:   EdgeInsets.symmetric(horizontal: 20.h, vertical: 15.h),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.r),
              color: Styles.primaryColor2),
          child: Row(
            children: [
              SvgPicture.asset(iconPath,fit: BoxFit.fill,),
              const SizedBox(width: 10),
              Text(btnName),
            ],
          ),
        ),
      ),
    );
  }
}

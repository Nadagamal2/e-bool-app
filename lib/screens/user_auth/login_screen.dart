import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:e_book/screens/signUp_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gap/gap.dart';


import '../user_auth/firebase_auth_implementation/firebase_auth_services.dart';
import '../utils/app_style.dart';
import '../utils/component.dart';
import 'adminScreen.dart';
import 'home_screen.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  bool _isSigning = false;

  final FirebaseAuthService _auth = FirebaseAuthService();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final emailController = new TextEditingController();
  final passwordController = new TextEditingController();

  void dispose() {
    emailController.dispose();
    passwordController.dispose();

    super.dispose();
  }

  var formKey = GlobalKey<FormState>();


  bool isLogin = false;
  bool isVisible = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.h),
                  child: Column(
                    children: [
                      Gap(30.h),
                      Image(
                        image: AssetImage(
                          'assets/book.png',
                        ),
                        height: 200.h,
                        width: 220.h,
                      ),
                      Text(
                        'LogIn',
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 20.sp),
                      ),
                      Gap(15.h),
                      Column(
                        children: [
                          Form(
                            key: formKey,
                            child: Column(
                              children: [
                                TextFormField(
                                  validator: (String? val) {
                                    if (val!.isEmpty) {
                                      return 'Please enter your email';
                                    }
                                    return null;
                                  },
                                  controller: emailController,
                                  cursorColor: Styles.primaryColor,
                                  keyboardType: TextInputType.emailAddress,
                                  decoration: InputDecoration(
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.never,
                                    contentPadding: EdgeInsets.symmetric(
                                        vertical: 10.h, horizontal: 10.h),
                                    filled: true,
                                    fillColor: Styles.primaryColor2,
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          width: .1.r,
                                          color: Colors.transparent),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    border: const OutlineInputBorder(),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          width: .1.r,
                                          color: Colors.transparent),
                                      borderRadius: BorderRadius.circular(10.r),
                                    ),
                                    labelText: 'Email Address',
                                    hintText: 'Email Address',
                                    labelStyle: TextStyle(
                                        fontSize: 13.sp,
                                        color: Styles.primaryColor),
                                    hintStyle: TextStyle(
                                        fontSize: 13.sp,
                                        color: Styles.primaryColor),
                                  ),
                                ),
                                Gap(10.h),
                                TextFormField(
                                  obscureText: isVisible,
                                  validator: (String? val) {
                                    if (val!.isEmpty) {
                                      return 'Please enter your password';
                                    }
                                    return null;
                                  },
                                  controller: passwordController,
                                  cursorColor: Styles.primaryColor,
                                  keyboardType: TextInputType.visiblePassword,
                                  decoration: InputDecoration(
                                    suffixIcon: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          isVisible = !isVisible;
                                        });
                                      },
                                      child: isVisible == true
                                          ? const Icon(Icons.visibility)
                                          : Icon(Icons.visibility_off,
                                              color: Styles.defualtColor),
                                    ),
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.never,
                                    contentPadding: EdgeInsets.symmetric(
                                        vertical: 3.h, horizontal: 10.h),
                                    filled: true,
                                    fillColor: Styles.primaryColor2,
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          width: .1.r,
                                          color: Colors.transparent),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    border: const OutlineInputBorder(),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          width: .1.r,
                                          color: Colors.transparent),
                                      borderRadius: BorderRadius.circular(10.r),
                                    ),
                                    labelText: 'Password',
                                    hintText: 'Password',
                                    labelStyle: TextStyle(
                                        fontSize: 13.sp,
                                        color: Styles.primaryColor),
                                    hintStyle: TextStyle(
                                        fontSize: 13.sp,
                                        color: Styles.primaryColor),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Gap(20.h),
                      SizedBox(
                        width: double.infinity,
                        height: 40.h,
                        child: ElevatedButton(
                          onPressed: () {
                            _signIn();
                          },
                          child: Text(
                            'LogIn As User',
                            style: TextStyle(
                              color: Styles.backgroudColor,
                              fontSize: 16.sp,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Styles.defualtColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.r),
                            ),
                          ),
                        ),
                      ),
                      Gap(20.h),
                      SizedBox(
                        width: double.infinity,
                        height: 40.h,
                        child: ElevatedButton(
                          onPressed: () {
                            AdminLogin();
                          },
                          child: Text(
                            'LogIn As Admin',
                            style: TextStyle(
                              color: Styles.backgroudColor,
                              fontSize: 16.sp,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Styles.defualtColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.r),
                            ),
                          ),
                        ),
                      ),
                      Gap(20.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Don\'t you have an account? ',
                            style: TextStyle(
                              fontSize: 13.sp,
                              color: Styles.primaryColor3,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pushAndRemoveUntil(
                                  MaterialPageRoute(
                                      builder: (context) => SignUp()),
                                  (Route<dynamic> route) => false);
                            },
                            child: Text(
                              'Sign Up',
                              style: TextStyle(
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w600,
                                color: Styles.defualtColor,
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  AdminLogin(){
    FirebaseFirestore.instance.collection('admin').get().then((snapshot) {
      snapshot.docs.forEach((result) {
        if(result.data()['email']!=emailController.text.trim()){
          showToast(message: 'Email Address Not Correct');
        }else if(result.data()['password']!=passwordController.text.trim()){
          showToast(message: 'Enter Correct Password');
        }else{
          Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
              AdminScreen()), (Route<dynamic> route) => false);
          showToast(message: 'Admin is successfully Login');
        }
      });

    });
  }
  void _signIn() async {
    setState(() {
      _isSigning = true;
    });

    String email = emailController.text;
    String password = passwordController.text;

    User? user = await _auth.signInWithEmailAndPassword(email, password);

    setState(() {
      _isSigning = false;
    });

    if (user != null) {
      showToast(message: "User is successfully Login");
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
          HomeScreen()), (Route<dynamic> route) => false);
    } else {
      showToast(message: "some error occurred");
    }
  }
}

import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_book/utils/component.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as p;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';

 import '../utils/app_style.dart';
import 'adminScreen.dart';

class UpdateBooks extends StatefulWidget {
  const UpdateBooks({Key? key}) : super(key: key);

  @override
  State<UpdateBooks> createState() => _UpdateBookssState();
}

class _UpdateBookssState extends State<UpdateBooks> {
  static File? file;
  String? imag;
  String? FileUrl;
  ImagePicker image = ImagePicker();
  getGallery() async {
    var img = await image.pickImage(source: ImageSource.gallery);
    setState(() {
      file = File(img!.path);
      print(img.path);

      imag = img.path;
      //userData.write('path', file);
    });
    showToast(message: 'Selected successfully');
  }
  void uploadImage () async {
    try {
      FirebaseStorage storage =
      FirebaseStorage.instanceFor(
          bucket: 'gs://e-book-aa1d8.appspot.com');

      Reference ref = storage.ref().child(file!.path);
      UploadTask storageUploadTask = ref.putFile(file!);

      TaskSnapshot taskSnapshot = await storageUploadTask.whenComplete(() =>
      {});
      showToast(message: 'Added successfully');

      String url = await taskSnapshot.ref.getDownloadURL();
      print('url $url');
      setState(() {
        imag = url;
      });
      print('image ${imag}');
    } catch (ex) {
      showToast(message: 'Error');

    }
  }
  PlatformFile? pickedFile;
  UploadTask? uploadTask;
  Future uploadFile()async{
    final path='files ${pickedFile!.name}';
    final file2 =File(pickedFile!.path!);
    final ref =FirebaseStorage.instance.ref().child(path);
    uploadTask=ref.putFile(file2);
    final snapshot =await uploadTask!.whenComplete(() {});
    showToast(message: 'Added successfully');
    final urlfile=await snapshot.ref.getDownloadURL();
    print('file url : ${urlfile}');
    setState(() {
      FileUrl = urlfile;
    });
    print('FileUrl ${FileUrl}');
  }
  Future selectFile()async{
    final result=await FilePicker.platform.pickFiles();
    if(result==null) return showToast(message: 'Error Happened');
    setState(() {
      pickedFile=result.files.first;
    });
    showToast(message: 'Selected successfully');
  }

  final NewAuthorNameController = new TextEditingController();
  Future updateAuthor( )async{

    final coll = FirebaseFirestore
        .instance
        .collection('books').doc('test');

    coll.update({
      'author': NewAuthorNameController.text ?? "",


    });

    showToast(message: 'Updated Successfully');
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
            builder: (context) => AdminScreen()),
            (Route<dynamic> route) => false);

  }
  Future updateimage( )async{

    final coll = FirebaseFirestore
        .instance
        .collection('books').doc('test');

    coll.update({

      'image': imag!.toString()  ?? "",

    });

    showToast(message: 'Updated Successfully');
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
            builder: (context) => AdminScreen()),
            (Route<dynamic> route) => false);

  }
  Future updatepdf( )async{

    final coll = FirebaseFirestore
        .instance
        .collection('books').doc('test');

    coll.update({

      'pdf': FileUrl .toString() ?? "",

    });

    showToast(message: 'Updated Successfully');
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
            builder: (context) => AdminScreen()),
            (Route<dynamic> route) => false);

  }
  Future update ( )async{

    final coll = FirebaseFirestore
        .instance
        .collection('books').doc('test');

    coll.update({
      'author': NewAuthorNameController.text ?? "",
      'image': imag!.toString()  ?? "",
      'pdf': FileUrl .toString() ?? "",

    });

    showToast(message: 'Updated Successfully');
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
            builder: (context) => AdminScreen()),
            (Route<dynamic> route) => false);

  }

  void dispose() {
    NewAuthorNameController.dispose();


    super.dispose();
  }

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
          "Update A Book",
          style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.w500
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            Divider(),
            Padding(
              padding:   EdgeInsets.all(15.h),
              child: Column(
                children: [
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('1 -',style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.transparent

                          ),),
                          file == null
                              ? CircleAvatar(
                            backgroundImage: AssetImage('assets/xx.png'),
                            radius: 60.r,
                          )
                              :Container(
                            height: 200.h,
                            width: 200.w,
                            child: Image(
                              image:  FileImage(file!),
                              fit: BoxFit.fill,
                            ),
                          ),
                          Text('3 -',style: TextStyle(
                            color: Colors.transparent,

                          ),),



                        ],
                      ),
                      Gap(10.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('1 -',style: TextStyle(
                            fontWeight: FontWeight.w600,

                          ),),
                          SizedBox(
                            width: 130.w,
                            height: 43.h,
                            child: ElevatedButton(
                              onPressed: () {
                                getGallery();

                              },
                              child: Text(
                                'select cover image',
                                style: TextStyle(
                                  color: Styles.fontColor,
                                  fontSize: 13.sp,
                                ),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Styles.primaryColor2,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5.r),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 130.w,
                            height: 43.h,
                            child: ElevatedButton(
                              onPressed: () {
                                uploadImage();
                              },
                              child: Text(
                                'Upload Cover Image',
                                style: TextStyle(
                                  color: Styles.fontColor,
                                  fontSize: 13.sp,
                                ),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Styles.primaryColor2,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5.r),
                                ),
                              ),
                            ),
                          ),

                        ],
                      ),

                      // Text(
                      //   "Upload Cover Image",
                      //   style: TextStyle(
                      //       fontSize: 15.sp,
                      //       fontWeight: FontWeight.w500
                      //   ),
                      // ),
                    ],
                  ),

                  Gap(20.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('2 -',style: TextStyle(
                        fontWeight: FontWeight.w600,

                      ),),
                      SizedBox(
                        width: 250.w,
                        child: TextFormField(

                          controller: NewAuthorNameController,
                          cursorColor: Styles.primaryColor,
                          keyboardType: TextInputType.name,
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
                            labelText: 'Author Name',
                            hintText: 'Author Name',
                            labelStyle: TextStyle(
                                fontSize: 13.sp,
                                color: Styles.primaryColor),
                            hintStyle: TextStyle(
                                fontSize: 13.sp,
                                color: Styles.primaryColor),
                          ),
                        ),
                      ),
                      Text('1 -',style: TextStyle(
                        color: Colors.transparent,

                      ),),
                    ],
                  ),
                  Gap(20.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('3 -',style: TextStyle(
                        fontWeight: FontWeight.w600,

                      ),),
                      SizedBox(
                        width: 130.w,
                        height: 43.h,
                        child: ElevatedButton(
                          onPressed: () {
                            selectFile();
                          },
                          child: Text(
                            'select the book pdf',
                            style: TextStyle(
                              color: Styles.fontColor,
                              fontSize: 13.sp,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Styles.primaryColor2,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.r),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 130.w,
                        height: 43.h,
                        child: ElevatedButton(
                          onPressed: () {
                            uploadFile();
                          },
                          child: Text(
                            'Upload the book pdf',
                            style: TextStyle(
                              color: Styles.fontColor,
                              fontSize: 13.sp,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Styles.primaryColor2,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.r),
                            ),
                          ),
                        ),
                      ),


                    ],
                  ),

                  Gap(60.h),
                  SizedBox(
                    width: double.infinity,
                    height: 40.h,
                    child: ElevatedButton(
                      onPressed: () {
                        updateimage();

                      },
                      child: Text(
                        'Update A Book Cover',
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
                  Gap(10.h),
                  SizedBox(
                    width: double.infinity,
                    height: 40.h,
                    child: ElevatedButton(
                      onPressed: () {
                        updateAuthor();

                      },
                      child: Text(
                        'Update A Book Author',
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
                  Gap(10.h),

                  SizedBox(
                    width: double.infinity,
                    height: 40.h,
                    child: ElevatedButton(
                      onPressed: () {
                        updatepdf();

                      },
                      child: Text(
                        'Update A Book PDF',
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
                  Gap(10.h),
                  SizedBox(
                    width: double.infinity,
                    height: 40.h,
                    child: ElevatedButton(
                      onPressed: () {
                        update();

                      },
                      child: Text(
                        'Update All',
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
                  Gap(10.h),


                ],
              ),
            )



          ],
        ),
      ),
    );

  }


}

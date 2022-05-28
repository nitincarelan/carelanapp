import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'app_color.dart';

class Widgets {
  static AppBar appBarWidget(String title) => AppBar(
        toolbarHeight: 70,
        title: Text(title,
            style: TextStyle(
              color: AppColor.black54,
            )),
        backgroundColor: AppColor.appbgColor,
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
        //centerTitle: true,
      );

  static showAlertDialog(BuildContext context, String msg) {
    // Create button
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () {
        // Navigator.of(context).pop();
      },
    );

    // Create AlertDialog
    AlertDialog alert = AlertDialog(
      //title: Text("Simple Alert"),
      content: Text(msg),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  static applogo() {
    return Image.asset(
      'assets/images/Logo.png',
      height: 70,
      width: 180,
    );
  }

  static loading() {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 0.5,sigmaY: 0.5),
      child: Container(
        height: 500,
        // width: MediaQuery.of(context).size.width,
        child: CircleAvatar(
            minRadius: 10,
            backgroundColor: Colors.transparent,
            child: CircularProgressIndicator()
        ),
      ),
    );
  }


  static homeImage1() {
    return Image.asset(
      'assets/images/homeImage.png',
      fit: BoxFit.fitHeight,
    );
  }
  static homeImage() {
    return Image.asset(
      'assets/images/3x.png',
       scale: 2.8,
      fit: BoxFit.fitHeight,
    );
  }

  static patient() {
    return CircleAvatar(
      backgroundColor: Colors.grey[100],
      child: Image.asset(
        'assets/images/newpatient1.png',
        fit: BoxFit.fitHeight,
      ),
    );
  }

  static totalcase() {
    return Image.asset(
      'assets/images/totalcase2.png',
      fit: BoxFit.fitHeight,
    );
  }

  static payment() {
    return Image.asset(
      'assets/images/payment3.png',
      fit: BoxFit.fitHeight,
    );
  }

  static hospital() {
    return Image.asset(
      'assets/images/hospital4.png',
      fit: BoxFit.fitHeight,
    );
  }

  static surgeonApproval() {
    return Image.asset(
      'assets/images/surgeonApprove.png',
      fit: BoxFit.fitHeight,
    );
  }
}

class CustomClipPath extends CustomClipper<Path> {
  var radius = 10.0;
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height);
    path.arcToPoint(Offset(size.width, size.height),
        radius: Radius.elliptical(30, 10));
    path.lineTo(size.width, 0);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

import 'package:carelan/utils/constant/app_color.dart';
import 'package:flutter/material.dart';

String Montserrat_Bold = "Montserrat-Bold";
String Montserrat_Italic = "Montserrat-Italic";
String Montserrat_Medium = "Montserrat-Medium";
String Montserrat_Regular = "Montserrat-Regular";

class Font {
  static bold20() {
    return TextStyle(
        fontSize: 20,
        fontFamily: 'Montserrat',
        fontWeight: FontWeight.w700,
      color: Color(0xff535D7E)
    );
  }

  static normal14() {
    return TextStyle(
      fontFamily: Montserrat_Medium,
      fontWeight: FontWeight.w400,
      fontSize: 14,
    );
  }

  static font400R9gray() {
    return TextStyle(
      fontFamily: Montserrat_Regular,
      fontSize: 9,
      fontWeight: FontWeight.w400,
      color: Color(0xff7A7B7C),
    );
  }

  static font400R13blk() {
    return TextStyle(
      fontFamily: Montserrat_Regular,
      fontSize: 13,
      fontWeight: FontWeight.w400,
      color: Color(0xff000000),
    );
  }

  static fontstatus() {
    return TextStyle(
      fontFamily: Montserrat_Medium,
      fontSize: 10,
      fontWeight: FontWeight.w500,
      color: Color(0xff05BB4E),
    );
  }

  static font500N15() {
    return TextStyle(
      fontFamily: 'Montserrat',
      fontWeight: FontWeight.w500,
      fontStyle: FontStyle.normal,
      fontSize: 15,
    );
  }

  static font500M12() {
    return TextStyle(
      fontFamily: Montserrat_Medium,
      fontSize: 12,
      fontWeight: FontWeight.w500,
      color: Color(0xff7A7B7C),
    );
  }
  static font500M12Black() {
    return TextStyle(
      fontFamily: Montserrat_Medium,
      fontSize: 12,
      fontWeight: FontWeight.w500,
      color: Color(0xff1C1C1C),
    );
  }

  static font500M13() {
    return TextStyle(
      fontFamily: Montserrat_Medium,
      fontSize: 13,
      fontWeight: FontWeight.w500,
      color: Color(0xff363636),
    );
  }

  static font500M13wh() {
    return TextStyle(
      fontFamily: Montserrat_Medium,
      fontSize: 13,
      fontWeight: FontWeight.w500,
      color: Color(0xffffffff),
    );
  }

  static font500M10() {
    return TextStyle(
      fontFamily: Montserrat_Medium,
      fontSize: 10,
      fontWeight: FontWeight.w500,
      color: Color(0xff363636),
    );
  }

  static font600B11() {
    return TextStyle(
      fontFamily: Montserrat_Bold,
      fontSize: 11,
      fontWeight: FontWeight.w600,
      color: Color(0xff000000),
    );
  }

  static font600B17() {
    return TextStyle(
      fontFamily: Montserrat_Bold,
      fontSize: 17,
      fontWeight: FontWeight.w600,
      color: Color(0xff000000),
    );
  }

  static font600B13() {
    return TextStyle(
      fontFamily: Montserrat_Bold,
      fontSize: 13,
      fontWeight: FontWeight.w600,
      color: Color(0xff000000),
    );
  }

  static font600B17wh() {
    return TextStyle(
      fontFamily: Montserrat_Bold,
      fontSize: 17,
      fontWeight: FontWeight.w600,
      color: Color(0xffffffff),
    );
  }

  static font600B17grn() {
    return TextStyle(
      fontFamily: Montserrat_Bold,
      fontSize: 17,
      fontWeight: FontWeight.w600,
      color: AppColor.clGreen,
    );
  }

  static font600B17blue() {
    return TextStyle(
      fontFamily: Montserrat_Bold,
      fontSize: 17,
      fontWeight: FontWeight.w600,
      color: AppColor.clBlue,
    );
  }

  static font600B15blk() {
    return TextStyle(
      fontFamily: Montserrat_Bold,
      fontSize: 15,
      fontWeight: FontWeight.w600,
      color: Color(0xff000000),
    );
  }

  static font60032Color(color){
    return TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.w600,
        color: color
    );
  }

}

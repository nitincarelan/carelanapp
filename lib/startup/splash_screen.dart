import 'package:carelan/home/doctor/view/doctorhome.dart';
import 'package:carelan/utils/constant/widgets.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import '../home/accountant/view/accountantDashbord.dart';
import '../home/admin/view/adminhome.dart';
import '../home/carebuddy/view/carebuddyDashboard.dart';
import '../home/insurence/view/InsurnceDeshboard.dart';
import '../model/user_profile_model.dart';
import '../service/verify_phoneno.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'loginnew.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String? phone = "";
  String? profilepic = "";
  String? id = "";
  String? user_Type = "0";
  String? user_type_name = "";
  String? user_Name = "";
  String? speciality = "";
  String? practice_since = "";
  String? certificate = "";
  String? email = "";
  String? mobile = "";

  late SharedPreferences? logindata;
  @override
  void initState() {
    initial() async {
      logindata = await SharedPreferences.getInstance();
      setState(() {
       //logindata!.setString('mobile', "9897424156");// Doctor Nitin
        //logindata!.setString('mobile', "9810217113");// Doctor Shelendra
        //logindata!.setString('mobile', "9873155846");// Doctor Vikash gupta 9910984677
        logindata!.setString('mobile', "9910984677");// Doctor Divya panday
        //logindata!.setString('mobile', "9818820592");// Doctor Rohit
        //logindata!.setString('mobile', "8447960512");// Admin
        //logindata!.setString('mobile', "7838601422");// Accountant
        //logindata!.setString('mobile', "9818436903"); // carebuddy
        //logindata!.setString('mobile', "8447166336"); // carebuddy Krishna ji
        //logindata!.setString('mobile', "8272823235");// carebuddy prasant

        phone = logindata!.getString('mobile');
        if (phone != null) {
          getUserProfile(
            mobile: phone.toString(),
          ).then((value) {
            UserProfile userProfile = value as UserProfile;
            if (userProfile.status == "1") {
              setState(() {
                id = (userProfile.userDetails)?.id;
                user_Type = (userProfile.userDetails)?.userType;
                user_type_name = (userProfile.userDetails)?.userTypeName;
                user_Name = (userProfile.userDetails)?.name;
                speciality = (userProfile.userDetails)?.speciality ?? "";
                practice_since =
                    (userProfile.userDetails)?.practiceSince != null
                        ? (userProfile.userDetails)?.practiceSince
                        : "";
                certificate = (userProfile.userDetails)?.certificate ?? "";
                email = (userProfile.userDetails)?.email ?? "";
                mobile = (userProfile.userDetails)?.mobile ?? "";
                profilepic = (userProfile.userDetails)?.profilePic ?? "";
                logindata!.setString('userName', user_Name!);
                logindata!.setString('userType', user_Type!);
                logindata!.setString('id', id!);
                logindata!.setString('userTypeName', user_type_name!);
                logindata!.setString('speciality', speciality!);
                logindata!.setString('practicesince', practice_since!);
                logindata!.setString('certificate', certificate!);
                logindata!.setString('email', email!);
                logindata!.setString('userName', user_Name!);
                logindata!.setString('mobile', mobile!);
                logindata!.setString("profilepic", profilepic!);
                startTime();
              });
            } else {
              //startTime();
            }
          });
        } else {
          startTime();
        }
      });
    }

    initial();
    super.initState();
  }

  startTime() async {
    var duration = const Duration(seconds: 1);
    return Timer(duration, route);
  }

  route() {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
      //user_Type = "2";
      if (user_Type == "1") {
        //surgeon
        //return DoctorDeshboard();
        return DoctorHomeUI();
      } else if (user_Type == "2") {
        //care buddy
        return CareBuddyDashBoard();
      } else if (user_Type == "3") {
        //Admin
        return AdminHome(); //HomePage();
      } else if (user_Type == "4") {
        //Accountant
        return AccountantDashboard();
      } else if (user_Type == "5") {
        //Insurence
        return InsurenceDashboard();
      } else {
        //login
        //return LoginScreen();//Register();//AdminHome();// Login screen
        return LoginNewScreen();
        //return OtpScreen();
        //return Register();
      }
      //else // Insurence
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          //color: Colors.white,
          /*decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.orangeAccent, AppColor.primaryColor])),
           */
          child: Center(
              child: Column(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                SizedBox(height: 10),
                Widgets.applogo(),
                Column(
                  children: [
                    Image.asset(
                      'assets/images/splsTransp.png',
                      fit: BoxFit.fitWidth,
                    ),
                    const Text(
                      "1.0",
                      style: TextStyle(
                        fontSize: 16.0,
                      ),
                    ),
                  ],
                ),
              ])),
        ),
      ),
    );
  }
}

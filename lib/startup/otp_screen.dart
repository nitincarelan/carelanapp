import 'package:carelan/model/verify_otp_model.dart';
import 'package:carelan/service/verify_phoneno.dart';
import 'package:carelan/utils/constant/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import '../home/admin/view/adminhome.dart';
import '../home/doctor/view/doctorhome.dart';
import '../model/login_model.dart';
import '../model/user_profile_model.dart';
import '../utils/constant/app_color.dart';
import '../utils/constant/appfont.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({Key? key}) : super(key: key);

  @override
  _OtpScreenState createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  late Timer _timer;
  int _start = 0;
  bool _verifyButtonDisable = false;
  bool isLoading = false;
  bool resendOTPLoading = false;
  String? user_Type = "";
  String? user_Name = "";

  TextEditingController _textEditingController = TextEditingController();
  late SharedPreferences? logindata;
  void startTimer() {
    _start = 45;
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(oneSec, (Timer timer) {
      if (_start == 0) {
        setState(() {
          timer.cancel();
        });
      } else {
        setState(() {
          _start--;
        });
      }
    });
  }

  @override
  void initState() {
    startTimer();
    //fetchOtp();
    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final String mobileNumber =
        ModalRoute.of(context)!.settings.arguments as String;
    return Scaffold(
      body: SafeArea(
        child: GestureDetector(
          onTap: () {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: Container(
              height: MediaQuery.of(context).size.height,
              child: Stack(
                alignment: AlignmentDirectional.topCenter,
                children: [
                  Positioned(
                    //top:  0,
                    child: ClipPath(
                      child: Container(
                        height: MediaQuery.of(context).size.height / 2,
                        color: AppColor.appbgColor,
                      ),
                      clipper: CustomClipPath(),
                    ),
                  ),
                  Positioned(top: 100, child: Widgets.applogo()),
                  Positioned(
                      top: 300,
                      child: Stack(
                        children: [
                          ClipRRect(
                              borderRadius: BorderRadius.circular(16.0),
                              child: Container(
                                margin: const EdgeInsets.all(3.0),
                                width: MediaQuery.of(context).size.width - 50,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20),
                                    boxShadow: [
                                      BoxShadow(
                                          blurRadius: 1,
                                          color: Colors.grey,
                                          offset: Offset(1, 3))
                                    ]),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Enter OTP",
                                        style: Font.bold20(),
                                        textAlign: TextAlign.left,
                                      ),
                                      SizedBox(height: 10),
                                      Text(
                                          "4 digit OTP Sent to you on " +
                                              mobileNumber,
                                          style: Font.normal14()),
                                      Padding(
                                        padding: const EdgeInsets.all(16.0),
                                        child: PinCodeTextField(
                                          controller: _textEditingController,
                                          appContext: context,
                                          pastedTextStyle: TextStyle(
                                            color: Colors.green.shade600,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          length: 4,
                                          obscureText: true,
                                          obscuringCharacter: '*',
                                          onChanged: (text) {
                                            setState(() {
                                              if (text.length < 4) {
                                                _verifyButtonDisable = true;
                                              } else {
                                                _verifyButtonDisable = false;
                                                FocusScope.of(context)
                                                    .unfocus();
                                              }
                                            });
                                          },
                                          animationType: AnimationType.fade,
                                          pinTheme: PinTheme(
                                            shape: PinCodeFieldShape.box,
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            fieldHeight: 60,
                                            fieldWidth: 50,
                                            activeFillColor: Colors.black12,
                                          ),
                                          keyboardType: TextInputType.number,
                                          blinkWhenObscuring: true,
                                          /*

                                      validator: (v) {
                                        if (v!.length < 3) {
                                          return "I'm from validator";
                                        } else {
                                          return null;
                                        }
                                      },
                                      pinTheme: PinTheme(
                                        shape: PinCodeFieldShape.box,
                                        borderRadius: BorderRadius.circular(5),
                                        fieldHeight: 50,
                                        fieldWidth: 40,
                                        activeFillColor: Colors.white,
                                      ),
                                      cursorColor: Colors.black,
                                      animationDuration: Duration(milliseconds: 300),
                                      enableActiveFill: true,
                                      errorAnimationController: errorController,
                                      controller: textEditingController,

                                      boxShadows: [
                                        BoxShadow(
                                          offset: Offset(0, 1),
                                          color: Colors.black12,
                                          blurRadius: 10,
                                        )
                                      ],
                                      onCompleted: (v) {
                                        print("Completed");
                                      },
                                      // onTap: () {
                                      //   print("Pressed");
                                      // },
                                      onChanged: (value) {
                                        print(value);
                                        setState(() {
                                          currentText = value;
                                        });
                                      },
                                      beforeTextPaste: (text) {
                                        print("Allowing to paste $text");
                                        //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                                        //but you can show anything you want here, like your pop up saying wrong paste format or etc
                                        return true;
                                      }*/
                                          //),
                                        ),
                                      ),
                                      (_start != 0)
                                          ? Center(
                                              child: Text(
                                                "Resend OTP $_start sec",
                                                style: const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.red),
                                              ),
                                            )
                                          : Center(
                                              child: Column(
                                                children: [
                                                  Text(
                                                    "Did not receive the OTP",
                                                    style: const TextStyle(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.red),
                                                  ),
                                                  const SizedBox(height: 10),
                                                  InkWell(
                                                    child: resendOTPLoading
                                                        ? CircularProgressIndicator(
                                                            color: AppColor
                                                                .primaryColor)
                                                        : Center(
                                                            child: Text(
                                                              "Resend OTP",
                                                              style: const TextStyle(
                                                                  fontSize: 16,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Colors
                                                                      .red),
                                                            ),
                                                          ),
                                                    onTap: () {
                                                      setState(() {
                                                        resendOTPLoading = true;
                                                      });
                                                      resendOtp(mobileNumber);
                                                      _textEditingController
                                                          .clear();
                                                    },
                                                  ),
                                                  SizedBox(height: 10)
                                                ],
                                              ),
                                            ),
                                      const SizedBox(height: 20),
                                      Center(
                                        child: ButtonTheme(
                                          minWidth: MediaQuery.of(context).size.width - 100,
                                          height: 45,
                                          child: isLoading
                                              ? CircularProgressIndicator
                                                  .adaptive()
                                              : RaisedButton(
                                                  //shape: const StadiumBorder(),
                                                  color: AppColor.btnColor,
                                                  child: Text('Verify'),
                                                  splashColor: AppColor.appbgColor,
                                                  elevation: 6,
                                                  textColor: Colors.white,
                                                  onPressed: () {
                                                    setState(() {
                                                      isLoading = true;
                                                    });
                                                    verifyOtp(
                                                      mobile: mobileNumber,
                                                      otp:_textEditingController.text,
                                                    ).then((value) async {
                                                      logindata = await SharedPreferences.getInstance();
                                                      VerifyOTPModel verifyOTPModel = value;
                                                      if (verifyOTPModel.status == 0) {
                                                        String? msg = verifyOTPModel.msg;
                                                        showAlertDialog(context, msg!);
                                                      } else if (verifyOTPModel.status == 1) {
                                                        // Get userprofile for send name and type to the dashboard

                                                        if (mobileNumber != "") {
                                                          // setState(() {
                                                          //   isLoading = false;
                                                          // });
                                                          getUserProfile(
                                                            mobile: mobileNumber, //"9728810002",//phone
                                                            //mobile: "9716929263"//Admin
                                                          ).then((value) async {
                                                            UserProfile userProfile = value as UserProfile;
                                                            if (userProfile.status == "1") {
                                                              if (verifyOTPModel.loginStatus == 0) {
                                                                Navigator.pushNamed(context,'/Register', arguments: mobileNumber);
                                                              } else if (verifyOTPModel.loginStatus == 1) {
                                                                setState(() {
                                                                  isLoading = false;
                                                                });
                                                                if (verifyOTPModel.userData!.userType =="1") {
                                                                  Navigator.of(context).pushNamedAndRemoveUntil('/doctorDeshboard', (Route<dynamic> route) => false);
                                                                } else if (verifyOTPModel.userData!.userType == "3") {
                                                                  Navigator.of(context).pushNamedAndRemoveUntil('/adminhomepage', (Route<dynamic> route) => false);
                                                                } else if(verifyOTPModel.userData!.userType == "2") {
                                                                  Navigator.of(context).pushNamedAndRemoveUntil('/carebuddyHome', (Route<dynamic> route) => false);
                                                                }
                                                              }
                                                              logindata =await SharedPreferences.getInstance();
                                                              setState(() {
                                                                user_Type = (userProfile.userDetails)?.userType??"";
                                                                user_Name = (userProfile.userDetails)?.name??"";
                                                                logindata!.setString('userName', user_Name!);
                                                                logindata!.setString('mobile',mobileNumber);
                                                                logindata!.setString('userType', ((userProfile.userDetails)?.userType??""));
                                                                logindata!.setString('id',((userProfile.userDetails)?.id??""));
                                                                logindata!.setString('userTypeName', ((userProfile.userDetails)?.userTypeName??""));
                                                                logindata!.setString('speciality',((userProfile.userDetails)?.speciality??""));
                                                                logindata!.setString('practicesince',((userProfile.userDetails)?.practiceSince??""));
                                                                logindata!.setString('certificate',((userProfile.userDetails)?.certificate??""));
                                                                logindata!.setString('email', ((userProfile.userDetails)?.email??""));
                                                                logindata!.setString("profilepic", ((userProfile.userDetails)?.profilePic??""));
                                                                });
                                                            }
                                                          });
                                                        }

                                                      }
                                                    });
                                                  }),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                //}
                              )),
                        ],
                      )),
                ],
              )),
        ),
      ),
    );
  }

  void showAlertDialog(BuildContext context, String msg) {
    // Create button
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () {
        setState(() {
          isLoading = false;
        });
        Navigator.pop(context);
        Navigator.pop(context);
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

  void resendOtp(String mobileNumber) {
    fetchOtp(
      mobile: mobileNumber,
    ).then((value) {
      LoginByMobileModel loginByMobileModel = value;
      if (loginByMobileModel.status == 1) {
        setState(() {
          resendOTPLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
          loginByMobileModel.msg ?? "",
            )));
      }
    });
  }
}

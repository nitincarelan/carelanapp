import 'package:carelan/utils/constant/app_color.dart';
import 'package:carelan/utils/constant/widgets.dart';
import 'package:flutter/material.dart';
import '../model/login_model.dart';
import '../service/verify_phoneno.dart';
import '../utils/constant/app_string.dart';
import '../utils/constant/appfont.dart';

class LoginNewScreen extends StatefulWidget {
  const LoginNewScreen({Key? key}) : super(key: key);

  @override
  _LoginNewScreenState createState() => _LoginNewScreenState();
}

class _LoginNewScreenState extends State<LoginNewScreen> {
  late final String mobile;
  final TextEditingController _controller = TextEditingController();
  bool isLoading = false;
  String _errorText = '';

  @override
  Widget build(BuildContext context) {
    final usernameField = TextFormField(
      autofocus: false,
      keyboardType: TextInputType.phone,
      controller: _controller,
      textInputAction: TextInputAction.send,
      onSaved: (value) {
        mobile = value!;
      },
      validator: (value) {
        setState(() {
          _errorText = validation(value!, TextFormFieldType.phone)!;
        });
        return _errorText;
      },
      maxLength: 10,
      decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
          labelText: 'Mobile no'),
    );
    return Scaffold(
      body: GestureDetector(
        onTap: (){
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: Container(
          height: MediaQuery.of(context).size.height,
          color: Colors.white,
          child: Stack(
            alignment: AlignmentDirectional.topCenter,
            children: [
              Positioned(
                //top:  0,
                child: ClipPath(
                  child: Container(
                    height: MediaQuery.of(context).size.height/2,
                    color: AppColor.appbgColor,
                  ),
                  clipper: CustomClipPath(),
                ),
              ),
              Positioned(
                top: 100,
                child: Widgets.applogo()
              ),
              Positioned(
                top : MediaQuery.of(context).size.height/2 - 100,
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
                            boxShadow: [BoxShadow(blurRadius: 1,color: Colors.grey,offset: Offset(1,3))]
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "Get Started",
                                style: Font.bold20(),
                                textAlign: TextAlign.left,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                AppStrings.enterMobiletologin,
                                style: Font.normal14(),
                                textAlign: TextAlign.left,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Form(child: usernameField),
                            ),
                            Center(
                              child: ButtonTheme(
                                minWidth: MediaQuery.of(context).size.width - 100,
                                height: 45,
                                child: isLoading
                                    ? CircularProgressIndicator()
                                    :
                                RaisedButton(
                                    color: AppColor.btnColor,
                                    child: const Text('Next'),
                                    splashColor: Colors.pink,
                                    elevation: 6,

                                    textColor: Colors.white,
                                    onPressed: () {
                                      // Navigator.pushNamed(
                                      //     context, '/Register',
                                      //     arguments: "9897424156");

                                      if (_controller.text.isEmpty) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                            content: Text(
                                              "Please enter 10 digit mobile no.",
                                            )));
                                        setState(() {
                                          isLoading = false;
                                        });
                                      } else {
                                        setState(() {
                                          isLoading = true;
                                        });
                                        // Future.delayed(Duration(seconds: 1),
                                        //         () { });
                                        fetchOtp( mobile: _controller.text).then((value) {
                                          LoginByMobileModel loginByMobileModel = value;
                                          if (loginByMobileModel.status == 1) {
                                            setState(() {
                                              isLoading = false;
                                            });
                                            Navigator.pushNamed(
                                                context, '/OtpScreen',
                                                arguments: _controller.text);
                                          }
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                              content: Text(
                                                loginByMobileModel.msg ?? "",
                                              )));
                                        });
                                      }
                                    }),
                              ),
                            ),
                            SizedBox(height: 10),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

            ],

          ),
        ),
      ),

    );
  }

  String? validation(String value, TextFormFieldType type) {
    if (value.isEmpty) {
      return "Mobile is not empty";
    }
    if (type == TextFormFieldType.phone && value.length < 10) {
      return "Invalid mobile number";
    }
    return null;
  }
}

enum TextFormFieldType {
  phone,
}

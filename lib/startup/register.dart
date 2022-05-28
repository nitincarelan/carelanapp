import 'dart:collection';
import 'package:carelan/model/deshboardmodel/citydatamodel.dart';
import 'package:carelan/service/verify_phoneno.dart';
import 'package:carelan/utils/constant/widgets.dart';
import 'package:flutter/material.dart';
import '../home/doctor/view/doctorhome.dart';
import '../home/drawer/view/userprofile.dart';
import '../model/deshboardmodel/approverejectmodel.dart';
import '../model/registermodel.dart';
import '../model/user_profile_model.dart';
import '../service/deshboard/approve_reject_service.dart';
import '../utils/constant/app_color.dart';
import 'loginnew.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  //String _value;
  String? _userTypeValue = "1";// for doctor
  //String? _userTypeValue = "2";// for carebuddy
  //String _userTypeValue = "4";// for accountant

  String? _cityValue;
  final items = ['Doctor', 'Central team', 'Care buddy', 'Accountant'];
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _cityController = TextEditingController();
  bool _nvalidate = false;
  bool _evalidate = false;
  bool isLoading = false;
  HashMap<dynamic, String> mapcityList = new HashMap<int, String>();
  late SharedPreferences? logindata;
  String? user_Type = "";
  String? user_Name = "";

  //var currentFocus;

  // unfocus() {
  //   currentFocus = FocusScope.of(context);
  //
  //   if (!currentFocus.hasPrimaryFocus) {
  //     currentFocus.unfocus();
  //   }
  // }

  @override
  void initState() {
    // TODO: implement initState
    //cityList = getCityList() as Map<String, String>;
    getAllCity().then((value) async {
      CityModel datalist = value;
      int? ciltylength = datalist.allCity?.length;
      for (var i = 0; i < ciltylength!; i++) {
        AllCity city = datalist.allCity![i];
        //print(city.cityName);
        // mapcityList.putIfAbsent(i, () => city.cityName.toString());
      }
      print(mapcityList);

      //cityList = datalist.allCity as Map<String, dynamic>;

      // setState(() {
      //   cityList = datalist.allCity as Map<String, dynamic>;
      //   print('-------city list --------');
      //   print(cityList);
      // });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Object? mobileNumber = ModalRoute.of(context)!.settings.arguments;

    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        body: SingleChildScrollView(
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
                      top: 200,
                      child: Stack(
                        children: [
                          ClipRRect(
                              borderRadius: BorderRadius.circular(16.0),
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Container(
                                  margin: const EdgeInsets.all(3.0),
                                  width: MediaQuery.of(context).size.width - 50,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(20),
                                      boxShadow: [BoxShadow(blurRadius: 1,color: Colors.grey,offset: Offset(1,3))]
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Register with us",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                          ),
                                        ),
                                        SizedBox(height: 10),

                                        /*
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: DropdownButtonFormField<String>(
                                        dropdownColor: AppColor.primaryColor,
                                        decoration: const InputDecoration(
                                          border: OutlineInputBorder(),
                                        ),
                                        items:
                                            //items.map(buildMenuItem()).toList(),
                                            [
                                          DropdownMenuItem<String>(
                                            child: Text('Doctor'),
                                            value: "1",
                                          ),
                                          DropdownMenuItem<String>(
                                            child: Text('Field Worker'),
                                            value: '2',
                                          ),
                                          DropdownMenuItem<String>(
                                            child: Text('Accountant'),
                                            value: '4',
                                          ),
                                          // DropdownMenuItem<String>(
                                          //   child: Text('Customer'),
                                          //   value: '5',
                                          // ),
                                        ],
                                        onChanged: (String? value1) {
                                          setState(() {
                                            _userTypeValue = value1;
                                          });
                                        },
                                        hint: Text('--Select User Type--'),
                                        value: _userTypeValue,
                                      ),
                                    ),
                                    */
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: TextField(
                                            controller: _nameController,
                                            textCapitalization: TextCapitalization.sentences,
                                            decoration: InputDecoration(
                                              border: OutlineInputBorder(),
                                              labelText: 'Name',
                                              hintText: 'Enter your name',
                                              errorText: _nvalidate
                                                  ? 'Name Field Shouldn\'t Be Empty'
                                                  : null,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: TextField(
                                            controller: _emailController,
                                            keyboardType:
                                                TextInputType.emailAddress,
                                            decoration: InputDecoration(
                                              border: OutlineInputBorder(),
                                              labelText: 'Email',
                                              hintText: 'Enter email',
                                              errorText: _evalidate
                                                  ? 'Email Field Shouldn\'t Be Empty'
                                                  : null,
                                            ),
                                          ),
                                        ),
                                        /*Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: TextField(
                                            controller: _addressController,
                                            textCapitalization:
                                                TextCapitalization.sentences,
                                            decoration: InputDecoration(
                                              border: OutlineInputBorder(),
                                              labelText: 'Address',
                                              hintText: 'Address',
                                              errorText: _validate
                                                  ? 'Address Field Shouldn\'t Be Empty'
                                                  : null,
                                            ),
                                          ),
                                        ),*/
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: DropdownButtonFormField<String>(
                                            dropdownColor: AppColor.appbgColor,
                                            decoration: const InputDecoration(
                                              border: OutlineInputBorder(),
                                            ),
                                            focusColor: Colors.grey,
                                            items:
                                                //items.map(buildMenuItem()).toList(),
                                                [
                                              DropdownMenuItem<String>(
                                                child: Text('Delhi'),
                                                value: "1",
                                              ),
                                              DropdownMenuItem<String>(
                                                child: Text('Gurgaon'),
                                                value: '2',
                                              ),
                                              DropdownMenuItem<String>(
                                                child: Text('Noida'),
                                                value: '3',
                                              ),
                                              DropdownMenuItem<String>(
                                                child: Text('Faridabad'),
                                                value: '4',
                                              ),
                                              DropdownMenuItem<String>(
                                                child: Text('Ghaziabad'),
                                                value: '5',
                                              ),
                                            ],
                                            onChanged: (String? value2) {
                                              setState(() {
                                                _cityValue = value2;
                                              });
                                            },
                                            hint: Text('--Select Your City--'),
                                            value: _cityValue,
                                          ),
                                        ),

                                        // Padding(
                                        //   padding: const EdgeInsets.all(8.0),
                                        //   child: TextField(
                                        //     controller: _cityController,
                                        //     decoration: InputDecoration(
                                        //       border: OutlineInputBorder(),
                                        //       labelText: 'City',
                                        //       hintText: 'Select City',
                                        //       errorText: _validate ? 'City Field Shouldn\'t Be Empty' : null,
                                        //     ),
                                        //   ),
                                        // ),

                                        // textField('Name', 'Enter your name',),
                                        // textField('Email', 'Email'),
                                        // textField('Address', 'Address'),
                                        SizedBox(height: 20),
                                        Center(
                                          child: ButtonTheme(
                                            minWidth: MediaQuery.of(context).size.width - 100,
                                            height: 45,
                                            child: isLoading
                                                ? CircularProgressIndicator()
                                                : RaisedButton(
                                                    //shape: const StadiumBorder(),
                                                    color: AppColor.btnColor,
                                                    child: Text('Register'),
                                                    splashColor: Colors.grey,
                                                    elevation: 6,
                                                    textColor: Colors.white,
                                                    onPressed: () {
                                                      if (_cityValue != null) {
                                                        setState(() {
                                                          _nameController.text.isEmpty ? _nvalidate = true : _nvalidate = false;
                                                          _emailController.text.isEmpty ? _evalidate = true : _evalidate = false;
                                                          //_addressController.text.isEmpty ? _validate = true : _validate = false;
                                                        });

                                                        if (!_nvalidate && !_evalidate) {
                                                          setState(() {
                                                            isLoading = true;
                                                          });
                                                          register(
                                                            user_type: '$_userTypeValue',
                                                            name: _nameController.text,
                                                            email: _emailController.text,
                                                            mobile: mobileNumber,
                                                            //address: _addressController.text,
                                                            cityid: '$_cityValue',
                                                          ).then((value) {
                                                            UserRegisterModel userRegisterModel = value;
                                                            if (userRegisterModel.status == 1) {

                                                              getUserProfile(
                                                                mobile: mobileNumber.toString(), //"9728810002",//phone
                                                                //mobile: "9716929263"//Admin
                                                              ).then((value) async {
                                                                //
                                                                UserProfile userProfile = value as UserProfile;

                                                                if (userProfile.status == "1") {
                                                                  setState(() {
                                                                    isLoading = false;
                                                                  });
                                                                  Navigator.of(context).pushNamedAndRemoveUntil('/doctorDeshboard', (Route<dynamic> route) => false);
                                                                  logindata =await SharedPreferences.getInstance();
                                                                  setState(() {
                                                                    user_Type = (userProfile.userDetails)?.userType??"";
                                                                    user_Name = (userProfile.userDetails)?.name??"";
                                                                    logindata!.setString('userName', user_Name!);
                                                                    logindata!.setString('mobile',mobileNumber.toString());
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
                                                            } else {
                                                              Future.delayed(Duration(seconds: 5));
                                                              setState(() {
                                                                isLoading = false;
                                                              });
                                                              var msg = userRegisterModel.msg as String;
                                                              ScaffoldMessenger.of(context).showSnackBar(
                                                                SnackBar( content: Text(msg)));
                                                            }
                                                          });
                                                        } else {
                                                          // ScaffoldMessenger.of(context)
                                                          //     .showSnackBar(
                                                          //     SnackBar(
                                                          //         content: Text('text field error')),
                                                          // );
                                                        }
                                                      } else {
                                                        ScaffoldMessenger.of(
                                                                context)
                                                            .showSnackBar(
                                                          const SnackBar(
                                                              content: Text(
                                                                  'Please Select Your City')),
                                                        );
                                                      }
                                                    },
                                                  ),
                                          ),
                                        ),
                                        SizedBox(height: 20),
                                      ],
                                    ),
                                  ),
                                ),
                              )),
                        ],
                      ))
                ],
              )),
        ),
      ),
    );
  }

  showAlertDialog(BuildContext context, String msg) {
    // set up the button
    Widget okButton = TextButton(
      child: Text("OK"),
      onPressed: () {
        setState(() {
          isLoading = true;
        });
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (BuildContext context) => LoginNewScreen()),
          (Route route) => false,
        );
        // Navigator.of(context).pop();
        // Navigator.of(context).pop();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Center(child: Text("Confirm")),
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
}

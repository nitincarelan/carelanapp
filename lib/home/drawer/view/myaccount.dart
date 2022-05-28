import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:carelan/utils/constant/widgets.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../../utils/constant/app_color.dart';
import '../../doctor/view/doctorhome.dart';
// import '../../doctor_deshboard.dart';
import '../controller/updateAcService.dart';
import '../model/updateAcountModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyAccount extends StatefulWidget {
  const MyAccount({Key? key}) : super(key: key);

  @override
  _MyAccountState createState() => _MyAccountState();
}

class _MyAccountState extends State<MyAccount> {
  bool _validate = false;
  bool isLoading = false;

  ImagePicker picker = ImagePicker();
  PickedFile? pickedImage;
  File? imageFile = null;
  String? imagePath = "";

  TextEditingController _specility = new TextEditingController();
  TextEditingController _practicesince = new TextEditingController();
  late SharedPreferences logindata;
  String? userspecility = "";
  String? practiceSince = "";
  String certificate = "";
  String mobile = "";



  void initState() {
    initial();
    super.initState();
  }

  initial() async {
    logindata = await SharedPreferences.getInstance();
    String? specility = logindata.getString('speciality');
    String? practicesince = logindata.getString('practicesince');
    String? certificate = logindata.getString('certificate') as String;
    String? mobilenumber = logindata.getString("mobile");

    setState(() {
      userspecility = specility!;
      mobile = mobilenumber!;
      _specility = TextEditingController(text : userspecility);
      _practicesince = TextEditingController(text: practicesince);
      if(certificate.toString()!=""){
       //imagePath = File(certificate!) as String?;
       //logindata.setString('certificate', imagePath.toString());
      }
    });
    //return accountName;
  }

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        appBar: Widgets.appBarWidget("Update Account"),
        body: Container(
          height: MediaQuery.of(context).size.height,
            child: Stack(
              alignment: AlignmentDirectional.topCenter,
              children: [
                Positioned(
                    child: ClipPath(
                      child: Container(
                        height: MediaQuery.of(context).size.height / 3,
                        color: AppColor.appbgColor,
                      ),
                      clipper: CustomClipPath(),
                    )),
                Positioned(
                    top : 50,
                    child: AccountForm(context))
              ],
            )
        ),
      ),
    );
  }

  Widget AccountForm(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: MediaQuery.of(context).size.width-50,
          margin: const EdgeInsets.all(3.0),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [BoxShadow(blurRadius: 1,color: Colors.grey,offset: Offset(1,3))]
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  TextFormField(
                    controller: _specility,
                    //initialValue: userspecility,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Speciality',
                        hintText: 'Speciality'),

                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                  ),

                  SizedBox(height: 10),
                  TextFormField(
                    controller: _practicesince,
                    keyboardType: TextInputType.number,
                    maxLength: 4,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Practice Since',
                        hintText: 'Practice Since'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 10),
                  InkWell(
                    child: Container(
                      height: 50,
                      //width: MediaQuery.of(context).size.width,
                      // decoration: BoxDecoration(
                      //     //color: AppColor.primaryColor,
                      //     borderRadius: BorderRadius.circular(3),
                      //     border: Border.all(color: Colors.grey)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // Padding(
                          //   padding: const EdgeInsets.only(left: 8.0),
                          //   child: Text('Cirtificate Attechment'),
                          // ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                                alignment: Alignment.centerRight,
                                child: imageFile == null
                                    ?
                                Row(
                                  children: [
                                    Icon(
                                            Icons.add_a_photo_outlined,
                                            color: AppColor.btnColor,
                                          ),
                                    SizedBox(width: 10),
                                    Text("Add certificate",
                                      style: TextStyle(
                                          color: AppColor.btnColor
                                      ),),
                                  ],
                                )
                                    :
                                Row(
                                  children: [
                                    Icon(Icons.add_link,
                                      color: Colors.green,),
                                    SizedBox(width: 10),
                                    Text("Certificate updated",
                                      style: TextStyle(
                                          color: Colors.green
                                      )),
                                  ],
                                )),
                          ),
                        ],
                      ),
                    ),
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        builder: ((builder) => bottomSheet()),
                      );
                    },
                  ),
                  SizedBox(height: 10),
                  ButtonTheme(
                    minWidth: MediaQuery.of(context).size.width - 100,
                    height: 45,
                    child: isLoading ? CircularProgressIndicator()
                        :RaisedButton(
                      //shape: const StadiumBorder(),
                      color: AppColor.btnColor,
                      child: Text('Update',
                      style: TextStyle(
                        color: Colors.white
                      ),),
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          if(imageFile != null) {
                            setState(() {
                              isLoading = true;
                            });
                            imagePath = imageFile!.path;
                            File imagefile = File(imagePath!);
                            Uint8List imagebytes = await imagefile.readAsBytes();
                            String base64string = base64.encode(imagebytes);
                            //print(base64string);
                            updteDoctorProfile(
                                  mobile: mobile,
                                  speciality: _specility.text,
                                  practice_since: _practicesince.text,
                                  certificate: base64string)
                              .then((value) async {
                            UpdateDoctorAccount updateaccount = value;
                            if (updateaccount.status == 1) {
                              logindata.setString('speciality', _specility.text);
                              logindata.setString('practicesince', _practicesince.text);
                              logindata.setString('certificate', base64string);


                              setState(() {
                                isLoading = false;
                              });
                              String msg = updateaccount.msg.toString();
                              showAlertDialog(context, "Profile Updated");
                              //   Future.delayed(const Duration(seconds: 3), () {
                              //   // Navigator.pop(context);
                              //   // Navigator.pop(context);
                              // });
                              await Future.delayed(Duration(seconds: 2));
                              Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                    builder: (BuildContext context) => DoctorHomeUI()
                                ),
                                    (Route route) => false,
                              );
                            }
                            // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            //     content: Text(
                            //   updateaccount.msg ?? "",
                            // )));
                          });
                          } else {
                            setState(() {
                              isLoading = false;
                            });
                            showAlertDialog(context, "Please atteched certificate");
                          }
                        }
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  Widget bottomSheet() {
    return Container(
      height: 100.0,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      child: Column(
        children: <Widget>[
          Text(
            "Choose Profile photo",
            style: TextStyle(
              fontSize: 20.0,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
            FlatButton.icon(
              icon: Icon(Icons.camera),
              onPressed: () {
                takePhotoFromCamera();
                Navigator.pop(context);
              },
              label: Text("Camera"),
            ),
            FlatButton.icon(
              icon: Icon(Icons.image),
              onPressed: () {
                takePhotoFromGallery();
                Navigator.pop(context);
              },
              label: Text("Gallery"),
            ),
          ])
        ],
      ),
    );
  }

  void takePhotoFromGallery() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
      maxWidth: 1000,
      maxHeight: 1000,
    );
    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
      });
    }
  }

  void takePhotoFromCamera() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.camera,
      maxWidth: 500,
      maxHeight: 500,
    );
    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
      });
    }
  }

  void showAlertDialog(BuildContext context, String msg) {
    // Create button
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.of(context).pop();
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


}

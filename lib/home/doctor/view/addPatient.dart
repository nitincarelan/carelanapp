import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../model/deshboardmodel/addpatientmodel.dart';
import '../../../service/verify_phoneno.dart';
import '../../../utils/constant/app_color.dart';
import '../../../utils/constant/widgets.dart';
import 'doctorhome.dart';

class AddPatient extends StatefulWidget {
  const AddPatient({Key? key}) : super(key: key);
  @override
  _AddPatientState createState() => _AddPatientState();
}

class _AddPatientState extends State<AddPatient> {
  @override
  ImagePicker picker = ImagePicker();
  PickedFile? pickedImage;
  late File? imageFile = null;
  String imagePath = "";
  TextEditingController? nameController = TextEditingController();
  final TextEditingController? mobileController = TextEditingController();
  final TextEditingController? descriptionController = TextEditingController();
  bool _validate = false;
  bool isLoading = false;

  late SharedPreferences logindata;
  String addedby = '';

  @override
  void initState() {
    // TODO: implement initState
    getMobile() async {
      logindata = await SharedPreferences.getInstance();
      setState(() {
        addedby = logindata.getString('mobile')!;
      });
    }

    getMobile();
    super.initState();
  }

  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        appBar : Widgets.appBarWidget("Add Patient"),

        body: Container(
          height: MediaQuery.of(context).size.height,
          child: Stack(
            alignment: AlignmentDirectional.topCenter,
            children: [
              Positioned(child: ClipPath(
                child: Container(
                  height: MediaQuery.of(context).size.height/3,
                  color: AppColor.appbgColor,
                ),
                clipper: CustomClipPath(),
              )),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Enter patient details for surgery and admission",
                style: TextStyle(
                  fontSize: 16
                ),
                ),
              ),
              Positioned(
                top : 50,
                child: PatientForm(context))
            ],
              ),
        ),
      ),
    );
  }

  Widget PatientForm(BuildContext context) {
    //final _formKey = GlobalKey<FormState>();
    return SingleChildScrollView(
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              TextField(
                controller: nameController,
                textCapitalization: TextCapitalization.sentences,
                autofocus: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Patient Name',
                  hintText: 'Enter Patient Name',
                  errorText: _validate ? 'Name Field Shouldn\'t Be Empty' : null,
                ),
              ),
              SizedBox(height: 10),
              TextField(
                controller: mobileController,
                keyboardType: TextInputType.number,
                maxLength: 10,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter a phone number',
                  labelText: 'Mobile',
                  errorText: _validate ? 'Name Field Shouldn\'t Be Empty' : null,
                ),
              ),
              SizedBox(height: 10),
              TextField(
                controller: descriptionController,
                //keyboardType: TextInputType.text,
                maxLines: 4,
                textCapitalization: TextCapitalization.sentences,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Description',
                  labelText: 'Description',
                  //errorText: _validate ? 'Name Field Shouldn\'t Be Empty' : null,
                ),
              ),
              SizedBox(height: 20),
              InkWell(
                child: Container(
                  height: 30,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(3),
                    ),
                  child: imageFile == null
                      ?
                  Container(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(Icons.add_a_photo_outlined,
                        color: AppColor.btnColor,),
                        SizedBox(width: 10),
                        Text("Add prescription",
                        style: TextStyle(
                          color: AppColor.btnColor
                        ),),
                      ],
                    ),
                  )
                      :
                  Container(child: Row(
                            //mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(Icons.add_link,
                                color: Colors.green),
                              SizedBox(width: 10),
                              Text("Prescription added",
                                style: TextStyle(
                                    color: Colors.green
                                ),),
                            ],
                          )
                        ),
                ),
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    builder: ((builder) => bottomSheet()),
                  );
                },
              ),
              SizedBox(height: 20),
              ButtonTheme(
                minWidth: MediaQuery.of(context).size.width - 100,
                height: 45,
                child: isLoading
                    ? CircularProgressIndicator()
                    : RaisedButton(
                        color: AppColor.btnColor,
                        textColor: Colors.white,
                        child: const Text('Submit'),
                        onPressed: () async {
                          //print(nameController!.text.isEmpty);
                          setState(() {
                            nameController!.text.isEmpty ? _validate = true : _validate = false;
                            mobileController!.text.isEmpty ? _validate = true : _validate = false;
                          });
                          if (!_validate) {
                            // if (imageFile != null) {
                              setState(() {
                                isLoading = true;
                              });
                              String base64string = "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";
                              if (imageFile != null) {
                                imagePath = imageFile!.path;
                                File imagefile = File(imagePath);
                                Uint8List imagebytes = await imagefile
                                    .readAsBytes();
                                setState(() {
                                  base64string = base64.encode(imagebytes);
                                });
                              }
                              addPatient(
                                      addedby: addedby,
                                      name: nameController!.text,
                                      //email: emailController!.text,
                                      mobile: mobileController!.text,
                                      //address: addressController!.text,
                                      image: base64string,
                                      description: descriptionController!.text)
                                  .then((value) {
                                AddPatientModel addpastient = value;
                                if (addpastient.status == 1) {
                                  String msg = addpastient.msg.toString();
                                  showAlertDialog(context, msg);
                                  Future.delayed(const Duration(seconds: 1), () {
                                    Navigator.of(context).pushAndRemoveUntil(
                                      MaterialPageRoute(
                                          builder: (BuildContext context) => DoctorHomeUI()),
                                          (Route route) => false,
                                    );
                                  });
                                } else {
                                  String msg = addpastient.msg.toString();
                                  showAlertDialog(context, msg);
                                  Future.delayed(const Duration(seconds: 3), () {
                                    Navigator.pop(context);
                                  });
                                }
                              });
                            // } else {
                            //   ScaffoldMessenger.of(context).showSnackBar(
                            //     const SnackBar(
                            //         content: Text('Please select image')),
                            //   );
                            // }
                          }
                        }),
              ),
            ],
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
      maxWidth: 750,
      maxHeight: 750,
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
        //Navigator.of(context).pop();
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

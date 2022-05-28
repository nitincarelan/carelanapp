import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:carelan/home/admin/model/patientdatamodel.dart';
import 'package:carelan/home/admin/view/adminhome.dart';
import 'package:carelan/utils/constant/widgets.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../../utils/constant/app_color.dart';
import '../controller/adminService.dart';
import '../model/PatientUpdate.dart';

class PatientDetailsFormForAdmin extends StatefulWidget {
  const PatientDetailsFormForAdmin({Key? key, required this.person})
      : super(key: key);
  final Person person;

  @override
  State<PatientDetailsFormForAdmin> createState() =>
      _PatientDetailsFormForAdminState();
}

class _PatientDetailsFormForAdminState
    extends State<PatientDetailsFormForAdmin> {
  @override
  TextEditingController surgeryController = TextEditingController();
  TextEditingController admissionController = TextEditingController();
  TextEditingController ottimeController = TextEditingController();
  TextEditingController surgeonNameController = TextEditingController();
  TextEditingController refferedByController = TextEditingController();
  TextEditingController surgeryDateController = TextEditingController();
  TextEditingController paymentTypeController = TextEditingController();
  TextEditingController insurnceNameController = TextEditingController();
  TextEditingController hospitalController = TextEditingController();
  TimeOfDay selectedTimeAT = TimeOfDay(hour: 0, minute: 0);
  TimeOfDay selectedTimeOT = TimeOfDay(hour: 0, minute: 0);
  ImagePicker picker = ImagePicker();
  PickedFile? pickedImage;
  File? imageFile = null;
  String imagePath = "";
  bool isLoading = false;

  Widget build(BuildContext context) {
    surgeonNameController =
        TextEditingController(text: widget.person.sergeonName);

    return Scaffold(
      appBar: Widgets.appBarWidget((widget.person.name)),
      body: buildFormForPatientDetails(),
    );
  }

  Widget buildFormForPatientDetails() {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: SingleChildScrollView(
        child: Form(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                CustomTextFormField(
                    'Surgery', 'Surgery', surgeryController, 'text'),
                SizedBox(height: 10),
                Container(
                  height: 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      border: Border.all(color: Colors.grey)),
                  child: InkWell(
                    onTap: () {
                      _selectTimeAT(context);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            child: Text(
                              'Admission Time',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          Text(
                            "${selectedTimeAT.hour}:${selectedTimeAT.minute}",
                            style: TextStyle(
                                fontSize: 22, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  height: 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      border: Border.all(color: Colors.grey)),
                  child: InkWell(
                    onTap: () {
                      _selectTimeOT(context);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                           Container(
                              child: Text(
                                'OT Time',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                          Text(
                            "${selectedTimeOT.hour}:${selectedTimeOT.minute}",
                            style: TextStyle(
                                fontSize: 22, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                CustomTextFormField('Surgeon Name', 'Surgeon Name',
                    surgeonNameController, 'text'),
                SizedBox(height: 10),
                CustomTextFormField(
                    'Reffered by', 'Reffered by', refferedByController, 'text'),
                SizedBox(height: 10),
                TextField(
                  controller: surgeryDateController,
                  readOnly: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Sugery Date",
                    hintText: "Sugery Date",
                  ),
                  onTap: () async {
                    var date = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime.now(), //DateTime(1900),
                        lastDate: DateTime(2100));
                        surgeryDateController.text =
                        date.toString().substring(0, 10);
                  },
                ),
                SizedBox(height: 10),
                CustomTextFormField('Payment Type', 'Payment Type',
                    paymentTypeController, 'text'),
                SizedBox(height: 10),
                CustomTextFormField(
                    'Hospital', 'Hospital', hospitalController, 'text'),
                SizedBox(height: 10),
                InkWell(
                  child: Container(
                    height: 30,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(3),
                    ),
                    child: imageFile == null
                        ? Container(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.add_a_photo_outlined,
                                  color: AppColor.btnColor,
                                ),
                                SizedBox(width: 10),
                                Text("Upload Insurence Documents",
                                    style: TextStyle(color: AppColor.btnColor)),
                              ],
                            ),
                          )
                        : Container(
                            child: Row(
                            //mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(Icons.add_link, color: Colors.green),
                              SizedBox(width: 10),
                              Text(
                                "Insurence Documents Added",
                                style: TextStyle(color: Colors.green),
                              ),
                            ],
                          )),
                  ),
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      builder: ((builder) => bottomSheet()),
                    );
                  },
                ),
                SizedBox(height: 30),
                isLoading
                    ? CircularProgressIndicator()
                    : ElevatedButton(
                        child: Text(
                          'Submit',
                          style: TextStyle(
                            color: AppColor.clWhite,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                            fixedSize: Size(
                                MediaQuery.of(context).size.width - 70, 45),
                            primary: AppColor.btnColor),
                        onPressed: () async {
                          String atTime = selectedTimeAT.hour.toString() +
                              ':' +
                              selectedTimeAT.minute.toString();
                          String otTime = selectedTimeOT.hour.toString() +
                              ':' +
                              selectedTimeOT.minute.toString();
                          if (imageFile != null) {
                          setState(() {
                            isLoading = true;
                          });
                          imagePath = imageFile!.path;
                          File imagefile = File(imagePath);
                          Uint8List imagebytes = await imagefile.readAsBytes();
                          String base64string = base64.encode(imagebytes);

                          updatePatientMoreDetails(
                                  id: widget.person.id,
                                  surgery: surgeryController.text,
                                  admissionTime: atTime,
                                  surgeryDate: surgeryDateController.text,
                                  ottime: otTime,
                                  surgeryName: surgeonNameController.text,
                                  refferedBy: refferedByController.text,
                                  paymentType: paymentTypeController.text,
                                  insuranceName: base64string,
                                  hospital: hospitalController.text)
                              .then((value) {
                            UpdatePatient addpastient = value;
                            if (addpastient.status == 1) {
                              setState(() {
                                isLoading = false;
                              });
                              String msg = addpastient.msg.toString();
                              //showAlertDialog(context, msg);
                              Widgets.showAlertDialog(context, msg);
                              Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        AdminHome()),
                                (Route route) => false,
                              );
                            } else {
                              String msg = addpastient.msg.toString();
                              Widgets.showAlertDialog(context, msg);
                              Future.delayed(const Duration(seconds: 3), () {
                                Navigator.pop(context);
                              });
                            }
                          });
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar( content: Text("Please upload insurence document.")));
                          }
                        },
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget CustomTextFormField(
      String lbl, String hnt, TextEditingController controller, String type) {
    return TextFormField(
      //initialValue: 'your initial text',
      controller: controller,
      keyboardType: type != "num" ? TextInputType.text : TextInputType.number,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: lbl,
        hintText: hnt,
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter some text';
        }
        return null;
      },
      onChanged: (val) {},
    );
  }

  _selectTimeAT(BuildContext context) async {
    final TimeOfDay? timeOfDay = await showTimePicker(
      context: context,
      initialTime: selectedTimeAT,
      initialEntryMode: TimePickerEntryMode.input,
    );
    if (timeOfDay != null && timeOfDay != selectedTimeAT) {
      setState(() {
        selectedTimeAT = timeOfDay;
      });
    }
  }

  _selectTimeOT(BuildContext context) async {
    final TimeOfDay? timeOfDay = await showTimePicker(
      context: context,
      initialTime: selectedTimeOT,
      initialEntryMode: TimePickerEntryMode.input,
    );
    if (timeOfDay != null && timeOfDay != selectedTimeOT) {
      setState(() {
        selectedTimeOT = timeOfDay;
      });
    }
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
      maxWidth: 700,
      maxHeight: 700,
    );
    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
      });
    }
  }
}

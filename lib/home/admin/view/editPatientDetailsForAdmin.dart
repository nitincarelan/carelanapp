import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:carelan/home/admin/model/singleLeadDetailModel.dart';
import 'package:carelan/utils/constant/app_color.dart';
import 'package:flutter/material.dart';
import '../../../utils/constant/widgets.dart';
import 'package:image_picker/image_picker.dart';
import '../controller/adminService.dart';
import '../model/PatientUpdate.dart';
import 'carebuddylist.dart';

class EditPatientDetailforAdmin extends StatefulWidget {
  const EditPatientDetailforAdmin({Key? key, required this.datalist}) : super(key: key);
  final List<LeadDetails>? datalist;
  @override
  _EditPatientDetailforAdminState createState() => _EditPatientDetailforAdminState();
}

class _EditPatientDetailforAdminState extends State<EditPatientDetailforAdmin> {
  TimeOfDay selectedTimeAT = TimeOfDay.now();
  TimeOfDay selectedTimeOT = TimeOfDay.now();
  //TimeOfDay selectedTimeAT1 = TimeOfDay(hour: 19, minute: 33);
  ImagePicker picker = ImagePicker();
  PickedFile? pickedImage;
  File? imageFile = null;
  String imagePath = "";
  bool isLoading = false;
  bool atFlag = false;
  bool otFlag = false;

  @override
  Widget build(BuildContext context) {
    var ptDetails = widget.datalist?[0];
    return Scaffold(
      appBar: Widgets.appBarWidget((ptDetails?.name)??""),
      body: buildFormForPatientDetails(ptDetails!),
    );
  }

  Widget buildFormForPatientDetails(LeadDetails? ptDetails) {
    if(!atFlag) {
      List? atTime = ((ptDetails?.admissionTime) ?? '0:0').split(':') as List;
      String athr = atTime[0];
      String atmnt = atTime[1];
      selectedTimeAT = TimeOfDay(hour: int.parse(athr), minute: int.parse(atmnt));
    }
    if(!otFlag){
      List? otTime = ((ptDetails?.otTime)??'0:0').split(':') as List;
      String othr = otTime[0];
      String otmnt = otTime[1];
      selectedTimeOT = TimeOfDay(hour: int.parse(othr), minute: int.parse(otmnt));
    }

    TextEditingController surgeryController = TextEditingController(text: (ptDetails?.surgery)??"");
    TextEditingController surgeonNameController = TextEditingController(text: (ptDetails?.surgeonName)??"");
    TextEditingController refferedByController = TextEditingController(text: (ptDetails?.refferedBy)??"");
    TextEditingController surgeryDateController = TextEditingController(text: (ptDetails?.surgeryDate)??"");
    //TextEditingController paymentTypeController = TextEditingController(text: (ptDetails?.));
    TextEditingController hospitalController = TextEditingController(text: (ptDetails?.hospital)??"");
    imagePath = ptDetails?.image.toString() as String;

    return GestureDetector(
      onTap: (){
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: SingleChildScrollView(
        child: Form(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                CustomTextFormField('Sugery', 'Surgery', surgeryController, 'text'),
                SizedBox(height: 10),
                Container(
                  height: 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      border: Border.all(color: Colors.grey)
                  ),
                  child: InkWell(
                    onTap: (){
                      _selectTimeAT(context);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                              child: Center(child: Text('Admission Time',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold
                                ),)),
                            ),

                          Text("${selectedTimeAT.hour}:${selectedTimeAT.minute}",
                            style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold
                            ),
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
                      border: Border.all(color: Colors.grey)
                  ),
                  child: InkWell(
                    onTap: (){
                      _selectTimeOT(context);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                        Container(
                              child: Center(child: Text('OT Time',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold
                                ),)),
                            ),
                          Text("${selectedTimeOT.hour}:${selectedTimeOT.minute}",
                            style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold
                            ),
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
                    labelText: "Surgery Date",
                    hintText: "Surgery Date",
                  ),
                  onTap: () async {
                    var date =  await showDatePicker(
                        context: context,
                        initialDate:DateTime.now(),
                        firstDate: DateTime.now(),
                        lastDate: DateTime(2050));
                    surgeryDateController.text = date.toString().substring(0,10);
                  },
                ),
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
                        ?
                    Container(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(Icons.add_a_photo_outlined,
                            color: AppColor.btnColor,),
                          SizedBox(width: 10),
                          Text("Update Insurence Documents",
                            style: TextStyle(
                                color: AppColor.btnColor
                            ),),
                        ],
                      ),
                    )
                        :
                    Container(child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(Icons.add_link,
                            color: Colors.green),
                        SizedBox(width: 10),
                        Text("Insurence Document Added",
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
                SizedBox(height: 30),
                isLoading ?
                    CircularProgressIndicator()
                :
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        fixedSize: Size(MediaQuery.of(context).size.width - 70, 45),
                        primary: AppColor.btnColor
                    ),
                  onPressed: () async {
                  setState(() {
                    isLoading = true;
                  });
                  var datatosend = {
                    "patientName" : ptDetails?.name,
                    "mobilenumber" : ptDetails?.mobile,
                    "surgery" : surgeryController.text,
                    "admission" : selectedTimeAT,//admissionController.text,
                    "ottime" : selectedTimeOT,//ottimeController.text,
                    "surgeonName" : surgeonNameController.text,
                    "refferedBy" : refferedByController.text,
                    "surgeryDate" : surgeryDateController.text,
                    "hospital" : hospitalController.text,
                    "form" : ""
                  };

                  if(imageFile != null) {
                    imagePath = imageFile!.path;
                    File imagefile = File(imagePath);
                    Uint8List imagebytes = await imagefile.readAsBytes();
                    String base64string = base64.encode(imagebytes);

                    String atTimePass = selectedTimeAT.hour.toString() +':'+ selectedTimeAT.minute.toString();
                    String otTimePass = selectedTimeOT.hour.toString() +':' + selectedTimeOT.minute.toString();
                    updatePatientMoreDetails(
                        id: (ptDetails?.id).toString(),
                        surgery: surgeryController.text,
                        admissionTime: atTimePass,
                        surgeryDate: surgeryDateController.text,
                        ottime: otTimePass,
                        surgeryName: surgeonNameController.text,
                        refferedBy: refferedByController.text,
                        insuranceName: base64string,
                        hospital: hospitalController.text)
                        .then((value) {
                      UpdatePatient addpastient = value;
                      if (addpastient.status == 1) {
                        String msg = addpastient.msg.toString();
                        showAlertDialog(context, msg);
                        String id = ptDetails!.id.toString();
                        String mobile = ptDetails.mobile.toString();
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CareBuddyList(id : id, mobile :mobile),
                            ),
                          );
                        setState(() {
                          isLoading = false;
                        });
                      } else {
                        String msg = addpastient.msg.toString();
                        showAlertDialog(context, msg);
                        Future.delayed(const Duration(seconds: 3), () {
                          Navigator.pop(context);
                        });
                      }
                    });
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar( content: Text("Please upload insurence document.")));
                    setState(() {
                      isLoading = false;
                    });
                  }
                }, child: Text('Submit'))
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget CustomTextFormField(String lbl, String hnt, TextEditingController controller, String type) {
    return TextFormField(
      controller: controller,
      keyboardType: type != "num" ? TextInputType.text : TextInputType.number,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
          border: OutlineInputBorder(), labelText: lbl, hintText: hnt),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter some text';
        }
        return null;
      },
      onChanged: (val) {

      },
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
        atFlag = true;
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
        otFlag = true;
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
      maxWidth: 800,
      maxHeight: 800,
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


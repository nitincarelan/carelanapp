import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:carelan/home/admin/model/patientCurrentStatus.dart';
import 'package:carelan/utils/constant/app_color.dart';
import 'package:carelan/utils/constant/app_url.dart';
import 'package:carelan/utils/constant/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import '../../../utils/constant/appfont.dart';
import '../controller/careBuddyController.dart';
import '../model/updatePtDetailByCBModel.dart';
import 'package:http/http.dart' as http;

class PatientProgressForm extends StatefulWidget {
  //final PatientCurrentStatus leadStatus;
  final String leadId;

  const PatientProgressForm(
     // {Key? key, required this.leadStatus, required this.leadId})
      {Key? key, required this.leadId})
      : super(key: key);

  @override
  _PatientProgressFormState createState() => _PatientProgressFormState();
}

class _PatientProgressFormState extends State<PatientProgressForm> {
  TextEditingController ptRoomController = new TextEditingController();
  TextEditingController otShiftTimeController = new TextEditingController();
  TextEditingController shiftToRoomController = new TextEditingController();
  TextEditingController dischargeTimeController = new TextEditingController();
  TextEditingController billAmountController = new TextEditingController();
  TimeOfDay selectedTimeOTShift = TimeOfDay.now();
  TimeOfDay selectedTimeShiftToRoom = TimeOfDay.now();
  TimeOfDay selectedTimeDischargeTime = TimeOfDay.now();
  ImagePicker picker = ImagePicker();
  PickedFile? pickedImage;
  File? imageFile = null;
  String imagePath = "";
  bool isLoading1 = false;
  bool isLoading2 = false;
  bool setOt = false;
  bool isLoading3 = false;
  bool setShiftToRoom = false;
  bool isLoading4 = false;
  bool setDischarge = false;
  bool isLoading5 = false;
  bool isLoading6 = false;
  bool isLoading7 = false;
  String setDate = "";
  bool setDischargeDate = false;
  String dd = "dd";
  String mm = "mm";
  String yyyy = "yyyy";


  StreamController<PatientCurrentStatus> _patientStatusController =
      StreamController();
  initState() {
    getLeadCount();
  }

  Future<void> getLeadCount() async {
    String url = AppUrl.get_patient_status;
    Map<String, String> body = {"lead_id": widget.leadId};
    http.Response response = await http.post(
      Uri.parse(url),
      body: body,
    );
    final databody = json.decode(response.body);
    PatientCurrentStatus dataModel = PatientCurrentStatus.fromJson(databody);
    return _patientStatusController.sink.add(dataModel);
  }

  @override
  Widget build(BuildContext context) {
    //PatientCurrentStatus leadCurrentStatus = widget.leadStatus as PatientCurrentStatus;

    return GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: Scaffold(
          appBar: Widgets.appBarWidget("Update Patient Details"),
          body: BuildPatientStatusUi(),
        ));
  }

  Widget BuildPatientStatusUi() {
    return StreamBuilder<PatientCurrentStatus>(
        stream: _patientStatusController.stream,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          } else {
            PatientCurrentStatus? leadCurrentStatus = snapshot.data;
            ptRoomController = new TextEditingController(text: leadCurrentStatus!.patientRoomNo ?? "");
            billAmountController = new TextEditingController(text: leadCurrentStatus.billAmount ?? "");
            if (!setOt) {
              List? otTime = (leadCurrentStatus.otShiftingTime ?? '0:0').split(':') as List;
              String othr = otTime[0];
              String otmnt = otTime[1];
              selectedTimeOTShift = TimeOfDay(hour: int.parse(othr), minute: int.parse(otmnt));
            }
            if (!setShiftToRoom) {
              List? shiftToOtTime = (leadCurrentStatus.shiftToRoomTiming ?? '0:0').split(':') as List;
              String stohr = shiftToOtTime[0];
              String stomnt = shiftToOtTime[1];
              selectedTimeShiftToRoom = TimeOfDay(hour: int.parse(stohr), minute: int.parse(stomnt));
            }
            if (!setDischarge) {
              List? dischargeTime = (leadCurrentStatus.discharge ?? '0:0').split(':') as List;
              String dhr = dischargeTime[0];
              String dmnt = dischargeTime[1];
              selectedTimeDischargeTime = TimeOfDay(hour: int.parse(dhr), minute: int.parse(dmnt));
            }
          if(!setDischargeDate) {
            String date = leadCurrentStatus.dischargeDate.toString() == "null" ? "dd-mm-yyyy" : leadCurrentStatus.dischargeDate.toString();
            var dateArr = date.split('-');
            dd = dateArr.toList()[0];
            mm = dateArr.toList()[1];
            yyyy = dateArr.toList()[2];
          }

            return SingleChildScrollView(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                  //border: Border.all(color: Colors.grey)
                ),
                child: Row(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height,
                      width: 40,
                      color: AppColor.appbgColor,
                      child: Column(
                        children: [
                          SizedBox(height: 15),
                          Icon(Icons.verified,
                          color: leadCurrentStatus.patientRoomNoStatus == 1 ? AppColor.clGreen : AppColor.clOrange
                          ),
                          SizedBox(height: 100),
                          Icon(Icons.verified,
                            color: leadCurrentStatus.otShiftingTime == null ? AppColor.clOrange : AppColor.clGreen),
                          SizedBox(height: 80),
                          Icon(Icons.verified,
                            color: leadCurrentStatus.shiftToRoomTiming == null ? AppColor.clOrange : AppColor.clGreen),
                          SizedBox(height: 70),
                          Icon(Icons.verified,
                            color: leadCurrentStatus.discharge == null ? AppColor.clOrange : AppColor.clGreen ),
                          SizedBox(height: 70),
                          Icon(Icons.verified,
                            color: leadCurrentStatus.billAmountStatus ==1 ? AppColor.clGreen : AppColor.clOrange),
                          SizedBox(height: 110),
                          Icon(Icons.verified,
                              color: leadCurrentStatus.billDocStatus == 1 ? AppColor.clGreen : AppColor.clOrange),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Container(
                        height: MediaQuery.of(context).size.height,
                        child: Padding(
                          padding: const EdgeInsets.all(14.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Enter Patient Room no",
                                    style: Font.font500M12(),
                                  ),
                                  SizedBox(height: 5),
                                  TextField(
                                    controller: ptRoomController,
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                      hintText: 'Patient Room no.',
                                      border: OutlineInputBorder(),
                                    ),
                                  ),
                                  SizedBox(height: 5),
                                  isLoading1
                                      ? CircularProgressIndicator()
                                      : SizedBox(
                                    height: 30,
                                    width: 100,
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          primary: AppColor.clOrange),
                                      child: Text(
                                        "Submit",
                                        style:
                                        TextStyle(color: AppColor.clWhite),
                                      ),
                                      onPressed: () {
                                        TextEditingController ptrval =
                                            ptRoomController;
                                        setState(() {
                                          isLoading1 = true;
                                        });
                                        //1
                                        updatePatientDetailByCB(
                                            leadId: leadCurrentStatus.leadId
                                                .toString(),
                                            roomNo: ptRoomController.text)
                                            .then((value) {
                                          UpdatePtDetailsByCB updateRoom =
                                          value as UpdatePtDetailsByCB;
                                          if (updateRoom.status == 1) {
                                            setState(() {
                                              isLoading1 = false;
                                              //ptRoomController = TextField(controller: ptrval);
                                            });
                                           showAlertDialog(
                                                context, "Room Number Updated");
                                            setState(() {
                                              initState();
                                            });
                                          } else {
                                            setState(() {
                                              isLoading1 = false;
                                            });
                                            showAlertDialog(context,
                                                "Room Number not Updated");
                                          }
                                        });
                                      },
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(height: 10),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "OT shifting time",
                                    style: Font.font500M12(),
                                  ),
                                  SizedBox(height: 5),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          _selectTimeOTShiftTime(context);
                                        },
                                        child: Container(
                                          height: 30,
                                          width: 120,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                              BorderRadius.circular(8.0),
                                              border: Border.all(color: Colors.grey)),
                                          child: Center(
                                              child: Text(
                                                'OT Shifting Time',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold),
                                              )),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 30,
                                      ),
                                      Text(
                                        "${selectedTimeOTShift.hour}:${selectedTimeOTShift.minute}",
                                        style: TextStyle(
                                          fontSize: 22,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 5),
                                  isLoading2
                                      ? CircularProgressIndicator()
                                      : SizedBox(
                                    height: 30,
                                    width: 100,
                                    child:
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          primary: leadCurrentStatus.patientRoomNoStatus == 1
                                              ? AppColor.clOrange
                                              : AppColor.clGray
                                      ),
                                      child: Text(
                                        "Submit",
                                        style:
                                        TextStyle(
                                            color: AppColor.clWhite
                                        ),
                                      ),
                                      onPressed: () {
                                        if(leadCurrentStatus.patientRoomNoStatus == 1){
                                        setState(() {
                                          isLoading2 = true;
                                        });
                                        //2
                                        updatePatientOTShiftingTimeByCB(
                                          leadId: leadCurrentStatus.leadId
                                              .toString(),
                                          otShiftTime:
                                          "${selectedTimeOTShift.hour}:${selectedTimeOTShift.minute}",
                                        ).then((value) {

                                          UpdatePtDetailsByCB
                                          updateOTShiftTime =
                                          value as UpdatePtDetailsByCB;
                                          if (updateOTShiftTime.status == 1) {
                                            setState(() {
                                              isLoading2 = false;
                                            });
                                            showAlertDialog(context,
                                                "OT Shifting Time Updated");
                                            setState(() {
                                              initState();
                                            });
                                          } else {
                                            setState(() {
                                              isLoading2 = false;
                                            });
                                            showAlertDialog(context,
                                                "OT Shifting Time not Updated");
                                          }
                                        });
                                        } else {
                                          //print("Enter patient room no first");
                                        }
                                      },
                                    )
                                  )
                                ],
                              ),
                              SizedBox(height: 15),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Shift to Room",
                                    style: Font.font500M12(),
                                  ),
                                  SizedBox(height: 5),
                                  Row(
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          _selectTimeShiftToRoom(context);
                                        },
                                        child: Container(
                                          height: 30,
                                          width: 120,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                              BorderRadius.circular(8.0),
                                              border: Border.all(color: Colors.grey)),
                                          child: Center(
                                              child: Text(
                                                'Shift To Room',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold),
                                              )),
                                        ),
                                      ),
                                      SizedBox(width: 30),
                                      Text(
                                        "${selectedTimeShiftToRoom.hour}:${selectedTimeShiftToRoom.minute}",
                                        style: TextStyle(
                                            fontSize: 22,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 5),
                                  isLoading3
                                      ? CircularProgressIndicator()
                                      : SizedBox(
                                    height: 30,
                                    width: 100,
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          primary:leadCurrentStatus.otShiftingTime == null
                                          ? AppColor.clGray
                                          : AppColor.clOrange
                                      ),
                                      child: Text(
                                        "Submit",
                                        style:
                                        TextStyle(color: AppColor.clWhite),
                                      ),
                                      onPressed: () {
                                        if(leadCurrentStatus.otShiftingTime != null) {
                                          setState(() {
                                            isLoading3 = true;
                                          });
                                          //3
                                          updateShiftToRoomTimeByCB(
                                            leadId: leadCurrentStatus.leadId
                                                .toString(),
                                            shiftToRoomTime:
                                            "${selectedTimeShiftToRoom
                                                .hour}:${selectedTimeShiftToRoom
                                                .minute}",
                                          ).then((value) {
                                            UpdatePtDetailsByCB
                                            updateShiftToRoomTime =
                                            value as UpdatePtDetailsByCB;
                                            if (updateShiftToRoomTime.status ==
                                                1) {
                                              setState(() {
                                                isLoading3 = false;
                                              });
                                              showAlertDialog(context,
                                                  "Shift To Room Time updated");
                                              setState(() {
                                                initState();
                                              });
                                            } else {
                                              setState(() {
                                                isLoading3 = false;
                                              });
                                              showAlertDialog(context,
                                                  "Shift To Room Time not updated");
                                            }
                                          });
                                        } else {
                                         // print("Enter ot shifting time");
                                        }
                                      },
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(height: 15),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Discharge time",
                                    style: Font.font500M12(),
                                  ),
                                  SizedBox(height: 5),
                                  Row(
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          _selectTimeDischarge(context);
                                        },
                                        child: Container(
                                          height: 30,
                                          width: 120,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                              BorderRadius.circular(8.0),
                                              border: Border.all(color: Colors.grey)),
                                          child: Center(
                                              child: Text(
                                                'Discharg Time',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold),
                                              )),
                                        ),
                                      ),
                                      SizedBox(width: 30),
                                      Text(
                                        "${selectedTimeDischargeTime.hour}:${selectedTimeDischargeTime.minute}",
                                        style: TextStyle(
                                            fontSize: 22,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 5),
                                  isLoading4
                                      ? CircularProgressIndicator()
                                      : SizedBox(
                                    height: 30,
                                    width: 100,
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          primary: leadCurrentStatus.shiftToRoomTiming == null
                                          ? AppColor.clGray
                                          : AppColor.clOrange
                                      ),
                                      child: Text(
                                        "Submit",
                                        style:
                                        TextStyle(color: AppColor.clWhite),
                                      ),
                                      onPressed: () {
                                        if(leadCurrentStatus.shiftToRoomTiming != null){
                                        setState(() {
                                          isLoading4 = true;
                                        });
                                        //4
                                        updateDischargeTimeByCB(
                                          leadId: leadCurrentStatus.leadId
                                              .toString(),
                                          discharge:
                                          "${selectedTimeDischargeTime
                                              .hour}:${selectedTimeDischargeTime
                                              .minute}",
                                        ).then((value) {
                                          UpdatePtDetailsByCB
                                          updateDischargeTime =
                                          value as UpdatePtDetailsByCB;
                                          if (updateDischargeTime.status == 1) {
                                            setState(() {
                                              isLoading4 = false;
                                            });
                                            showAlertDialog(context,
                                                "Discharg Time updated");
                                            setState(() {
                                              initState();
                                            });
                                          } else {
                                            setState(() {
                                              isLoading4 = false;
                                            });
                                            showAlertDialog(context,
                                                "Discharg Time not updated");
                                          }
                                        });
                                        } else {
                                          //print('------enter shift to room time');
                                      }
                                      },
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(height: 15),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Discharge date",
                                    style: Font.font500M12(),
                                  ),
                                  SizedBox(height: 5),
                                  Row(
                                    children: [
                                      InkWell(
                                        onTap: () async {
                                          var date =  await showDatePicker(
                                              context: context,
                                              initialDate:DateTime.now(),
                                              firstDate: DateTime.now(),
                                              lastDate: DateTime(2050));

                                          setState(() {
                                            setDischargeDate = true;
                                            setDate =  date.toString().substring(0,10);
                                            var dateArr = setDate.split('-').reversed;
                                            dd = dateArr.toList()[0];
                                            mm = dateArr.toList()[1];
                                            yyyy = dateArr.toList()[2];
                                          });
                                        },
                                        child: Container(
                                          height: 30,
                                          width: 120,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                              BorderRadius.circular(8.0),
                                              border: Border.all(color: Colors.grey)),
                                          child: Center(
                                              child: Text(
                                                'Discharg Date',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold),
                                              )),
                                        ),
                                      ),
                                      SizedBox(width: 30),
                                      Text(
                                        //"${selectedTimeDischargeTime.hour}:${selectedTimeDischargeTime.minute}",
                                        dd+'-'+mm+'-'+yyyy,
                                        style: TextStyle(
                                            fontSize: 22,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 5),
                                  isLoading7
                                      ? CircularProgressIndicator()
                                      : SizedBox(
                                    height: 30,
                                    width: 100,
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          primary: leadCurrentStatus.discharge == null
                                              ? AppColor.clGray
                                              : AppColor.clOrange
                                      ),
                                      child: Text(
                                        "Submit",
                                        style:
                                        TextStyle(color: AppColor.clWhite),
                                      ),
                                      onPressed: () {
                                        if(leadCurrentStatus.discharge != null){
                                          setState(() {
                                            isLoading7 = true;
                                          });
                                          //4
                                          updateDischargeDateByCB(
                                            leadId: leadCurrentStatus.leadId.toString(),
                                            dischargeDate:  dd+'-'+mm+'-'+yyyy,
                                            // "${selectedTimeDischargeTime
                                            //     .hour}:${selectedTimeDischargeTime
                                            //     .minute}",
                                          ).then((value) {
                                            print('value');
                                            UpdatePtDetailsByCB
                                            updateDischargeTime =
                                            value as UpdatePtDetailsByCB;
                                            if (updateDischargeTime.status == 1) {
                                              setState(() {
                                                isLoading7 = false;
                                              });
                                              showAlertDialog(context,
                                                  "Discharg Date updated");
                                              setState(() {
                                                initState();
                                              });
                                            } else {
                                              setState(() {
                                                isLoading7 = false;
                                              });
                                              showAlertDialog(context,
                                                  "Discharg Date not updated");
                                            }
                                          });
                                        } else {
                                          //print('------enter discharge date');
                                        }
                                      },
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(height: 15),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Bill Amount",
                                    style: Font.font500M12(),
                                  ),
                                  SizedBox(height: 5),
                                  TextField(
                                    controller: billAmountController,
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                      hintText: 'Bill Amount',
                                      border: OutlineInputBorder(),
                                    ),
                                  ),
                                  SizedBox(height: 5),
                                  isLoading5
                                      ? CircularProgressIndicator()
                                      : SizedBox(
                                    height: 30,
                                    width: 100,
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          primary: leadCurrentStatus.dischargeDate == null
                                          ? AppColor.clGray
                                          : AppColor.clOrange
                                      ),
                                      child: Text(
                                        "Submit",
                                        style:
                                        TextStyle(color: AppColor.clWhite),
                                      ),
                                      onPressed: () {
                                        if(leadCurrentStatus.dischargeDate != null){
                                        setState(() {
                                          isLoading5 = true;
                                        });
                                        //5
                                        updateBillAmountByCB(
                                            leadId: leadCurrentStatus.leadId
                                                .toString(),
                                            billAmount:
                                            billAmountController.text)
                                            .then((value) {
                                          UpdatePtDetailsByCB updateBillAmount =
                                          value as UpdatePtDetailsByCB;
                                          if (updateBillAmount.status == 1) {
                                            setState(() {
                                              isLoading5 = false;
                                            });
                                            showAlertDialog(
                                                context, "Bill amount Updated");
                                            setState(() {
                                              initState();
                                            });
                                          } else {
                                            setState(() {
                                              isLoading5 = false;
                                            });
                                            showAlertDialog(context,
                                                "Bill amount not Updated");
                                          }
                                        });
                                      } else {
                                          //print("Enter Discharge time first");
                                      }
                                      },
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(height: 15),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  InkWell(
                                    child: Row(
                                      children: [
                                        imageFile == null
                                            ? Row(
                                          children: [
                                            Icon(
                                              Icons.attach_file,
                                              size: 20,
                                            ),
                                            leadCurrentStatus.billDocStatus == 0
                                            ? Text("Upload Bill Document",style: Font.font500M12())
                                            : Text("Docs Uploaded", style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold))
                                          ],
                                        )
                                            : Container(
                                            child: Text(
                                              "Docs Uploaded",
                                              style: TextStyle(
                                                  color: Colors.green,
                                                  fontWeight: FontWeight.bold),
                                            )
                                        ),
                                        SizedBox(
                                          width: 15,
                                        ),
                                      ],
                                    ),
                                    onTap: () {
                                      showModalBottomSheet(
                                        context: context,
                                        builder: ((builder) => bottomSheet()),
                                      );
                                    },
                                  ),
                                  SizedBox(height: 5),
                                  isLoading6
                                      ? CircularProgressIndicator()
                                      : SizedBox(
                                    height: 30,
                                    width: 100,
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          primary: leadCurrentStatus.billAmountStatus == 0
                                          ? AppColor.clGray
                                          : AppColor.clOrange),
                                      child: Text(
                                        "Submit",
                                        style: TextStyle(color: AppColor.clWhite),
                                      ),
                                      onPressed: () async {
                                        if(leadCurrentStatus.billAmountStatus == 1){
                                        setState(() {
                                          isLoading6 = true;
                                        });
                                        //6
                                        imagePath = imageFile!.path;
                                        File imagefile = File(imagePath);
                                        Uint8List imagebytes =
                                        await imagefile.readAsBytes();
                                        String base64string =
                                        base64.encode(imagebytes);
                                        updateBillDocumentByCB(
                                            leadId: leadCurrentStatus.leadId
                                                .toString(),
                                            billDoc: base64string)
                                            .then((value) {
                                          UpdatePtDetailsByCB updateBillDoc =
                                          value as UpdatePtDetailsByCB;
                                          if (updateBillDoc.status == 1) {
                                            setState(() {
                                              isLoading6 = false;
                                            });
                                            showAlertDialog(
                                                context, "Bill Document Updated");
                                          } else {
                                            setState(() {
                                              isLoading6 = false;
                                            });
                                            showAlertDialog(context,
                                                "Bill Document Not Updated");
                                          }
                                        });
                                        } else {
                                          //print('enter bill amount first');
                                        }
                                      },
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
          }
        });
  }
  //);
  //}
  _selectTimeOTShiftTime(BuildContext context) async {
    final TimeOfDay? timeOfDay = await showTimePicker(
      context: context,
      initialTime: selectedTimeOTShift,
      initialEntryMode: TimePickerEntryMode.input,
    );
    if (timeOfDay != null && timeOfDay != selectedTimeOTShift) {
      setState(() {
        selectedTimeOTShift = timeOfDay;
        setOt = true;
      });
    }
  }

  _selectTimeShiftToRoom(BuildContext context) async {
    final TimeOfDay? timeOfDay = await showTimePicker(
      context: context,
      initialTime: selectedTimeShiftToRoom,
      initialEntryMode: TimePickerEntryMode.input,
    );
    if (timeOfDay != null && timeOfDay != selectedTimeShiftToRoom) {

      setState(() {
        selectedTimeShiftToRoom = timeOfDay;
        setShiftToRoom = true;
      });
    }
  }

  _selectTimeDischarge(BuildContext context) async {
    final TimeOfDay? timeOfDay = await showTimePicker(
      context: context,
      initialTime: selectedTimeDischargeTime,
      initialEntryMode: TimePickerEntryMode.input,
    );
    if (timeOfDay != null && timeOfDay != selectedTimeDischargeTime) {

      setState(() {
        selectedTimeDischargeTime = timeOfDay;
        setDischarge = true;
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
        imageFile = File(
          pickedFile.path,
        );
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
// }

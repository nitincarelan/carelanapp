import 'dart:async';
import 'package:carelan/home/admin/model/leadCompletedModel.dart';
import 'package:carelan/home/admin/model/patientCurrentStatus.dart';
import 'package:carelan/utils/constant/app_color.dart';
import 'package:flutter/material.dart';
import '../../../utils/constant/widgets.dart';
import '../controller/adminService.dart';
import 'adminhome.dart';

class CareBuddyStatusForAdmin extends StatefulWidget {
  const CareBuddyStatusForAdmin({Key? key, required this.leadStatus, this.leadid})
      : super(key: key);
  final leadStatus;
  final leadid;

  @override
  State<CareBuddyStatusForAdmin> createState() =>
      _CareBuddyStatusForAdminState();
}

class _CareBuddyStatusForAdminState extends State<CareBuddyStatusForAdmin> {
  int current_step = 5;
  bool isEnable = true;
  bool isloading = false;
  @override
  Widget build(BuildContext context) {
    PatientCurrentStatus statusList = widget.leadStatus;

    List<Step> steps = [
      Step(
          title: Text('Patient Room no'),
          content: Text(statusList.patientRoomNo.toString() != null ?statusList.patientRoomNo.toString() :""),
          subtitle: Text(statusList.patientRoomNo.toString() != "null" && statusList.patientRoomNo.toString() != "" ? statusList.patientRoomNo.toString() : ""),
          isActive: statusList.patientRoomNoStatus == 1 && statusList.patientRoomNo != "null" ? true : false),
      Step(
        title: Text('OT Shifting Time'),
        content: Text(statusList.otShiftingTime.toString()),
        subtitle: Text(statusList.otShiftingTime.toString() != "null" && statusList.otShiftingTime.toString() != "" ? statusList.otShiftingTime.toString() : ""),
        isActive: (statusList.otShiftingTimeStatus == 1 && statusList.otShiftingTime != null) ? true : false,
      ),
      Step(
        title: Text('Shift to Room'),
        content: Text(statusList.shiftToRoomTiming.toString()),
        subtitle: Text(statusList.shiftToRoomTiming.toString() != "null" && statusList.shiftToRoomTiming.toString() != "" ? statusList.shiftToRoomTiming.toString() : ""),
        isActive: (statusList.shiftToRoomTimingStatus == 1 && statusList.shiftToRoomTiming != null) ? true : false,
      ),
      Step(
        title: Text('Discharge'),
        content: Text(statusList.discharge.toString()),
        subtitle: Text(statusList.discharge.toString() != "null" && statusList.discharge.toString() != "" ? statusList.discharge.toString() : ""),
        isActive: (statusList.dischargeStatus == 1 && statusList.discharge != null) ? true : false,
      ),
      Step(
        title: Text('Discharge Date'),
        content: Text(statusList.dischargeDate.toString()),
        subtitle: Text(statusList.dischargeDate.toString() != "null" && statusList.dischargeDate.toString() != "" ? statusList.dischargeDate.toString() : ""),
        isActive: statusList.dischargeDate != null ? true : false,
      ),
      Step(
        title: Text('Bill Amount'),
        content: Text(statusList.billAmount.toString() != "null" && statusList.billAmount.toString() != "" ? statusList.billAmount.toString() : ""),
        subtitle: Text(statusList.billAmount.toString() != "null" && statusList.billAmount.toString() != "" ? statusList.billAmount.toString() : ""),
        state: StepState.complete,
        isActive: statusList.billAmountStatus == 1 ? true : false,
      ),
    ];
    setState(() {
      isEnable = statusList.billDocStatus == 1 ? true : false;
    });

    return Scaffold(
      // Appbar
      appBar: Widgets.appBarWidget("Patient Status"),
      // Body
      body: Container(
        child: Stepper(
          currentStep: this.current_step,
          steps: steps,
          type: StepperType.vertical,
          onStepTapped: (step) {
            setState(() {
              // current_step = step;
            });
          },
          onStepContinue: () {
            setState(() {
              if (current_step < steps.length - 1) {
                //current_step = current_step + 1;
              } else {
                //current_step = 0;
              }
            });
          },
          controlsBuilder: (BuildContext context, ControlsDetails details) {
            return isloading
            ? CircularProgressIndicator()
            :ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: isEnable ? MaterialStateProperty.all(AppColor.clOrange) : MaterialStateProperty.all(Colors.grey),
                ),
                onPressed: () {
                  //leadComleted(leadid: data["lead_id"])
                  setState(() {
                    isloading = true;
                  });
                  isEnable ?
                  leadComleted(leadid: widget.leadid).then((value) {
                    LeadCompleted leadStatus = value;
                    if (leadStatus.status == 1) {
                      setState(() {
                        isloading = false;
                      });
                      Future.delayed(const Duration(seconds: 3), () {
                        Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  AdminHome()),
                              (Route route) => false,
                        );
                      });
                    } else {
                      //String msg = leadStatus.msg.toString();
                      //showAlertDialog(context, msg);
                      Future.delayed(const Duration(seconds: 3), () {
                        Navigator.pop(context);
                      });
                    }
                  }) : "";
                },
                child: Text(
                  "Lead Completed",
                  style: TextStyle(color: AppColor.clWhite),
                ));
          },
        ),
      ),
    );
  }
}

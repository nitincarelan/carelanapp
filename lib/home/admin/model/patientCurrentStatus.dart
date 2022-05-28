class PatientCurrentStatus {
  int? status;
  String? msg;
  String? leadId;
  int? patientRoomNoStatus;
  String? patientRoomNo;
  int? otShiftingTimeStatus;
  String? otShiftingTime;
  int? shiftToRoomTimingStatus;
  String? shiftToRoomTiming;
  int? dischargeStatus;
  String? discharge;
  String? dischargeDate;
  int? billAmountStatus;
  String? billAmount;
  int? billDocStatus;
  String? billDoc;

  PatientCurrentStatus(
      {this.status,
        this.msg,
        this.leadId,
        this.patientRoomNoStatus,
        this.patientRoomNo,
        this.otShiftingTimeStatus,
        this.otShiftingTime,
        this.shiftToRoomTimingStatus,
        this.shiftToRoomTiming,
        this.dischargeStatus,
        this.discharge,
        this.dischargeDate,
        this.billAmountStatus,
        this.billAmount,
        this.billDocStatus,
        this.billDoc});

  PatientCurrentStatus.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    msg = json['msg'];
    leadId = json['lead_id'];
    patientRoomNoStatus = json['patient_room_no_status'];
    patientRoomNo = json['patient_room_no'];
    otShiftingTimeStatus = json['ot_shifting_time_status'];
    otShiftingTime = json['ot_shifting_time'];
    shiftToRoomTimingStatus = json['shift_to_room_timing_status'];
    shiftToRoomTiming = json['shift_to_room_timing'];
    dischargeStatus = json['discharge_status'];
    discharge = json['discharge'];
    dischargeDate = json['discharge_date'];
    billAmountStatus = json['bill_amount_status'];
    billAmount = json['bill_amount'];
    billDocStatus = json['bill_doc_status'];
    billDoc = json['bill_doc'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['msg'] = this.msg;
    data['lead_id'] = this.leadId;
    data['patient_room_no_status'] = this.patientRoomNoStatus;
    data['patient_room_no'] = this.patientRoomNo;
    data['ot_shifting_time_status'] = this.otShiftingTimeStatus;
    data['ot_shifting_time'] = this.otShiftingTime;
    data['shift_to_room_timing_status'] = this.shiftToRoomTimingStatus;
    data['shift_to_room_timing'] = this.shiftToRoomTiming;
    data['discharge_status'] = this.dischargeStatus;
    data['discharge'] = this.discharge;
    data['discharge_date'] = this.dischargeDate;
    data['bill_amount_status'] = this.billAmountStatus;
    data['bill_amount'] = this.billAmount;
    data['bill_doc_status'] = this.billDocStatus;
    data['bill_doc'] = this.billDoc;
    return data;
  }
}
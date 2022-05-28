class GetPaymentDetailsForSergeon {
  int? status;
  String? msg;
  String? net_advance_sum;
  List<LeadDetails>? leadDetails;

  GetPaymentDetailsForSergeon({this.status, this.msg, this.net_advance_sum, this.leadDetails});

  GetPaymentDetailsForSergeon.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    msg = json['msg'];
    net_advance_sum = json['net_advance_sum'];
    if (json['lead_details'] != null) {
      leadDetails = <LeadDetails>[];
      json['lead_details'].forEach((v) {
        leadDetails!.add(new LeadDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['msg'] = this.msg;
    data['net_advance_sum'] = this.net_advance_sum;
    if (this.leadDetails != null) {
      data['lead_details'] = this.leadDetails!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class LeadDetails {
  String? id;
  String? patientName;
  String? mobile;
  String? email;
  String? image;
  String? address;
  String? description;
  String? surgery;
  String? admissionTime;
  String? otTime;
  String? surgeryDate;
  String? surgeonName;
  String? surgeonMobile;
  String? refferedBy;
  String? hospital;
  String? insurance;
  String? insuranceDoc;
  String? billAmount;
  String? billDoc;
  String? bill_submission_date;
  String? mouDisPer;
  String? mouDisRs;
  String? deductions;
  String? netAfterDeduction;
  String? surgeonSharePer;
  String? surgeonShareRs;
  String? tds;
  String? net;
  String? net_advance;
  String? balance;
  String? remark;
  String? status;

  LeadDetails(
      {this.id,
        this.patientName,
        this.mobile,
        this.email,
        this.image,
        this.address,
        this.description,
        this.surgery,
        this.admissionTime,
        this.otTime,
        this.surgeryDate,
        this.surgeonName,
        this.surgeonMobile,
        this.refferedBy,
        this.hospital,
        this.insurance,
        this.insuranceDoc,
        this.billAmount,
        this.billDoc,
        this.bill_submission_date,
        this.mouDisPer,
        this.mouDisRs,
        this.deductions,
        this.netAfterDeduction,
        this.surgeonSharePer,
        this.surgeonShareRs,
        this.tds,
        this.net,
        this.net_advance,
        this.balance,
        this.remark,
        this.status});

  LeadDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    patientName = json['patient_name'];
    mobile = json['mobile'];
    email = json['email'];
    image = json['image'];
    address = json['address'];
    description = json['description'];
    surgery = json['surgery'];
    admissionTime = json['admission_time'];
    otTime = json['ot_time'];
    surgeryDate = json['surgery_date'];
    surgeonName = json['surgeon_name'];
    surgeonMobile = json['surgeon_mobile'];
    refferedBy = json['reffered_by'];
    hospital = json['hospital'];
    insurance = json['insurance'];
    insuranceDoc = json['insurance_doc'];
    billAmount = json['bill_amount'];
    billDoc = json['bill_doc'];
    bill_submission_date = json['bill_submission_date'];
    mouDisPer = json['mou_dis_per'];
    mouDisRs = json['mou_dis_rs'];
    deductions = json['deductions'];
    netAfterDeduction = json['net_after_deduction'];
    surgeonSharePer = json['surgeon_share_per'];
    surgeonShareRs = json['surgeon_share_rs'];
    tds = json['tds'];
    net = json['net'];
    net_advance = json['net_advance'];
    balance = json['balance'];
    remark = json['remark'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['patient_name'] = this.patientName;
    data['mobile'] = this.mobile;
    data['email'] = this.email;
    data['image'] = this.image;
    data['address'] = this.address;
    data['description'] = this.description;
    data['surgery'] = this.surgery;
    data['admission_time'] = this.admissionTime;
    data['ot_time'] = this.otTime;
    data['surgery_date'] = this.surgeryDate;
    data['surgeon_name'] = this.surgeonName;
    data['surgeon_mobile'] = this.surgeonMobile;
    data['reffered_by'] = this.refferedBy;
    data['hospital'] = this.hospital;
    data['insurance'] = this.insurance;
    data['insurance_doc'] = this.insuranceDoc;
    data['bill_amount'] = this.billAmount;
    data['bill_doc'] = this.billDoc;
    data['bill_submission_date'] = this.bill_submission_date;
    data['mou_dis_per'] = this.mouDisPer;
    data['mou_dis_rs'] = this.mouDisRs;
    data['deductions'] = this.deductions;
    data['net_after_deduction'] = this.netAfterDeduction;
    data['surgeon_share_per'] = this.surgeonSharePer;
    data['surgeon_share_rs'] = this.surgeonShareRs;
    data['tds'] = this.tds;
    data['net'] = this.net;
    data['net_advance'] = this.net_advance;
    data['balance'] = this.balance;
    data['remark'] = this.remark;
    data['status'] = this.status;
    return data;
  }
}
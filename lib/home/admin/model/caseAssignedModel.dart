
class CaseAssignedModel {
  int? status;
  String? msg;
  List<ListRecord>? list;

  CaseAssignedModel({this.status, this.msg, this.list});

  CaseAssignedModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    msg = json['msg'];
    if (json['list'] != null) {
      list = <ListRecord>[];
      json['list'].forEach((v) {
        list!.add(new ListRecord.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['msg'] = this.msg;
    if (this.list != null) {
      data['list'] = this.list!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ListRecord {
  String? leadId;
  String? name;
  String? doctorMobile;
  String? city;
  String? fieldWorkerName;
  String? fieldWorkerMobile;
  String? patientname;
  String? patientMobile;

  ListRecord(
      {this.leadId,
        this.name,
        this.doctorMobile,
        this.city,
        this.fieldWorkerName,
        this.fieldWorkerMobile,
        this.patientname,
        this.patientMobile

      });

  ListRecord.fromJson(Map<String, dynamic> json) {
    leadId = json['lead_id'];
    name = json['doctor_name'];
    doctorMobile = json['doctor_mobile'];
    city = json['city'];
    fieldWorkerName = json['field_worker_name'];
    fieldWorkerMobile = json['field_worker_mobile'];
    patientname = json['patient_name'];
    patientMobile = json['patient_mobile'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lead_id'] = this.leadId;
    data['doctor_name'] = this.name;
    data['doctor_mobile'] = this.doctorMobile;
    data['city'] = this.city;
    data['field_worker_name'] = this.fieldWorkerName;
    data['field_worker_mobile'] = this.fieldWorkerMobile;
    data['patient_name'] = this.patientname;
    data['patient_mobile'] = this.patientMobile;
    return data;
  }
}
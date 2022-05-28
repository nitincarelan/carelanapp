class GetSingleLeadDetail {
  int? status;
  String? msg;
  List<LeadDetails>? leadDetails;

  GetSingleLeadDetail({this.status, this.msg, this.leadDetails});

  GetSingleLeadDetail.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    msg = json['msg'];
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
    if (this.leadDetails != null) {
      data['lead_details'] = this.leadDetails!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class LeadDetails {
  String? id;
  String? name;
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
  String? refferedBy;
  String? insuranceDoc;
  String? hospital;
  String? status;

  LeadDetails(
      {this.id,
        this.name,
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
        this.refferedBy,
        this.insuranceDoc,
        this.hospital,
        this.status});

  LeadDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
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
    refferedBy = json['reffered_by'];
    insuranceDoc = json['insurance_doc'];
    hospital = json['hospital'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
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
    data['reffered_by'] = this.refferedBy;
    data['insurance_doc'] = this.insuranceDoc;
    data['hospital'] = this.hospital;
    data['status'] = this.status;
    return data;
  }
}
class AssignedLead {
  int? status;
  String? msg;
  List<AllFieldWorkerLead>? allFieldWorkerLead;

  AssignedLead({this.status, this.msg, this.allFieldWorkerLead});

  AssignedLead.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    msg = json['msg'];
    if (json['all_field_worker_lead'] != null) {
      allFieldWorkerLead = <AllFieldWorkerLead>[];
      json['all_field_worker_lead'].forEach((v) {
        allFieldWorkerLead!.add(new AllFieldWorkerLead.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['msg'] = this.msg;
    if (this.allFieldWorkerLead != null) {
      data['all_field_worker_lead'] =
          this.allFieldWorkerLead!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AllFieldWorkerLead {
  String? id;
  String? name;
  String? mobile;
  String? email;
  String? address;
  String? description;
  String? status;
  String? surgeonName;
  String? hospital;
  String? surgery;
  String? surgeryDate;
  String? admissionTime;
  String? otTime;

  AllFieldWorkerLead(
      {this.id,
        this.name,
        this.mobile,
        this.email,
        this.address,
        this.description,
        this.status,
        this.surgeonName,
        this.hospital,
        this.surgery,
        this.surgeryDate,
        this.admissionTime,
        this.otTime
      });

  AllFieldWorkerLead.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    mobile = json['mobile'];
    email = json['email'];
    address = json['address'];
    description = json['description'];
    status = json['status'];
    surgeonName = json['surgeon_name'];
    hospital = json['hospital'];
    surgery = json['surgery'];
    surgeryDate = json['surgery_date'];
    admissionTime = json['admission_time'];
    otTime = json['ot_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['mobile'] = this.mobile;
    data['email'] = this.email;
    data['address'] = this.address;
    data['description'] = this.description;
    data['status'] = this.status;
    data['surgeon_name'] = this.surgeonName;
    data['hospital'] = this.hospital;
    data['surgery'] = this.surgery;
    data['surgery_date'] = this.surgeryDate;
    data['admission_time'] = this.admissionTime;
    data['ot_time'] = this.otTime;
    return data;
  }
}
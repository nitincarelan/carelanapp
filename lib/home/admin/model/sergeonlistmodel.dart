class SergeonListModel {
  int? status;
  String? msg;
  List<ListRecord>? list;

  SergeonListModel({this.status, this.msg, this.list});

  SergeonListModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    msg = json['msg'];
    if (json['list'] != null) {
      list = <ListRecord>[].cast<ListRecord>();
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
  String? name;
  String? doctorMobile;
  String? city;
  String? totalLeads;
  String? leadid;


  ListRecord({this.name, this.doctorMobile, this.city, this.totalLeads, this.leadid});

  ListRecord.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    doctorMobile = json['doctor_mobile'];
    city = json['city'];
    totalLeads = json['total_leads'];
    leadid = json['lead_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['doctorMobile'] = this.doctorMobile;
    data['city'] = this.city;
    data['totalLeads'] = this.totalLeads;
    data['lead_id'] = this.leadid;
    return data;
  }
}
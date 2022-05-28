class AddPatientModel {
  int? status;
  String? msg;

  AddPatientModel({this.status, this.msg});

  AddPatientModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    msg = json['msg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['msg'] = this.msg;
    return data;
  }
}

class TotalCountModel {
  int? status;
  String? msg;
  int? leadsCount;

  TotalCountModel({this.status, this.msg, this.leadsCount});

  TotalCountModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    msg = json['msg'];
    leadsCount = json['leads_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['msg'] = this.msg;
    data['leads_count'] = this.leadsCount;
    return data;
  }
}

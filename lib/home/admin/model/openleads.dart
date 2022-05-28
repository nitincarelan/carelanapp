class OpenLeadModel {
  int? status;
  String? msg;
  List<AllLeads>? allLeads;

  OpenLeadModel({this.status, this.msg, this.allLeads});

  OpenLeadModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    msg = json['msg'];
    if (json['all_leads'] != null) {
      allLeads = <AllLeads>[];
      json['all_leads'].forEach((v) {
        allLeads!.add(new AllLeads.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['msg'] = this.msg;
    if (this.allLeads != null) {
      data['all_leads'] = this.allLeads!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AllLeads {
  String? id;
  String? name;
  String? mobile;
  String? email;
  String? image;
  String? address;
  String? description;
  String? status;

  AllLeads(
      {this.id,
        this.name,
        this.mobile,
        this.email,
        this.image,
        this.address,
        this.description,
        this.status});

  AllLeads.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    mobile = json['mobile'];
    email = json['email'];
    image = json['image'];
    address = json['address'];
    description = json['description'];
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
    data['status'] = this.status;
    return data;
  }
}

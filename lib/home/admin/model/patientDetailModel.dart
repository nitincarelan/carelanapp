class PatientDetailModel {
  String? id;
  String? name;
  String? mobile;
  String? email;
  String? image;
  String? address;
  String? description;
  String? status;

  PatientDetailModel(
      {this.id,
        this.name,
        this.mobile,
        this.email,
        this.image,
        this.address,
        this.description,
        this.status});

  PatientDetailModel.fromJson(Map<String, dynamic> json) {
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
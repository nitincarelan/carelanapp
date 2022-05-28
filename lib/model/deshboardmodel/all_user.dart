class AllUser {
  String? status;
  List<UserDetails>? userDetails;

  AllUser({this.status, this.userDetails});

  AllUser.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['user_details'] != null) {
      userDetails = <UserDetails>[];
      json['user_details'].forEach((v) {
        userDetails!.add(new UserDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.userDetails != null) {
      data['user_details'] = this.userDetails!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class UserDetails {
  String? id;
  String? userType;
  String? userTypeName;
  String? name;
  String? email;
  String? mobile;
  String? address;
  String? status;

  UserDetails(
      {this.id,
        this.userType,
        this.userTypeName,
        this.name,
        this.email,
        this.mobile,
        this.address,
        this.status});

  UserDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userType = json['user_type'];
    userTypeName = json['user_type_name'];
    name = json['name'];
    email = json['email'];
    mobile = json['mobile'];
    address = json['address'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_type'] = this.userType;
    data['user_type_name'] = this.userTypeName;
    data['name'] = this.name;
    data['email'] = this.email;
    data['mobile'] = this.mobile;
    data['address'] = this.address;
    data['status'] = this.status;
    return data;
  }
}

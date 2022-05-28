class VerifyOTPModel {
  UserData? userData;
  int? status;
  int? loginStatus;
  String? msg;

  VerifyOTPModel({this.userData, this.status, this.loginStatus, this.msg});

  VerifyOTPModel.fromJson(Map<String, dynamic> json) {
    userData = json['user_data'] != null
        ? new UserData.fromJson(json['user_data'])
        : null;
    status = json['status'];
    loginStatus = json['login_status'];
    msg = json['msg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.userData != null) {
      data['user_data'] = this.userData!.toJson();
    }
    data['status'] = this.status;
    data['login_status'] = this.loginStatus;
    data['msg'] = this.msg;
    return data;
  }
}

class UserData {
  String? id;
  String? userType;
  String? userTypeName;
  String? name;
  String? email;
  String? mobile;

  UserData(
      {this.id,
        this.userType,
        this.userTypeName,
        this.name,
        this.email,
        this.mobile});

  UserData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userType = json['user_type'];
    userTypeName = json['user_type_name'];
    name = json['name'];
    email = json['email'];
    mobile = json['mobile'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_type'] = this.userType;
    data['user_type_name'] = this.userTypeName;
    data['name'] = this.name;
    data['email'] = this.email;
    data['mobile'] = this.mobile;
    return data;
  }
}

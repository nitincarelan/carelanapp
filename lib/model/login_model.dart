class LoginByMobileModel {
  int? status;
  String? msg;

  LoginByMobileModel({this.status, this.msg});

  LoginByMobileModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    msg = json['msg'];
  }
}

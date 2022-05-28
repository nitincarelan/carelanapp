class UpdateUserProfileImage {
  int? status;
  String? msg;
  String? imagePath;

  UpdateUserProfileImage({this.status, this.msg, this.imagePath});

  UpdateUserProfileImage.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    msg = json['msg'];
    imagePath = json['image_path'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['msg'] = this.msg;
    data['image_path'] = this.imagePath;
    return data;
  }
}

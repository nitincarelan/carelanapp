class UserProfile {
  String? status;
  UserDetails? userDetails;

  UserProfile({this.status, this.userDetails});

  UserProfile.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    userDetails = json['user_details'] != null
        ? new UserDetails.fromJson(json['user_details'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.userDetails != null) {
      data['user_details'] = this.userDetails?.toJson();
    }
    return data;
  }
}

class UserDetails {
  String? id;
  String? userType;
  String? userTypeName;
  String? name;
  String? speciality;
  String? practiceSince;
  String? certificate;
  String? email;
  String? mobile;
  String? profilePic;

  UserDetails(
      {this.id,
        this.userType,
        this.userTypeName,
        this.name,
        this.speciality,
        this.practiceSince,
        this.certificate,
        this.email,
        this.mobile,
        this.profilePic});

  UserDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userType = json['user_type'];
    userTypeName = json['user_type_name'];
    name = json['name'];
    speciality = json['speciality'];
    practiceSince = json['practice_since'];
    certificate = json['certificate'];
    email = json['email'];
    mobile = json['mobile'];
    profilePic = json['profile_pic'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_type'] = this.userType;
    data['user_type_name'] = this.userTypeName;
    data['name'] = this.name;
    data['speciality'] = this.speciality;
    data['practice_since'] = this.practiceSince;
    data['certificate'] = this.certificate;
    data['email'] = this.email;
    data['mobile'] = this.mobile;
    data['profile_pic'] = this.profilePic;
    return data;
  }
}

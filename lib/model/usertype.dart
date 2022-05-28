class UserType {
  int? status;
  String? msg;
  List<UserTypes>? userTypes;

  UserType({this.status, this.msg, this.userTypes});

  UserType.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    msg = json['msg'];
    if (json['user_types'] != null) {
      userTypes = <UserTypes>[];
      json['user_types'].forEach((v) {
        userTypes!.add(new UserTypes.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['msg'] = this.msg;
    if (this.userTypes != null) {
      data['user_types'] = this.userTypes!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class UserTypes {
  String? id;
  String? name;
  String? status;
  String? createdAt;
  String? updatedAt;

  UserTypes({this.id, this.name, this.status, this.createdAt, this.updatedAt});

  UserTypes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
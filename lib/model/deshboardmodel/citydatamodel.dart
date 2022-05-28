class CityModel {
  int? status;
  String? msg;
  List<AllCity>? allCity;

  CityModel({this.status, this.msg, this.allCity});

  CityModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    msg = json['msg'];
    if (json['all_city'] != null) {
      allCity = <AllCity>[];
      json['all_city'].forEach((v) {
        allCity!.add(new AllCity.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['msg'] = this.msg;
    if (this.allCity != null) {
      data['all_city'] = this.allCity!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AllCity {
  String? id;
  String? cityName;
  String? status;

  AllCity({this.id, this.cityName, this.status});

  AllCity.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    cityName = json['city_name'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['city_name'] = this.cityName;
    data['status'] = this.status;
    return data;
  }
}
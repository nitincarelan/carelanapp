import 'dart:convert';
import 'dart:io';
import 'package:carelan/model/login_model.dart';
import 'package:carelan/model/registermodel.dart';
import 'package:carelan/model/user_profile_model.dart';
import 'package:carelan/model/usertype.dart';
import 'package:carelan/model/verify_otp_model.dart';
import 'package:carelan/utils/constant/app_url.dart';
import 'package:http/http.dart' as http;
import '../model/deshboardmodel/addpatientmodel.dart';
import '../model/deshboardmodel/citydatamodel.dart';

Future<LoginByMobileModel> fetchOtp({
  required String mobile,
}) async {
  Map<String, String> body = {
    'mobile': mobile,
  };
  http.Response response = await http.post(
    Uri.parse(AppUrl.sendOtp),
    body: body,
  );

  if (response.statusCode == 200) {
    return LoginByMobileModel.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load');
  }
}

Future<VerifyOTPModel> verifyOtp({
  required String mobile,
  required String otp,
}) async {
  Map<String, String> body = {
    'mobile': mobile,
    'otp': otp,
  };
  http.Response response = await http.post(
    Uri.parse(AppUrl.verify),
    body: body,
  );

  if (response.statusCode == 200) {
    return VerifyOTPModel.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load');
  }
}

Future<UserType> getUserType() async {
  http.Response response = await http.get(Uri.parse(AppUrl.getUserType));
  if (response.statusCode == 200) {
    return UserType.fromJson(jsonDecode(response.body));
    // return UserType.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load user type');
  }
}
//getCityList
Future<CityModel> getAllCity() async {
  http.Response response = await http.get(Uri.parse(AppUrl.getAllCity));
  if(response.statusCode == 200) {
    return CityModel.fromJson(jsonDecode(response.body));
  } else {
    throw Exception("Failed to load city");
  }
}

Future<UserRegisterModel> register({
  required String user_type, name, email, mobile, id, required String cityid
}) async {
  Map<String, String> body = {
    'user_type': user_type,
    'name': name,
    'email': email,
    'mobile': mobile,
    //'address': address,
    'city_id' : cityid
  };

  http.Response response = await http.post(
    Uri.parse(AppUrl.userRegister),
    body: body,
  );

  if (response.statusCode == 200) {
    return UserRegisterModel.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load');
  }
}

Future<AddPatientModel> addPatient({
required String name, addedby, mobile, image, description, required File pdffile
}) async {
  Map<String, dynamic> body = {
    'added_by': addedby,
    'name': name,
    'mobile' : mobile,
    'image' : image,
    'description' : description,
    'file' : pdffile
  };

  http.Response response = await http.post(
    Uri.parse(AppUrl.add_patient),
    body: body,
  );

  if (response.statusCode == 200) {
    return AddPatientModel.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load');
  }
}

Future<TotalCountModel> leadCount({
  required addedby,
}) async {

  Map<String, String> body = {
    'added_by': addedby,
  };
  http.Response response = await http.post(
    Uri.parse(AppUrl.leadCount),
    body: body,
  );

  if (response.statusCode == 200) {
    return TotalCountModel.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load');
  }
}

Future<UserProfile> getUserProfile({

  required String mobile,
}) async {

  Map<String, String> body = {
    'mobile': mobile,
  };

 http.Response response = await http.post(
    Uri.parse(AppUrl.userProfile),
    body: body,
  );

  if (response.statusCode == 200) {
    return UserProfile.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load');
  }
}

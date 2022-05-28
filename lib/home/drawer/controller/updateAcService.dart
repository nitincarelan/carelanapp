import 'dart:convert';
import '../../../utils/constant/app_url.dart';
import '../model/profileImageUpdate.dart';
import '../model/updateAcountModel.dart';
import 'package:http/http.dart' as http;

Future<UpdateDoctorAccount> updteDoctorProfile({
  required String mobile,
  required String speciality,
  required String practice_since,
  required String certificate,
}) async {
  Map<String, String> body = {
    'mobile': mobile,
    'speciality' : speciality,
    'practice_since' : practice_since,
    'certificate' : certificate
  };
  http.Response response = await http.post(
    Uri.parse(AppUrl.updateAccount),
   body: body,
  );
  if (response.statusCode == 200) {
    return UpdateDoctorAccount.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load');
  }
}

//Update profile pic

Future<UpdateUserProfileImage> updateProfilePic({
  required String mobile,
  required String image,
}) async {
  Map<String, String> body = {
    'mobile': mobile,
    'image' : image,
  };
  http.Response response = await http.post(
    Uri.parse(AppUrl.updateProfilePic),
    body: body,
  );
  if (response.statusCode == 200) {
    return UpdateUserProfileImage.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load');
  }
}
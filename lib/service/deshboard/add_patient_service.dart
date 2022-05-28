import 'dart:convert';
import 'package:carelan/utils/constant/app_url.dart';
import '../../home/doctor/view/addPatient.dart';
import 'package:http/http.dart' as http;
import '../../model/deshboardmodel/addpatientmodel.dart';
// Future<AddPatientModel> addPatient({
//   //required String user_type, name, email, mobile, address
//   required name, addedby, email, mobile, address, image, description
// }) async {
//   Map<String, String> body = {
//     'added_by': addedby,
//     'name': name,
//     'mobile' : mobile,
//     'email' : email,
//     'image' : image,
//     'address' : address,
//     'description' : description
//   };
//
//   http.Response response = await http.post(
//     Uri.parse(AppUrl.add_patient),
//     body: body,
//   );
//
//   if (response.statusCode == 200) {
//     return AddPatientModel.fromJson(jsonDecode(response.body));
//   } else {
//     throw Exception('Failed to load');
//   }
// }



import 'dart:convert';
import 'package:carelan/model/deshboardmodel/all_user.dart';
import 'package:carelan/utils/constant/app_url.dart';
import 'package:http/http.dart' as http;

Future<AllUser> getAllUser() async {
  http.Response response = await http.get(Uri.parse(AppUrl.getalluserprofile));
  if (response.statusCode == 200) {
    final databody = json.decode(response.body);
    AllUser allUser = new AllUser.fromJson(databody);
    return allUser;
  } else {
    throw Exception('Failed to load post');
  }
}

import 'dart:convert';

import 'package:carelan/model/deshboardmodel/approverejectmodel.dart';
import 'package:carelan/utils/constant/app_url.dart';
import 'package:http/http.dart' as http;

Future<ApproveUser> approveUser({
  required String mobile,
}) async {
  Map<String, String> body = {
    'mobile': mobile,
  };
  http.Response response = await http.post(
    Uri.parse(AppUrl.approve_user_profile),
    body: body,
  );
  if (response.statusCode == 200) {
    return ApproveUser.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load');
  }
}

Future<RejectUser> rejectUser({
  required String mobile,
}) async {
  Map<String, String> body = {
    'mobile' : mobile
  };

  http.Response response = await http.post(
    Uri.parse(AppUrl.reject_user_profile),
      body: body,
  );

  if(response.statusCode == 200) {
    return RejectUser.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Faild to load');
  }

}
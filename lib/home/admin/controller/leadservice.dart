import 'dart:convert';

import '../../../utils/constant/app_url.dart';
import '../model/newleads.dart';
import 'package:http/http.dart' as http;

  Future<NewLeadModel> getAllNewLead({
    required String addedby,
  }) async {
    Map<String, String> body = {
      'added_by': addedby,
    };

    http.Response response = await http.post(
      Uri.parse(AppUrl.getAllLeads),
      body: body,
    );

    //print(response.body);
    if (response.statusCode == 200) {
      return NewLeadModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load');
    }
  }
import 'dart:convert';
import 'package:carelan/home/admin/model/addHospitalModel.dart';
import 'package:carelan/home/admin/model/assignLeadToFieldWorkerModel.dart';
import 'package:carelan/home/admin/model/singleLeadDetailModel.dart';

import '../../../utils/constant/app_url.dart';
import '../model/PatientUpdate.dart';
import 'package:http/http.dart' as http;

import '../model/leadCompletedModel.dart';
import '../model/patientCurrentStatus.dart';

Future<UpdatePatient> updatePatientMoreDetails({
  //required String user_type, name, email, mobile, address
  required String id, surgery, admissionTime, surgeryDate, ottime, surgeryName, refferedBy, insuranceName, hospital, paymentType
}) async {
  Map<String, String> body = {
    'lead_id' : id,
    'surgery' : surgery,
    'admission_time' : admissionTime,
    'surgery_date' : surgeryDate,
    'ot_time' : ottime,
    'surgeon_name' : surgeryName,
    'reffered_by' : refferedBy,
    //'payment_type' : '',//paymentType,
    'insurance_doc' : insuranceName,
    'hospital' : hospital,
  };

  http.Response response = await http.post(
    Uri.parse(AppUrl.updateLeadDetails),
    body: body,
  );

  if (response.statusCode == 200) {
    return UpdatePatient.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load');
  }
}

Future<AssignLeadToFieldWorker> leadAssignedtoFieldWorker({
  required String leadid, usermobile
}) async {
  Map<String, String> body = {
    'lead_id' : leadid,
    'user_mobile' : usermobile
  };

  http.Response response = await http.post(
    Uri.parse(AppUrl.assignLeadToFieldWorker),
    body: body,
  );

  if (response.statusCode == 200) {
    return AssignLeadToFieldWorker.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load');
  }
}
// get Sigle Lead Detail for open Status

Future<GetSingleLeadDetail> getSigleLeadDetail({
  required String leadid
}) async {
  Map<String, String> body = {
    'lead_id' : leadid,
  };

  http.Response response = await http.post(
    Uri.parse(AppUrl.getSigleLeadDetails),
    body: body,
  );

  if (response.statusCode == 200) {
    return GetSingleLeadDetail.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load');
  }
}

Future<PatientCurrentStatus> getPtCurrentStatus({
  required String leadid
}) async {
  Map<String, String> body = {
    'lead_id' : leadid,
  };

  http.Response response = await http.post(
    Uri.parse(AppUrl.get_patient_status),
    body: body,
  );

  if (response.statusCode == 200) {
    return PatientCurrentStatus.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load');
  }
}

Future<LeadCompleted> leadComleted({
  required String leadid
}) async {
  Map<String, String> body = {
    'lead_id' : leadid,
  };

  http.Response response = await http.post(
    Uri.parse(AppUrl.leadCompleted),
    body: body,
  );

  if (response.statusCode == 200) {
    return LeadCompleted.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load');
  }
}

Future<AddHospital> addHospital({
  required String hname, cityId
}) async {
  Map<String, String> body = {
    'hospital_name' : hname,
    'city_id' : cityId
  };

  http.Response response = await http.post(
    Uri.parse(AppUrl.addHospital),
    body: body,
  );

  if (response.statusCode == 200) {
    return AddHospital.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load');
  }
}
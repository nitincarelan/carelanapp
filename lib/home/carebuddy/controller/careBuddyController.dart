import 'dart:convert';
import '../../../utils/constant/app_url.dart';
import '../../admin/model/patientCurrentStatus.dart';
import '../model/updatePtDetailByCBModel.dart';
import 'package:http/http.dart' as http;

// 1. Patient Room No update
Future<UpdatePtDetailsByCB> updatePatientDetailByCB({
  required String leadId, roomNo
}) async {
  Map<String, String> body = {
    'lead_id' : leadId,
    'patient_room_no' : roomNo
  };

  http.Response response = await http.post(
    Uri.parse(AppUrl.updatePatientRoomNo),
    body: body,
  );

  if (response.statusCode == 200) {
    return UpdatePtDetailsByCB.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load');
  }
}
// 2. Patient OT Shifting time
Future<UpdatePtDetailsByCB> updatePatientOTShiftingTimeByCB({
  required String leadId, otShiftTime
}) async {
  Map<String, String> body = {
    'lead_id' : leadId,
    'ot_shifting_time' : otShiftTime
  };

  http.Response response = await http.post(
    Uri.parse(AppUrl.updateOtShiftingTime),
    body: body,
  );

  if (response.statusCode == 200) {
    return UpdatePtDetailsByCB.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load');
  }
}

// 3. Patient shifting to room time
Future<UpdatePtDetailsByCB> updateShiftToRoomTimeByCB({
  required String leadId, shiftToRoomTime
}) async {
  Map<String, String> body = {
    'lead_id' : leadId,
    'shift_to_room_timing' : shiftToRoomTime
  };

  http.Response response = await http.post(
    Uri.parse(AppUrl.updateShiftToRoomTime),
    body: body,
  );

  if (response.statusCode == 200) {
    return UpdatePtDetailsByCB.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load');
  }
}

// 4. Update Discharge time by Care Buddy
Future<UpdatePtDetailsByCB> updateDischargeTimeByCB({
  required String leadId, discharge
}) async {
  Map<String, String> body = {
    'lead_id' : leadId,
    'discharge' : discharge
  };

  http.Response response = await http.post(
    Uri.parse(AppUrl.updtaeDischargeTime),
    body: body,
  );

  if (response.statusCode == 200) {
    return UpdatePtDetailsByCB.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load');
  }
}


// 5. Update Discharge date by Care Buddy
Future<UpdatePtDetailsByCB> updateDischargeDateByCB({
  required String leadId, dischargeDate
}) async {
  Map<String, String> body = {
    'lead_id' : leadId,
    'discharge_date' : dischargeDate
  };

  http.Response response = await http.post(
    Uri.parse(AppUrl.UpdateDischargeDate),
    body: body,
  );

  if (response.statusCode == 200) {
    return UpdatePtDetailsByCB.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load');
  }
}

// 6. Update BillAmount by Care Buddy
Future<UpdatePtDetailsByCB> updateBillAmountByCB({
  required String leadId, billAmount
}) async {
  Map<String, String> body = {
    'lead_id' : leadId,
    'bill_amount' : billAmount
  };

  http.Response response = await http.post(
    Uri.parse(AppUrl.updateBillAmount),
    body: body,
  );

  if (response.statusCode == 200) {
    return UpdatePtDetailsByCB.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load');
  }
}

// 7. Update BillAmount Document by Care Buddy
Future<UpdatePtDetailsByCB> updateBillDocumentByCB({
  required String leadId, billDoc
}) async {
  Map<String, String> body = {
    'lead_id' : leadId,
    'bill_doc' : billDoc
  };

  http.Response response = await http.post(
    Uri.parse(AppUrl.updateBillDoc),
    body: body,
  );

  if (response.statusCode == 200) {
    return UpdatePtDetailsByCB.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load');
  }
}

Future<PatientCurrentStatus> getStatusDetails({
  required String leadId
}) async {
  Map<String, String> body = {
    "lead_id" : leadId
  };

  http.Response response = await http.post(
    Uri.parse(AppUrl.get_patient_status),
    body: body
  );
  if(response.statusCode == 200){
    return PatientCurrentStatus.fromJson(jsonDecode(response.body));
  } else {
    throw Exception("Failed to load");
  }
}

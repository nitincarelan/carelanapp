import 'dart:convert';
import '../../../utils/constant/app_url.dart';
import '../model/updateLeadAccount.dart';
import 'package:http/http.dart' as http;

Future<UpdateLeadAcount> updatePayment({
  required String leadid,
  patientname,
    hospital,
    insurance,
    billamount,
    moudisper,
    moudisrs,
    deductions,
    netafterdeduction,
    surgeonshareper,
    surgeonsharers,
    tds,
    netAdvance,
    net,
    balance,
    remark,
  }) async {
  Map<String, String> body = {
    "lead_id" : leadid,
    "patient_name": patientname,
    "hospital": hospital,
    "insurance": insurance,
    "bill_amount": billamount,
    "mou_dis_per": moudisper,
    "mou_dis_rs": moudisrs,
    "deductions": deductions,
    "net_after_deduction": netafterdeduction,
    "surgeon_share_per": surgeonshareper,
    "surgeon_share_rs": surgeonsharers,
    "tds": tds,
    "net_advance" : netAdvance,
    "net": net,
    "balance": balance,
    "remark": remark
  };

  http.Response response = await http.post(
    Uri.parse(AppUrl.updateAccountDetail),
    body: body,
  );

  if (response.statusCode == 200) {
    return UpdateLeadAcount.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load');
  }
}

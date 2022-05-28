import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import '../../../utils/constant/app_color.dart';
import '../../../utils/constant/app_url.dart';
import '../../../utils/constant/widgets.dart';
import 'package:http/http.dart' as http;
import '../../admin/controller/adminService.dart';
import '../../admin/model/openleads.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../admin/model/sergeonlistmodel.dart';
import '../../admin/model/singleLeadDetailModel.dart';
import '../../admin/view/editPatientDetailsForAdmin.dart';
import 'insurenceDocument.dart';

class InsurenceOpenLead extends StatefulWidget {
  const InsurenceOpenLead({Key? key}) : super(key: key);

  @override
  _InsurenceOpenLeadState createState() => _InsurenceOpenLeadState();
}

class _InsurenceOpenLeadState extends State<InsurenceOpenLead> {
  StreamController<SergeonListModel> _sergeonstreamController =
  StreamController();
  late SharedPreferences? logindata;
  bool isLoding = false;

  @override
  void initState() {
    // TODO: implement initState
    getSurgeonList();
    super.initState();
  }

  Future<void> getSurgeonList() async {
    try {
      String url = AppUrl.getOpenLeadSergeonList;
      http.Response response = await http.get(Uri.parse(url));
      final databody = json.decode(response.body);
      SergeonListModel dataModel = SergeonListModel.fromJson(databody);
      return _sergeonstreamController.sink.add(dataModel);
    } catch (Exception) {
      print(Exception);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Widgets.appBarWidget("Insurence Open Lead"),
      body: StreamBuilder<SergeonListModel>(
          stream: _sergeonstreamController.stream,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            } else {
              SergeonListModel datalist = snapshot.data! as SergeonListModel;
              int? count = datalist.list?.length;

              return
                //   isLoding ?
                // Center(child: CircularProgressIndicator())
                // :
                ListView.builder(
                    itemCount: count,
                    itemBuilder: (context, index) {
                      var data = datalist.list
                          ?.map((e) => e.toJson())
                          .toList()[index];
                      int caseNumber = index + 1;
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          child: Container(
                            height: 60,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.0),
                                border:
                                Border.all(color: AppColor.primaryColor)),
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Case $caseNumber " +
                                            (data!["name"] ?? ""),
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(width: 10),
                                      Text(
                                        data["city"] ?? "",
                                        style: TextStyle(
                                          fontSize: 16,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          onTap: () async {
                            setState(() {
                              isLoding = true;
                            });
                            logindata = await SharedPreferences.getInstance();
                            logindata?.setString(
                                "patientMobileNumber", data["doctorMobile"]);
                            logindata?.setString("sergeonName", data["name"]);
                            //(data["lead_id"]).toString()
                            getSigleLeadDetail(leadid: data["lead_id"])
                                .then((value) {
                              GetSingleLeadDetail assignLead = value;

                              if (assignLead.status == 1) {
                                setState(() {
                                  isLoding = false;
                                });
                                Future.delayed(const Duration(seconds: 1),
                                        () {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  InsurnceDoumentViewer(
                                                      datalist: assignLead
                                                          .leadDetails)));
                                    });
                              } else {
                                String msg = assignLead.msg.toString();
                                showAlertDialog(context, msg);
                                Future.delayed(const Duration(seconds: 3),
                                        () {
                                      Navigator.pop(context);
                                    });
                              }
                            });
                          },
                        ),
                      );
                    });
            }
          }),
    );
  }

  void showAlertDialog(BuildContext context, String msg) {
    // Create button
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    // Create AlertDialog
    AlertDialog alert = AlertDialog(
      //title: Text("Simple Alert"),
      content: Text(msg),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}

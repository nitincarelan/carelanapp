import 'dart:async';
import 'dart:convert';
import 'dart:ui';

import 'package:carelan/utils/constant/app_color.dart';
import 'package:carelan/utils/constant/app_url.dart';
import 'package:carelan/utils/constant/component.dart';
import 'package:carelan/utils/constant/widgets.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../utils/constant/appfont.dart';
import '../controller/adminService.dart';
import '../model/sergeonlistmodel.dart';
import 'package:http/http.dart' as http;
import '../model/singleLeadDetailModel.dart';
import 'editPatientDetailsForAdmin.dart';

class OpenLeadSergeonList extends StatefulWidget {
  @override
  State<OpenLeadSergeonList> createState() => _OpenLeadSergeonListState();
}

class _OpenLeadSergeonListState extends State<OpenLeadSergeonList> {
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
    String path = "https://upload.wikimedia.org/wikipedia/commons/b/b9/Youtube_loading_symbol_1_(wobbly).gif";

    return Scaffold(
      appBar: Widgets.appBarWidget("Surgeons open lead"),
      body: StreamBuilder<SergeonListModel>(
          stream: _sergeonstreamController.stream,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            } else {
              SergeonListModel datalist = snapshot.data! as SergeonListModel;
              if(datalist.status != 0) {
                int? count = datalist.list?.length;
                return ListView.builder(
                      itemCount: count,
                      itemBuilder: (context, index) {
                        int decIndex = count! - (index + 1);
                        var data = datalist.list
                            ?.map((e) => e.toJson())
                            .toList()[decIndex];
                        int caseNumber = index + 1;
                        return isLoding ?
                        BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 0.5,sigmaY: 0.5),
                          child: Container(
                            height: MediaQuery.of(context).size.height,
                            width: MediaQuery.of(context).size.width,
                            child: CircleAvatar(
                                minRadius: 10,
                                backgroundColor: Colors.transparent,
                                child: CircularProgressIndicator()
                            ),
                          ),
                        )
                            :
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                            child: Container(
                              //height: 60,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8.0),
                                  // border: Border.all(color: isLoding ? AppColor.appbgColor : AppColor.btnColor)
                                  border: Border.all(color: Colors.black12)
                            ),
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Case $caseNumber ",
                                          style: TextStyle(
                                            color: AppColor.btnColor
                                          ),
                                        ),
                                        SizedBox(width: 10),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(data!["name"] ?? "",
                                                  style: Font.font600B17(),
                                            ),
                                            Text(
                                              data["city"] ?? "",
                                              style: Font.font500M10(),
                                            ),
                                          ],
                                        ),
                                        SizedBox(width: 10),
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
                              logindata?.setString("patientMobileNumber", data["doctorMobile"]);
                              logindata?.setString("surgeonName", data["name"]);
                              //(data["lead_id"]).toString()
                              getSigleLeadDetail(leadid: data["lead_id"])
                                  .then((value) {
                                GetSingleLeadDetail assignLead = value;

                                if (assignLead.status == 1) {
                                  setState(() {
                                    isLoding = false;
                                  });
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    EditPatientDetailforAdmin(
                                                        datalist: assignLead
                                                            .leadDetails)));
                                        // setState(() {
                                        //   isLoding = false;
                                        // });
                                } else {
                                  String msg = assignLead.msg.toString();
                                  showAlertDialog(context, msg);
                                        Navigator.pop(context);
                                }
                              });
                            },
                          ),
                        );
                      });
              } else {
                return gui.dataNotFound();
              }
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

class CircleBlurPainter {
}

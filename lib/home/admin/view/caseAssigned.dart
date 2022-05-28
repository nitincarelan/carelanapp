import 'dart:async';
import 'dart:convert';
import 'dart:ui';
import 'package:carelan/utils/constant/component.dart';
import 'package:carelan/utils/constant/widgets.dart';
import 'package:flutter/material.dart';
import '../../../utils/constant/app_color.dart';
import '../../../utils/constant/app_url.dart';
import 'package:http/http.dart' as http;
import '../../../utils/constant/appfont.dart';
import '../controller/adminService.dart';
import '../model/caseAssignedModel.dart';
import '../model/patientCurrentStatus.dart';
import 'careBuddyStatus.dart';

class CaseAssigned extends StatefulWidget {
  const CaseAssigned({Key? key}) : super(key: key);

  @override
  _CaseAssignedState createState() => _CaseAssignedState();
}

class _CaseAssignedState extends State<CaseAssigned> {
  StreamController<CaseAssignedModel> _assignedCasetreamController = StreamController();
  bool isLoading = false;
  bool _isLoaderVisible = false;
  //late SharedPreferences? logindata;
  @override
  void initState() {
    // TODO: implement initState
    getCaseAssignList();
    super.initState();
  }

  Future<void> getCaseAssignList() async {
    try {
      String url = AppUrl.caseAssignedList;
      http.Response response = await http.get(Uri.parse(url));
      final databody = json.decode(response.body);
      CaseAssignedModel dataModel = CaseAssignedModel.fromJson(databody);
      return _assignedCasetreamController.sink.add(dataModel);
    } catch (Exception) {
      print(Exception);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Widgets.appBarWidget("Assigned Case"),
      body: StreamBuilder<CaseAssignedModel>(
        stream: _assignedCasetreamController.stream,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          } else {
            CaseAssignedModel datalist = snapshot.data!;
            if(datalist.status != 0) {
              int? count = datalist.list?.length;
              return ListView.builder(
                  itemCount: count,
                  itemBuilder: (context, index) {
                    int decIndex = count! - (index + 1);
                    var data = datalist.list?.map((e) => e.toJson())
                        .toList()[decIndex];

                    return
                      isLoading ?
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
                              border: Border.all(color: AppColor.clGray)),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              children: [
                                Container(
                                  height: 40,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(Radius.circular(4.0)),
                                      //border: Border.all(color: Colors.grey),
                                      color: AppColor.clBlue),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      Text(
                                        data!["patient_name"] ?? "",
                                        style: Font.font600B17wh(),
                                      ),
                                      Text(
                                        data["patient_mobile"] ?? "",
                                        style: Font.font600B17wh(),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Assigned By',
                                            style: Font.font400R9gray(),
                                          ),
                                          SizedBox(height: 10),
                                          Text(
                                            data["doctor_name"] ?? "",
                                            style: Font.font600B13(),
                                          ),
                                          SizedBox(height: 5),
                                          Text(
                                            data["doctor_mobile"] ?? "",
                                            style: Font.font600B11(),
                                          ),
                                          // SizedBox(width: 10),
                                          // Text(
                                          //   data["city"],
                                          //   style: TextStyle(
                                          //     fontSize: 16,
                                          //   ),
                                          // ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment:
                                        MainAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Case Assigned To',
                                              style: Font.font400R9gray(),
                                          ),
                                          SizedBox(height: 10),
                                          Text(
                                            data["field_worker_name"] ?? "--",
                                              style: Font.font600B13()
                                          ),
                                          SizedBox(height: 5),
                                          Text(
                                            data["field_worker_mobile"] ?? "",
                                            style: Font.font600B11(),
                                          ),
                                          // SizedBox(width: 10),
                                        ],
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
                            isLoading = true;
                          });
                          getPtCurrentStatus(leadid: data["lead_id"])
                              .then((value) {
                            PatientCurrentStatus leadStatus = value;
                            if (leadStatus.status == 1) {
                              Navigator.push(context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          CareBuddyStatusForAdmin(
                                              leadStatus: leadStatus,
                                              leadid: data["lead_id"]
                                          ),
                                    ));
                              setState(() {
                                isLoading = false;
                              });
                            } else {
                              String msg = leadStatus.msg.toString();
                              Future.delayed(const Duration(seconds: 3), () {
                                Navigator.pop(context);
                              });
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
        },
      ),
    );
  }
}

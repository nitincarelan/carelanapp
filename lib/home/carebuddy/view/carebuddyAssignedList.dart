import 'dart:async';
import 'dart:convert';
import 'dart:ui';

import 'package:carelan/home/carebuddy/view/patientProgressForm.dart';
import 'package:carelan/utils/constant/appfont.dart';
import 'package:carelan/utils/constant/component.dart';
import 'package:carelan/utils/constant/widgets.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../../utils/constant/app_color.dart';
import '../../../utils/constant/app_url.dart';
import '../../admin/model/patientCurrentStatus.dart';
import '../controller/careBuddyController.dart';
import '../model/assignLeadModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CareBuddyAssignedLead extends StatefulWidget {
  const CareBuddyAssignedLead({Key? key}) : super(key: key);

  @override
  _CareBuddyAssignedLeadState createState() => _CareBuddyAssignedLeadState();
}

class _CareBuddyAssignedLeadState extends State<CareBuddyAssignedLead> {
  final StreamController<AssignedLead> _assignedController = StreamController();
  late SharedPreferences? logindata;
  bool isloading = false;
  @override
  void dispose() {
    _assignedController.close();
    super.dispose();
  }

  @override
  void initState() {
    initial() async {
      logindata = await SharedPreferences.getInstance();
      setState(() {
        String? mobileno = logindata?.getString("mobile");
        getAssignLead(mobileno!);
      });
    }
    initial();
    super.initState();
  }

  Future<void> getAssignLead(String phone) async {
    try {
      String url = AppUrl.getAssignedList;
      Map<String, String> body = {
        'assign_to': phone.toString(),
      };
      http.Response response = await http.post(Uri.parse(url), body: body);
      final databody = json.decode(response.body);
      AssignedLead dataModel = AssignedLead.fromJson(databody);
      return _assignedController.sink.add(dataModel);
    } catch (exception) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Widgets.appBarWidget("My Leads"),
      body: Column(
        children: [
          Expanded(
              child: StreamBuilder<AssignedLead>(
                  stream: _assignedController.stream,
                  builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                    if (!snapshot.hasData) {
                      return Center(
                          child: CircularProgressIndicator(
                        color: AppColor.primaryColor,
                      ));
                    } else {
                      AssignedLead datalist = snapshot.data! as AssignedLead;

                      int? count = datalist.allFieldWorkerLead?.length;
                      if (datalist.status == 0) {
                        return gui.dataNotFound();
                      } else {
                        return ListView.builder(
                          itemCount: count,
                          itemBuilder: (BuildContext context, int index) {
                            int decnum = index + 1;
                            int newIndex = (count! - decnum);
                            var data = datalist.allFieldWorkerLead
                                ?.map((e) => e.toJson())
                                .toList()[newIndex];
                            if (data!["status"] == "assigned") {
                              return
                                isloading ?
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
                                  onTap: () {
                                    /*
                                    setState(() {
                                      isloading = true;
                                    });
                                    getStatusDetails(leadId: data["id"])
                                        .then((value) {
                                      PatientCurrentStatus datalist = value;
                                      if (datalist.status == 1) {
                                        setState(() {
                                          isloading = false;
                                        });
                                        //Future.delayed(const Duration(seconds: 1), () {
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      PatientProgressForm(
                                                          //leadStatus: datalist,
                                                          leadId: data["id"])));
                                        //});
                                      } else {

                                      }
                                    });
*/
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    PatientProgressForm(
                                                      leadId : data["id"]
                                                    )));
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                        border: Border.all(
                                            color: AppColor.black54)),
                                    child: Column(
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                              color: AppColor.primaryColor,
                                              borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(8.0),
                                                  topRight:
                                                      Radius.circular(8.0))),
                                          height: 50,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Text(data['name'] ?? "",
                                                    style: Font.font600B17wh()),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Text(
                                                    data['mobile'] ?? "",
                                                    style: Font.font600B17wh()),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text("Description",
                                                      style:
                                                          Font.font400R9gray()),
                                                  Text(
                                                      data['description'] ?? "",
                                                      style: Font
                                                          .font500M12Black()),
                                                ],
                                              ),
                                              Text(data['status'] ?? "",
                                                  style: Font.fontstatus()),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(left: 10),
                                          child: Row(
                                            children: [
                                              Text("Surgeon Name",
                                                  style:
                                                  Font.font400R9gray()),
                                              SizedBox(width: 10),
                                              Text(data['surgeon_name'] ?? "",
                                                  style: Font.font500M10()),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(left: 10),
                                          child: Row(
                                            children: [
                                              Text("Hospital",
                                                  style:
                                                  Font.font400R9gray()),
                                              SizedBox(width: 10),
                                              Text(data['hospital'] ?? "",
                                                  style: Font.font500M10()),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(left: 10),
                                          child: Row(
                                            children: [
                                              Text("Admission date and Time:",
                                                  style:
                                                  Font.font400R9gray()),
                                              SizedBox(width: 10),
                                              Text((data['surgery_date'] ?? "")+", "+(data['admission_time'] ?? ""),
                                                  style: Font.font500M10()),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(left: 10),
                                          child: Row(
                                            children: [
                                              Text("OT Time:",
                                                  style:
                                                  Font.font400R9gray()),
                                              SizedBox(width: 10),
                                              Text(data['ot_time'] ?? "",
                                                  style: Font.font500M10()),
                                            ],
                                          ),
                                        ),
                                        SizedBox(height: 10)
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            } else {
                              return Container();
                            }
                          },
                        );
                      }
                    }
                  })),
        ],
      ),
    );
  }
}

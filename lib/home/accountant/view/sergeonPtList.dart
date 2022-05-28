import 'dart:async';
import 'dart:convert';

import 'package:carelan/home/accountant/view/ptdetails.dart';
import 'package:carelan/utils/constant/appfont.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../../utils/constant/app_color.dart';
import '../../../utils/constant/app_url.dart';
import '../../../utils/constant/widgets.dart';
import '../model/completedLeadDetails.dart';

class SergeonListWithCompletedStatus extends StatefulWidget {
  const SergeonListWithCompletedStatus({Key? key}) : super(key: key);

  @override
  _SergeonListWithCompletedStatusState createState() => _SergeonListWithCompletedStatusState();
}

class _SergeonListWithCompletedStatusState extends State<SergeonListWithCompletedStatus> {
  @override
  StreamController<CompletedLeadDetails> _assignedCasetreamController = StreamController();
  //late SharedPreferences? logindata;
  @override
  void initState() {
    // TODO: implement initState
    getCaseAssignList();
    super.initState();
  }

  Future<void> getCaseAssignList() async {
    try {
      String url = AppUrl.completedLeadDetails;
      http.Response response = await http.get(Uri.parse(url));
      final databody = json.decode(response.body);
      CompletedLeadDetails dataModel = CompletedLeadDetails.fromJson(databody);
      return _assignedCasetreamController.sink.add(dataModel);
    } catch (Exception) {
      print(Exception);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Widgets.appBarWidget("Completed Case"),
      body: StreamBuilder<CompletedLeadDetails>(
        stream: _assignedCasetreamController.stream,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if(!snapshot.hasData){
            return Center(child: CircularProgressIndicator());
          } else {
            CompletedLeadDetails datalist = snapshot.data!;
            int? count = datalist.leadDetails?.length;
            return ListView.builder(
                itemCount: count,
                itemBuilder: (context, index) {

                  var data = datalist.leadDetails?.map((e) => e.toJson()).toList()[index];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      child: Container(
                        //height: 60,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            border: Border.all(color: Colors.black12)),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            //mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Patinent",
                                    style: Font.font400R9gray()
                                  ),
                                  SizedBox(width: 20),
                                  Text(
                                    "Hospital",
                                    style: Font.font400R9gray(),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                      data!["name"]??"",
                                      style: Font.font600B17()
                                  ),
                                  SizedBox(width: 20),
                                  Text(
                                    data["hospital"]??"--",
                                      style: Font.font600B17()
                                  ),
                                ],
                              ),
                              SizedBox(height: 10),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Surgeon",
                                    style: Font.font400R9gray(),
                                  ),
                                  SizedBox(width: 20),
                                  Text(
                                    "Total Bill",
                                    style: Font.font400R9gray(),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    data["surgeon_name"]??"",
                                    style: Font.font600B17()
                                  ),
                                  SizedBox(width: 20),
                                  Text(
                                    "₹ "+(data["bill_amount"]??""),
                                      style: Font.font600B17grn()
                                  ),
                                ],
                              ),
                              SizedBox(height: 10),
                              /*
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [

                                  Icon(Icons.verified_outlined,
                                      color: AppColor.clGreen,
                                      size: 16),
                                  SizedBox(width: 5),
                                  Text(
                                    data["status"]??"",
                                    textAlign: TextAlign.end,
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: AppColor.clGreen
                                    ),
                                  ),
                                ],
                              ),
                              */
                            ],
                          ),
                        ),
                      ),
                      onTap: () async {
                        //Navigator.pushNamed(context, '/patientDetailsForm');
                       Navigator.push(context, MaterialPageRoute(builder: (context) => PatientDetailsForm(
                         leadId : data["id"]??"",
                         ptname : data["name"]??"",
                         hospital : data["hospital"]??"",
                         totalbill : data["bill_amount"]??""
                       )));
                      },
                    ),
                  );
                });
          }

        },

      ),
    );
  }
}

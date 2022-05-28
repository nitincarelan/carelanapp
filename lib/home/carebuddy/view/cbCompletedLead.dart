import 'dart:async';
import 'dart:convert';
import 'package:carelan/utils/constant/appfont.dart';
import 'package:carelan/utils/constant/component.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../../utils/constant/app_color.dart';
import '../../../utils/constant/app_url.dart';
import '../../../utils/constant/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/completedcase.dart';

class CareBuddyCompledLeadList extends StatefulWidget {
  const CareBuddyCompledLeadList({Key? key}) : super(key: key);

  @override
  _CareBuddyCompledLeadListState createState() =>
      _CareBuddyCompledLeadListState();
}

class _CareBuddyCompledLeadListState extends State<CareBuddyCompledLeadList> {
  late SharedPreferences? logindata;
  String? mobilenumber="";
  bool isloading = false;

  @override
  StreamController<CompletedCaseForCB> _assignedCasetreamController =
      StreamController();
  //late SharedPreferences? logindata;
  // @override
  // Future<void> initState() async {
  //   // TODO: implement initState
  //   logindata = await SharedPreferences.getInstance();
  //   mobilenumber = logindata?.getString("mobile");
  //   getCaseAssignList(mobilenumber!);
  //   super.initState();
  //
  // }
  @override
  void initState() {
    initial() async {
      logindata = await SharedPreferences.getInstance();
      setState(() {
        String? mobileno = logindata?.getString("mobile");
        getCaseAssignList(mobileno!);
      });
    }
    initial();
    super.initState();
  }

  Future<void> getCaseAssignList(String mobilenumber) async {
    try {
      String url = AppUrl.caseDoneLeadforCB;
      Map<String, String> body = {
        "assign_to" : mobilenumber.toString()
      };

      http.Response response = await http.post(
          Uri.parse(url),
          body: body
      );
      final databody = json.decode(response.body);
      CompletedCaseForCB dataModel = CompletedCaseForCB.fromJson(databody);
      return _assignedCasetreamController.sink.add(dataModel);
    } catch (Exception) {
      print(Exception);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Widgets.appBarWidget("Completed Cases"),
      body: StreamBuilder<CompletedCaseForCB>(
        stream: _assignedCasetreamController.stream,
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          } else {
            CompletedCaseForCB datalist = snapshot.data!;
            if(datalist.status == 1) {
              int? count = datalist.leadDetails?.length;
              return ListView.builder(
                  itemCount: count,
                  itemBuilder: (context, index) {
                    var data = datalist.leadDetails?.map((e) => e.toJson())
                        .toList()[index];
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        child: Container(
                          //height: 60,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.0),
                              border: Border.all(color: AppColor.black54)),
                          child: Padding(
                            padding: const EdgeInsets.all(0.1),
                            child: Column(
                              children: [
                                Container(
                                  height: 40,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(4.0),
                                          topLeft: Radius.circular(4.0)),
                                      color: AppColor.primaryColor),
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                    children: [
                                      Text(
                                        data!["name"] ?? "",
                                        style: Font.font600B17wh(),
                                      ),
                                      Text(
                                        data["mobile"] ?? "",
                                        style: Font.font600B17wh(),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 10),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment
                                        .start,
                                    children: [
                                      Expanded(
                                        child: Column(
                                          mainAxisAlignment:
                                          MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment
                                              .start,
                                          children: [
                                            Text(
                                              'Assigned By',
                                              style: Font.font400R9gray(),
                                            ),
                                            SizedBox(height: 5),
                                            Text(
                                              data["surgeon_name"] ?? "",
                                              style: Font.font600B15blk(),
                                            ),
                                            //SizedBox(height: 10),
                                            // Text(
                                            //   data["doctor_mobile"] ?? "",
                                            //     style: Font.font600B15blk()
                                            // ),
                                            // SizedBox(width: 10),
                                            // Text(
                                            //   data["city"] ?? "",
                                            //   style: TextStyle(
                                            //     fontSize: 16,
                                            //   ),
                                            // ),
                                            SizedBox(height: 5),
                                            Text(
                                              "Description",
                                              style: Font.font400R9gray(),
                                            ),
                                            SizedBox(width: 10),
                                            Text(
                                                data["description"] ?? "",
                                                style: Font.font500M13()
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        decoration: new BoxDecoration(
                                            color: AppColor.primaryColor,
                                            borderRadius:
                                            BorderRadius.circular(8.0)),
                                        //child:
                                        // Padding(
                                        //   padding: const EdgeInsets.all(8.0),
                                        //   child: Text(
                                        //     data["status"]??"",
                                        //     style: TextStyle(
                                        //         fontSize: 16, color: Colors.white),
                                        //   ),
                                        // ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        // onTap: () async {
                        //   Navigator.pushNamed(
                        //     context,
                        //     '/careBuddyStatus',
                        //   );
                        // },
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

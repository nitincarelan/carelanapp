import 'dart:async';
import 'dart:convert';
import 'package:carelan/utils/constant/app_color.dart';
import 'package:carelan/utils/constant/app_url.dart';
import 'package:carelan/utils/constant/appfont.dart';
import 'package:carelan/utils/constant/component.dart';
import 'package:carelan/utils/constant/widgets.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/newleads.dart';
import '../model/sergeonlistmodel.dart';
import 'package:http/http.dart' as http;

class NewLeadSergeonList extends StatefulWidget {
  @override
  State<NewLeadSergeonList> createState() => _NewLeadSergeonListState();
}

class _NewLeadSergeonListState extends State<NewLeadSergeonList> {
  //const NewLeadSergeonList({Key? key}) : super(key: key);
  StreamController<SergeonListModel> _sergeonstreamController =
      StreamController();
  StreamController<NewLeadModel> _patientstreamController = StreamController();
  late SharedPreferences? logindata;
  @override
  void initState() {
    // TODO: implement initState
    getSurgeonList();
    super.initState();
  }

  Future<void> getSurgeonList() async {
    try {
      String url = AppUrl.getFollowUpLeadSergeonList;
      http.Response response = await http.get(Uri.parse(url));
      final databody = json.decode(response.body);
      SergeonListModel dataModel = SergeonListModel.fromJson(databody);
      return _sergeonstreamController.sink.add(dataModel);
    } catch (Exception) {
      //print(Exception);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Widgets.appBarWidget("New lead by Surgeons"),
      body: StreamBuilder<SergeonListModel>(
          stream: _sergeonstreamController.stream,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            print(snapshot.data);
            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            } else {
              SergeonListModel datalist = snapshot.data! as SergeonListModel;
              if(datalist.status != 0){
              int? count = datalist.list?.length;

              return ListView.builder(
                  itemCount: count,
                  itemBuilder: (context, index) {
                    //int descnt = count! - (index + 1);
                    var data = datalist.list?.map((e) => e.toJson()).toList()[index];

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
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          data!["name"]??"",
                                          style: Font.font600B17(),
                                        ),
                                        Text(
                                          data["city"]??"",
                                          style: Font.font500M10(),
                                        ),
                                      ],
                                    ),
                                    SizedBox(width: 10),
                                  ],
                                ),
                                CircleAvatar(
                                    backgroundColor: AppColor.appbgColor,
                                    child: Text(
                                      data["totalLeads"],
                                      style: Font.font600B17blue(),
                                    ))
                              ],
                            ),
                          ),
                        ),
                        onTap: () async {
                          logindata = await SharedPreferences.getInstance();
                          logindata?.setString(
                              "patientMobileNumber", data["doctorMobile"]);
                          logindata?.setString("surgeonName", data["name"]);
                          Navigator.pushNamed(
                            context,
                            '/patientList',
                          );
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
}

import 'dart:async';
import 'dart:convert';
import 'package:carelan/utils/constant/app_color.dart';
import 'package:carelan/utils/constant/appfont.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../../utils/constant/widgets.dart';
import '../../doctor/view/allHospitalList.dart';
import '../../drawer/drawer.dart';
import '../model/getAllLeadCount.dart';

class AdminHome extends StatefulWidget {
  const AdminHome({Key? key}) : super(key: key);

  @override
  _AdminHomeState createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  final appriveRejectkey = GlobalKey();
  StreamController<AllLeadCount> _allCountstreamController = StreamController();
 // bool isLoding = false;

  initState() {
      getLeadCount();
      super.initState();
  }

  Future<void> getLeadCount() async {
    String url = 'https://www.carelan.in/api/leads-count-status-wise';
    Map<String, String> body = {};
    http.Response response = await http.post(
      Uri.parse(url),
      body: body,
    );
    final databody = json.decode(response.body);
    AllLeadCount dataModel = AllLeadCount.fromJson(databody);
    return _allCountstreamController.sink.add(dataModel);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Widgets.applogo(),
          backgroundColor: AppColor.appbgColor,
          toolbarHeight: 80,
          elevation: 0,
        ),
        drawer: Drawer(child: HomeDrawer()),
        body: AdminHomeScreens(),
        );
  }

Widget AdminHomeScreens() {
return Column(
  children: [
    Expanded(
        child: GestureDetector(
          onTapDown: (TapDownDetails details){
            getLeadCount();
          },
          child: Container(
            color: AppColor.appbgColor,
            child: SingleChildScrollView(
              child: StreamBuilder<Object>(
                  stream: _allCountstreamController.stream,
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Center(child: CircularProgressIndicator());
                    } else {
                      AllLeadCount? dataCount = snapshot.data as AllLeadCount?;
                      int? newLeadcount = (dataCount?.leadsCountFollowup) ?? 0;
                      int? openLeadCount = (dataCount?.leadsCountOpen) ?? 0;
                      int? assignedCount = (dataCount?.leadsCountAssigned) ?? 0;
                      int? caseDoneCount = (dataCount?.leadsCountComplated) ?? 0;
                      return Container(
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(height: 20),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        Navigator.pushNamed(
                                            context, '/newLeadSergeonList');
                                      },
                                      child: Container(
                                          height: 120,
                                          width: MediaQuery.of(context).size.width / 2.5,
                                          decoration: BoxDecoration(
                                            //border: Border.all(color: Colors.black),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(20)),
                                            color: AppColor.clWhite,
                                          ),
                                          child: Column(
                                            mainAxisAlignment:
                                            MainAxisAlignment.center,
                                            children: [
                                              Text("$newLeadcount",
                                                  style: Font.font60032Color(
                                                      AppColor.clOrange)),
                                              Text("New Lead",
                                                  style: Font.font600B15blk()),
                                            ],
                                          )),
                                    ),
                                    SizedBox(height: 20),
                                    InkWell(
                                      onTap: () {
                                        Navigator.pushNamed(
                                            context, '/openLeadSergeonList');
                                      },
                                      child: Container(
                                          height: 120,
                                          width:
                                          MediaQuery.of(context).size.width /
                                              2.5,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(20)),
                                            color: AppColor.clWhite,
                                          ),
                                          child: Column(
                                            mainAxisAlignment:
                                            MainAxisAlignment.center,
                                            children: [
                                              Text("$openLeadCount",
                                                  style: Font.font60032Color(
                                                      AppColor.clRed)),
                                              Text("Open Lead",
                                                  style: Font.font600B15blk()),
                                            ],
                                          )),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 20),
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        Navigator.pushNamed(
                                            context, '/caseAssigned');
                                      },
                                      child: Container(
                                          height: 130,
                                          width:
                                          MediaQuery.of(context).size.width /
                                              2.5,
                                          decoration: BoxDecoration(
                                            //border: Border.all(color: Colors.black),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(20)),
                                            color: AppColor.clWhite,
                                          ),
                                          child: Column(
                                            mainAxisAlignment:
                                            MainAxisAlignment.center,
                                            children: [
                                              Text("$assignedCount",
                                                  style: Font.font60032Color(
                                                      AppColor.clBlue)),
                                              Text("Cases Assigned",
                                                  style: Font.font600B15blk()),
                                            ],
                                          )),
                                    ),
                                    SizedBox(height: 20),
                                    InkWell(
                                      onTap: () {
                                        Navigator.pushNamed(
                                            context, '/caseComplted');
                                      },
                                      child: Container(
                                          height: 130,
                                          width:
                                          MediaQuery.of(context).size.width /
                                              2.5,
                                          decoration: BoxDecoration(
                                            //border: Border.all(color: Colors.white),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(20)),
                                            color: AppColor.clWhite,
                                          ),
                                          child: Column(
                                            mainAxisAlignment:
                                            MainAxisAlignment.center,
                                            children: [
                                              Text("$caseDoneCount",
                                                  style: Font.font60032Color(
                                                      AppColor.clGreen)),
                                              Text("Cases Done",
                                                  style: Font.font600B15blk())
                                            ],
                                          )),
                                    ),
                                  ],
                                ),
                                //SizedBox(height: 20),
                              ],
                            ),
                          ));
                    }
                    // return CircularProgressIndicator();
                  }),
            ),
          ),
        )),
    Expanded(
        child: Container(
          width: MediaQuery.of(context).size.width,
          color: AppColor.clWhite,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            //crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 40),
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, '/adminDeshboard');
                },
                child: Container(
                    height: 60,
                    width: MediaQuery.of(context).size.width - 50,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black12),
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      color: AppColor.clWhite,
                    ),
                    child: Center(
                      child: Row(
                        children: [
                          SizedBox(width: 20),
                          Widgets.surgeonApproval(),
                          SizedBox(width: 20),
                          Text("Surgeon Approval",
                              style: Font.font600B15blk()),
                        ],
                      ),
                    )),
              ),
              SizedBox(height: 20),
              InkWell(
                onTap: () {
                  //Navigator.pushNamed(context, '/addHospitalDetails');
                  //Navigator.pushNamed(context, '/allHospitalList');
                  Navigator.push(
                      context,
                      new MaterialPageRoute(
                          builder: (context) =>
                          new AllHospitalList(id : 3)));
                },
                child: Container(
                    height: 60,
                    width: MediaQuery.of(context).size.width - 50,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black12),
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      color: AppColor.clWhite,
                    ),
                    child: Center(
                      child: Row(
                        children: [
                          SizedBox(width: 20),
                          Widgets.hospital(),
                          SizedBox(width: 20),
                          Text("Hospital List",
                              style: Font.font600B15blk()),
                        ],
                      ),
                    )),
              ),
            ],
          ),
        ))
  ],
);

}
}


import 'dart:async';
import 'dart:convert';
import 'dart:ui';
import 'package:carelan/utils/constant/app_url.dart';
import 'package:carelan/utils/constant/widgets.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../../utils/constant/app_color.dart';
import '../../../utils/constant/appfont.dart';
import '../controller/adminService.dart';
import '../controller/carebuddylistmodel.dart';
import '../model/assignLeadToFieldWorkerModel.dart';
import 'adminhome.dart';

class CareBuddyList extends StatefulWidget {
  const CareBuddyList({Key? key, this.id, this.mobile}) : super(key: key);
  final id;
  final mobile;

  @override
  State<CareBuddyList> createState() => _CareBuddyListState();

}

class _CareBuddyListState extends State<CareBuddyList> {

  StreamController<CareBuddyModel> _cbcontroller = StreamController();
  bool isLoading = false;

  void dispose() {
    _cbcontroller.close();
    super.dispose();
  }

  initState() {
    getCareBuddyList();
    super.initState();
  }

  Future<void> getCareBuddyList() async {
    String url = AppUrl.getCareBuddyList;
    http.Response response = await http.post(Uri.parse(url));
    final databody = json.decode(response.body);
    CareBuddyModel dataModel = CareBuddyModel.fromJson(databody);
    return _cbcontroller.sink.add(dataModel);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Widgets.appBarWidget("Care Buddy"),
      body: CareBuddyListUi(),
    );
  }

  Widget CareBuddyListUi() {
    return StreamBuilder<CareBuddyModel>(
        stream: _cbcontroller.stream,
        builder: (context, snapshot) {
          int? count = snapshot.data?.userDetails?.length;
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          } else {
            CareBuddyModel datalist = snapshot.data!;
            return ListView.builder(
                itemCount: count,
                itemBuilder: (BuildContext context, int index) {
                  var data = datalist.userDetails
                      ?.map((e) => e.toJson())
                      .toList()[index];
                  return isLoading ?
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
                        height: 60,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            border: Border.all(color: AppColor.clGray)),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                data!["name"]??"",
                                style: Font.font500N15(),
                              ),
                              SizedBox(width: 10),
                              Text(
                                data["mobile"]??"",
                                style: Font.font500M13(),
                              ),
                            ],
                          ),
                        ),
                      ),
                      onTap: () async {
                        setState(() {
                          isLoading = true;
                        });
                        leadAssignedtoFieldWorker(
                            leadid : widget.id,
                            usermobile : data["mobile"],
                        ).then((value) {
                          AssignLeadToFieldWorker assignLead = value;
                          if (assignLead.status == 1) {
                            setState(() {
                              isLoading = false;
                            });
                            String msg = assignLead.msg.toString();
                            showAlertDialog(context, msg);
                            // Future.delayed(const Duration(seconds: 3), () {
                            //   Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                            //     return AdminHome();
                            //   }));
                            Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                  AdminHome()),
                                  (Route route) => false,
                            );
                            // });
                          } else {
                            String msg = assignLead.msg.toString();
                            //showAlertDialog(context, msg);
                            Future.delayed(const Duration(seconds: 3), () {
                              Navigator.pop(context);
                            });
                          }
                        });
                      },
                    ),
                  );
                });
          }
        });
  }

  void showAlertDialog(BuildContext context, String msg) {
    // Create button
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () {
        //Navigator.of(context).pop();
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

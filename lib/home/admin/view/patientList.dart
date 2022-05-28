import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:carelan/home/admin/view/patientDescription.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import '../../../utils/constant/app_color.dart';
import '../../../utils/constant/appfont.dart';
import '../../../utils/constant/widgets.dart';
import 'package:http/http.dart' as http;
import '../model/newleads.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/patientdatamodel.dart';
import '../model/sergeonlistmodel.dart';
import 'PatientDetailsFormForAdmin.dart';

class PatientList extends StatefulWidget {
  const PatientList({Key? key}) : super(key: key);

  @override
  _PatientListState createState() => _PatientListState();
}

class _PatientListState extends State<PatientList> {
  StreamController<NewLeadModel> _streamController = StreamController();
  bool isVisilble = false;
  String? patientphonenumber = "";
  String? surgeonName = "";
  late SharedPreferences? logindata;

  @override
  void dispose() {
    _streamController.close();
    super.dispose();
  }

  @override
  void initState() {
    initial() async {
      logindata = await SharedPreferences.getInstance();
      setState(() {
        patientphonenumber = logindata?.getString("patientMobileNumber");
        surgeonName = logindata?.getString("surgeonName");
        getAllLead(patientphonenumber!);
      });
    }
    initial();
    super.initState();
  }
  Future<void> getAllLead(String phone) async {
    String url = 'https://www.carelan.in/api/get-leads';
    Map<String, String> body = {
      'added_by': phone.toString(),
      'status' : "followup"
    };
    http.Response response = await http.post(
      Uri.parse(url),
      body: body,
    );

    final databody = json.decode(response.body);
    NewLeadModel dataModel = NewLeadModel.fromJson(databody);
    return _streamController.sink.add(dataModel);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Widgets.appBarWidget(surgeonName!),
      body: Column(
        children: [
          Expanded(
              child: StreamBuilder<NewLeadModel>(
                  stream: _streamController.stream,
                  builder:
                      (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                    if (!snapshot.hasData) {
                      return Center(
                        child: CircularProgressIndicator(
                        color: AppColor.primaryColor,
                      ));
                    } else {
                      NewLeadModel datalist = snapshot.data! as NewLeadModel;

                      int? count = datalist.allLeads?.length;
                      if (datalist.status == 0) {
                        return Text(
                          'Data not found',
                          style: TextStyle(color: Colors.red),
                        );
                      } else {

                        return ListView.builder(
                          itemCount: count,
                          itemBuilder: (BuildContext context, int index) {
                            int decInd = count! - (index+1);
                            var data = datalist.allLeads
                                ?.map((e) => e.toJson())
                                .toList()[decInd];
                            return InkWell(
                              onTap: () {

                              },
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8.0),
                                      border: Border.all(color: Colors.black12)),
                                  child: ListTile(
                                    leading: InkWell(
                                        child: SizedBox(
                                          width: 50,
                                          child: Image.network(data!["image"]),
                                        ),
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              new MaterialPageRoute(
                                                  builder: (context) =>
                                                      new PatientDescription(
                                                          person: new Person(data["id"], data["name"], data["mobile"], data["image"], data["description"].toString(), surgeonName!))));
                                        }),
                                    title: Text(
                                      data["name"]??"",
                                      style: Font.font600B17(),
                                    ),
                                    subtitle: Text(data["mobile"]!,
                                        style: Font.font500M12Black()),
                                    trailing: ElevatedButton(
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                  new PatientDetailsFormForAdmin(
                                                      person: new Person(
                                                        data["id"],
                                                          data["name"],
                                                          data["mobile"],
                                                          data["image"],
                                                          data["description"].toString(),
                                                          surgeonName!
                                                      ))));
                                         },
                                        style: ButtonStyle(
                                          backgroundColor: MaterialStateProperty.all(AppColor.btnColor),
                                          textStyle: MaterialStateProperty.all(
                                            const TextStyle(fontSize: 15),
                                          ),
                                        ),
                                        child: Text(data["status"]!,
                                        style: TextStyle(color: AppColor.clWhite))),
                                  ),
                                ),
                              ),
                            );
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

class MyClip extends CustomClipper<Rect> {
  Rect getClip(Size size) {
    return Rect.fromCenter(height: 60, width: 60, center: Offset(27.0, 27.0));
  }

  bool shouldReclip(oldClipper) {
    return false;
  }
}

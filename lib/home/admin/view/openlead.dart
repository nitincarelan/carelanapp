import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import '../../../utils/constant/app_color.dart';
import '../../../utils/constant/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../model/openleads.dart';

class OpenLead extends StatefulWidget {
  const OpenLead({Key? key}) : super(key: key);

  @override
  _OpenLeadState createState() => _OpenLeadState();
}

class _OpenLeadState extends State<OpenLead> {
  StreamController<OpenLeadModel> _streamController = StreamController();
  bool isVisilble = false;
  String? phone = "";
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
        phone = logindata!.getString('mobile');
        getAllLead(phone!);
      });
    }
    initial();
    super.initState();
  }

  Future<void> getAllLead(String phone) async {
    String url = 'https://www.carelan.in/api/get-leads';
    Map<String, String> body = {
      'added_by': phone.toString(),
    };
    http.Response response = await http.post(
      Uri.parse(url),
      body: body,
    );
    final databody = json.decode(response.body);
    OpenLeadModel dataModel = OpenLeadModel.fromJson(databody);
    return _streamController.sink.add(dataModel);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Widgets.appBarWidget("New Lead"),
      body: Column(
        children: [
          Expanded(
              child: StreamBuilder<OpenLeadModel>(
                  stream: _streamController.stream,
                  builder:
                      (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                    if (!snapshot.hasData) {
                      return Center(
                          child: CircularProgressIndicator(
                            color: AppColor.primaryColor,
                          ));
                    } else {
                      OpenLeadModel datalist = snapshot.data! as OpenLeadModel;

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
                            var data = datalist.allLeads
                                ?.map((e) => e.toJson())
                                .toList()[index];
                            var datas = data!.values.toList();
                            return InkWell(
                              onTap: () {
                                print(datas[3].toString());
                              },
                              child: ListTile(
                                //leading: Text(datas[1].toString()),

                                title: Text(
                                  datas[1].toString(),
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                                subtitle: Text(datas[2].toString() +
                                    '\n' +
                                    datas[3].toString()),
                                trailing: Text(datas[6].toString()),
                              ),
                            );
                          },
                        );
                      }
                    }
                  })),
          new Divider(
            color: Colors.grey,
            height: 1,
          ),
        ],
      ),
    );
  }
}

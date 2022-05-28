import 'dart:async';
import 'dart:convert';
import 'package:carelan/utils/constant/component.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import '../../../utils/constant/app_color.dart';
import '../../../utils/constant/appfont.dart';
import '../../../utils/constant/widgets.dart';
import 'package:http/http.dart' as http;
import '../../admin/model/newleads.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NewLead extends StatefulWidget {
  const NewLead({Key? key}) : super(key: key);

  @override
  _NewLeadState createState() => _NewLeadState();
}

class _NewLeadState extends State<NewLead> {
  StreamController<NewLeadModel> _streamController = StreamController();
  bool isVisilble = false;
  String? phone = "";
  late SharedPreferences? logindata;
  String currentData = "followup";

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
    NewLeadModel dataModel = NewLeadModel.fromJson(databody);
    return _streamController.sink.add(dataModel);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Widgets.appBarWidget("Total Lead"),
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: Stack(
          alignment: AlignmentDirectional.topCenter,
          children: [
            Positioned(
                child: ClipPath(
              child: Container(
                height: MediaQuery.of(context).size.height / 3,
                color: AppColor.appbgColor,
              ),
              clipper: CustomClipPath(),
            )),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        currentData = "followup";
                      });
                    },
                    child: Text("Open Lead"),
                    style: ElevatedButton.styleFrom(
                        primary: Colors.white,
                        onPrimary: Colors.black54,
                        side: currentData == "followup"
                            ? BorderSide(width: 1.0)
                            : BorderSide(width: 0.0),
                        onSurface: Colors.grey,
                        shape: StadiumBorder()),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        currentData = "completed";
                      });
                    },
                    child: Text("Completed"),
                    style: ElevatedButton.styleFrom(
                        primary: Colors.white,
                        onPrimary: Colors.black54,
                        side: currentData == "completed"
                            ? BorderSide(width: 1.0)
                            : BorderSide(width: 0.0),
                        onSurface: Colors.grey,
                        shape: StadiumBorder()),
                  ),
                  SizedBox(
                    width: 10,
                  ),

                  SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        currentData = "all";
                      });
                    },
                    child: Text("All Lead"),
                    style: ElevatedButton.styleFrom(
                        primary: Colors.white,
                        onPrimary: Colors.black54,
                        side: currentData == "all"
                            ? BorderSide(width: 1.0)
                            : BorderSide(width: 0.0),
                        onSurface: Colors.grey,
                        shape: StadiumBorder()),
                  ),
                ],
              ),
            ),
            currentData == "all"
                ? Container(
                    child: leadList("all"),
                  )
                : currentData == "completed"
                    ? Container(
                        child: leadList("completed"),
                      )
                    : Container(
                        child: leadList("followup"),
                      )
          ],
        ),
      ),
    );
  }

  leadList(String s) {
    return Container(
      margin: EdgeInsets.only(top: 60),
      child: StreamBuilder<NewLeadModel>(
          stream: _streamController.stream,
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (!snapshot.hasData) {
              return Center(
                  child: CircularProgressIndicator(
                color: AppColor.primaryColor,
              ));
            } else {
              NewLeadModel datalist = snapshot.data! as NewLeadModel;
              int? count = datalist.allLeads?.length;
              if (datalist.status == 0) {
                return gui.dataNotFound();
              } else {
                return ListView.builder(
                  itemCount: count,
                  itemBuilder: (BuildContext context, int index) {
                    int decnum = index + 1;
                    int newIndex = (count! - decnum);

                    var data = datalist.allLeads
                        ?.map((e) => e.toJson())
                        .toList()[newIndex];

                  //var dateInStr = data!["created_at"].split('-');
print(data);
                    var time = "Submitted on " + data!["created_at"];
                    if (s == 'all') {
                      return Center(
                        child: Container(
                          padding: new EdgeInsets.all(10.0),
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            elevation: 1,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(time, style: Font.font500M10()),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text((data["status"][0]).toUpperCase()+(data["status"]).substring(1),
                                         // Text("",
                                          style: TextStyle(
                                              fontSize: 10.0,
                                              color: data["status"] == "completed"
                                                      ? Colors.green
                                                      : AppColor.btnColor))
                                    ],
                                  ),
                                  SizedBox(height: 16),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(data["name"],
                                          style: Font.font600B17()),
                                      SizedBox(
                                        height: 8,
                                      ),
                                      Text(data["mobile"],
                                          style: Font.font500M12()),
                                      SizedBox(
                                        height: 12,
                                      ),
                                      Text(
                                          data["description"] ??
                                              "No description",
                                          style: Font.font500M12Black())
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    } else if (data["status"] == s) {
                      return Center(
                        child: Container(
                          padding: new EdgeInsets.all(10.0),
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            elevation: 1,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(time, style: Font.font500M10()),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text((data["status"][0]).toUpperCase()+(data["status"]).substring(1),
                                          style: TextStyle(
                                              fontSize: 10.0,
                                              color:
                                                  data["status"] == "completed"
                                                      ? Colors.green
                                                      : AppColor.btnColor))
                                    ],
                                  ),
                                  SizedBox(height: 16),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(data["name"],
                                          style: Font.font600B17()),
                                      SizedBox(
                                        height: 8,
                                      ),
                                      Text(data["mobile"],
                                          style: Font.font500M12()),
                                      SizedBox(
                                        height: 12,
                                      ),
                                      Text(
                                          data["description"] ??
                                              "No description",
                                          style: Font.font500M12Black())
                                    ],
                                  ),
                                ],
                              ),
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
          }),
    );
  }
}

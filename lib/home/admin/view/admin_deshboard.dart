import 'dart:async';
import 'dart:convert';
import 'package:carelan/model/deshboardmodel/all_user.dart';
import 'package:carelan/model/deshboardmodel/approverejectmodel.dart';
import 'package:carelan/service/deshboard/approve_reject_service.dart';
import 'package:carelan/utils/constant/component.dart';
import 'package:carelan/utils/constant/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../../utils/constant/app_color.dart';
import '../../../utils/constant/appfont.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        toolbarHeight: 100,
        title: Widgets.applogo(),
        backgroundColor: AppColor.appbgColor,
        //iconTheme: IconThemeData(color: Colors.pink),
        elevation: 0,
      ),
      body: AdminUi(),

      //drawer: Drawer(child: HomeDrawer()),
    );
  }
}

class AdminUi extends StatefulWidget {
  const AdminUi({Key? key}) : super(key: key);

  @override
  _AdminUiState createState() => _AdminUiState();
}

class _AdminUiState extends State<AdminUi> {
  //Widget AdminUi(){
  //create stream
  StreamController<AllUser> _streamController = StreamController();
  bool approvedVisilble = false;
  bool rejectVisible = false;

  @override
  void dispose() {
    //_streamController.close();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    getAllUser();
  }

  Future<void> getAllUser() async {
    String url = 'https://www.carelan.in/api/get-all-user-profile';
    http.Response response = await http.get(Uri.parse(url));
    final databody = json.decode(response.body);
    AllUser dataModel = AllUser.fromJson(databody);
    return _streamController.sink.add(dataModel);
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<AnimatedListState> _listKey = GlobalKey();
    final GlobalKey<AnimatedListState> _approvedlistKey = GlobalKey();
    final GlobalKey<AnimatedListState> _rejectedlistKey = GlobalKey();
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          Container(
            color: AppColor.appbgColor,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(greeting() + '\nAdmin',
                      style: TextStyle(
                          color: AppColor.primaryColor,
                          fontSize: 20,
                          fontWeight: FontWeight.bold)),
                  /*
                  Container(
                    height: 60,
                    width: 100,
                    decoration: BoxDecoration(
                        border: Border.all(color: AppColor.primaryColor),
                        borderRadius: BorderRadius.circular(5)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Total leads',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: AppColor.primaryColor),
                        ),
                        Text(
                          '32',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            //color: AppColor.primaryColor
                          ),
                        ),
                      ],
                    ),
                  )

                   */
                ],
              ),
            ),
          ),
          Expanded(
            child: StreamBuilder<AllUser>(
              stream: _streamController.stream,
              builder: (BuildContext context, AsyncSnapshot snapdata) {
                var count = snapdata.data?.userDetails!.length;
                if (count == 0) {
                  return gui.dataNotFound();
                } else {
                  if (!snapdata.hasData) {
                    return Center(
                        child: CircularProgressIndicator(
                        backgroundColor: AppColor.primaryColor,
                    ));
                  } else {
                    AllUser datalist = snapdata.data! as AllUser;
                    return ListView.builder(
                      key: _listKey,
                      itemCount: count,
                      itemBuilder: (BuildContext context, int index) {
                        int decnum = index + 1;
                        int newIndex = (count! - decnum);
                        var data = datalist.userDetails
                            ?.map((e) => e.toJson())
                            .toList()[newIndex];

                        var datas = data!.values.toList();
                        approvedVisilble = datas[7].toString() == 0.toString() ? false : true;
                        rejectVisible = datas[7].toString() == 0.toString() ? false : true;

                        return Stack(
                          children: [
                            Container(
                              padding: EdgeInsets.only(top : 10, left: 30, right: 20),
                              height: 190,
                              width: double.maxFinite,
                              child: Card(
                                elevation: 5,
                                child: Padding(
                                  padding: const EdgeInsets.only(top :10),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              top: 10, left: 30.0),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                datas[3].toString(),
                                                style: Font.font600B17(),
                                              ),
                                              SizedBox(height: 10),
                                              Row(
                                                children: [
                                                  Icon(Icons.mail_outline,
                                                      size: 16),
                                                  SizedBox(width: 10),
                                                  Text(
                                                    datas[4].toString(),
                                                    style: Font.font400R13blk(),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(height: 10),
                                              Row(
                                                children: [
                                                  Icon(Icons.call, size: 16),
                                                  SizedBox(width: 10),
                                                  Text(
                                                    datas[5].toString(),
                                                    style: Font.font400R13blk(),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(height: 10),
                                              // Text(
                                              //   'Address : ' +
                                              //       datas[6].toString(),
                                              //   style: Font.font400R13blk(),
                                              // )
                                            ],
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            Expanded(
                                              child: ButtonTheme(
                                                //key: _rejectlistKey,
                                                minWidth: 120,
                                                height: 35.0,
                                                buttonColor: Colors.white70,
                                                child: RaisedButton(
                                                    textColor:rejectVisible
                                                        ? Colors.redAccent
                                                        : Colors.redAccent
                                                            .withOpacity(0.5),
                                                    child: Text('Reject'),
                                                    onPressed: () {
                                                      rejectVisible
                                                          ? ScaffoldMessenger
                                                                  .of(context)
                                                              .showSnackBar(SnackBar(
                                                                  content: Text(
                                                                      "This User already Rejected")))
                                                          : rejectUser(
                                                              mobile: datas[5]
                                                                  .toString(),
                                                            ).then((value) {
                                                              RejectUser reject_user = value;
                                                              if (reject_user.status == 1) {
                                                                setState(() {
                                                                  rejectVisible =
                                                                      false;
                                                                });
                                                                ScaffoldMessenger.of(
                                                                        context)
                                                                    .showSnackBar(
                                                                        SnackBar(
                                                                            content:
                                                                                Text(
                                                                  reject_user
                                                                          .msg ??
                                                                      "",
                                                                )));
                                                              }
                                                            });
                                                    }),
                                              ),
                                            ),
                                            SizedBox(width: 1),
                                            Expanded(
                                              child: ButtonTheme(
                                                //key: _approvedlistKey,
                                                minWidth: 120,
                                                height: 35.0,
                                                buttonColor: Colors.white70,
                                                child: RaisedButton(
                                                    textColor: approvedVisilble
                                                        ? AppColor.clGreen
                                                            .withOpacity(0.5)
                                                        : AppColor.clGreen,
                                                    child: Text('Approved'),
                                                    onPressed: () {
                                                      approvedVisilble
                                                          ? ScaffoldMessenger
                                                                  .of(context)
                                                              .showSnackBar(SnackBar(
                                                                  content: Text(
                                                                      "This User already approved")))
                                                          : approveUser(
                                                              mobile: datas[5]
                                                                  .toString(),
                                                            ).then((value) {
                                                              ApproveUser
                                                                  approve_user =
                                                                  value;
                                                              if (approve_user
                                                                      .status ==
                                                                  1) {
                                                                setState(() {
                                                                  approvedVisilble =
                                                                      true;
                                                                });

                                                                ScaffoldMessenger.of(
                                                                        context)
                                                                    .showSnackBar(
                                                                        SnackBar(
                                                                            content:
                                                                                Text(
                                                                  approve_user
                                                                          .msg ??
                                                                      "",
                                                                )));
                                                              }
                                                            });
                                                      //}
                                                    }),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  }
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  String greeting() {
    var hour = DateTime.now().hour;
    if (hour < 12) return 'Good Morning';
    if (hour < 17)
      return 'Good Afternoon';
    else
      return 'Good Evening';
  }
}

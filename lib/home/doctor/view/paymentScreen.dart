import 'dart:async';
import 'dart:convert';

import 'package:carelan/home/doctor/model/paymetDetailesModel.dart';
import 'package:carelan/utils/constant/app_color.dart';
import 'package:carelan/utils/constant/app_url.dart';
import 'package:carelan/utils/constant/component.dart';
import 'package:carelan/utils/constant/widgets.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../../utils/constant/appfont.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({Key? key}) : super(key: key);

  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  StreamController<GetPaymentDetailsForSergeon> _paymentStreamController =
      StreamController();
  String? phone = "";
  late SharedPreferences? logindata;
  String totalEarning = "0.0";
  bool detailFlag = false;
  @override
  void dispose() {
    _paymentStreamController.close();
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
    String url = AppUrl.getCompletedPayment;
    Map<String, String> body = {
      'added_by': phone.toString(),
    };
    http.Response response = await http.post(
      Uri.parse(url),
      body: body,
    );
    final databody = json.decode(response.body);
    GetPaymentDetailsForSergeon dataModel = GetPaymentDetailsForSergeon.fromJson(databody);
    return _paymentStreamController.sink.add(dataModel);
  }

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 2),
            () {
          setState(() {
            totalEarning = totalEarning;
          });
        });
   // var amt = (totalEarning.toString() == "null") ? 0.0 :  totalEarning;
    return Scaffold(
      appBar: Widgets.appBarWidget("Payments"),
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            Positioned(child: ClipPath(
              child: Container(
                height: MediaQuery.of(context).size.height/3,
                color: AppColor.appbgColor,
              ),
              clipper: CustomClipPath(),
            )),
            Container(
              margin: EdgeInsets.only(left: 20, right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Total earnings",
                    style: TextStyle(
                     fontSize: 17,
                     fontWeight: FontWeight.bold
                    )),
                    Text("₹ "+ num.parse(totalEarning).toStringAsFixed(2),
                      //Text("₹ "+ amt.toString(),
                        style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold
                        ))
                  ],
                )
            ),
            Container(
              margin: EdgeInsets.only(top: 30.0,left: 10, right: 10),
              decoration: BoxDecoration(
                  //color: Colors.white,
                  //borderRadius: BorderRadius.circular(20),
                  //boxShadow: [BoxShadow(blurRadius: 1,offset: Offset(1,1))]
              ),
              child: StreamBuilder<GetPaymentDetailsForSergeon>(
                  stream: _paymentStreamController.stream,
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      GetPaymentDetailsForSergeon datalist = snapshot.data as GetPaymentDetailsForSergeon;
                      if(datalist.status != 0) {
                        int? count = datalist.leadDetails?.length;
                        return ListView.builder(
                            itemCount: count,
                            itemBuilder: (context, index) {
                              int decnum = index + 1;
                              int newIndex = (count! - decnum);
                              totalEarning = datalist.net_advance_sum
                                  .toString();

                              var data = datalist.leadDetails
                                  ?.map((e) => e.toJson())
                                  .toList()[newIndex];

                              return Column(
                                children: [
                                  Container(
                                      width: MediaQuery
                                          .of(context)
                                          .size
                                          .width - 20,
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment
                                            .spaceAround,
                                        children: [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment
                                                .spaceBetween,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.all(
                                                    8.0),
                                                child: Column(
                                                  mainAxisAlignment: MainAxisAlignment
                                                      .start,
                                                  crossAxisAlignment: CrossAxisAlignment
                                                      .start,
                                                  children: [
                                                    Text(
                                                      data!["patient_name"]??"",
                                                      style: TextStyle(
                                                          fontSize: 17,
                                                          fontWeight: FontWeight
                                                              .bold
                                                      ),
                                                    ),
                                                    Text(
                                                      data["mobile"]??"",
                                                      style: TextStyle(
                                                        fontSize: 12,
                                                      ),
                                                    ),
                                                    SizedBox(height: 10),
                                                    Text(
                                                      "Hospital",
                                                      style: TextStyle(
                                                        fontSize: 10,
                                                      ),
                                                    ),
                                                    Text(
                                                      data["hospital"]??"",
                                                      style: TextStyle(
                                                          fontSize: 12,
                                                          fontWeight: FontWeight
                                                              .bold
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                margin: EdgeInsets.only(
                                                    right: 8),
                                                child: Column(
                                                  mainAxisAlignment: MainAxisAlignment
                                                      .start,
                                                  crossAxisAlignment: CrossAxisAlignment
                                                      .end,
                                                  children: [
                                                    Text(
                                                      "Your earning",
                                                      style: TextStyle(
                                                        fontSize: 9,
                                                      ),
                                                    ),
                                                    Text(
                                                      "₹ " +
                                                          (data["bill_amount"]??""),
                                                      style: TextStyle(
                                                        fontSize: 17,
                                                        color: Colors.green,
                                                        fontWeight: FontWeight
                                                            .bold,
                                                      ),
                                                    ),
                                                    SizedBox(height: 10),
                                                    Text(
                                                      "Insurence",
                                                      style: TextStyle(
                                                        fontSize: 9,
                                                      ),
                                                    ),
                                                    Text(
                                                      data["insurance"]??"--",
                                                      style: TextStyle(
                                                        fontSize: 12,
                                                        fontWeight: FontWeight
                                                            .bold,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      decoration:
                                      BoxDecoration(color: Colors.white)),
                                  Container(
                                    //height: 200,
                                    width: MediaQuery
                                        .of(context)
                                        .size
                                        .width - 20,
                                    decoration: BoxDecoration(
                                        color: Colors.white),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment
                                          .start,
                                      crossAxisAlignment: CrossAxisAlignment
                                          .start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment
                                                .spaceBetween,
                                            children: [
                                              Text(
                                                "Total Bill",
                                                style: Font.font500M13(),
                                              ),
                                              Text(
                                                data["bill_amount"] ?? "0.0",
                                                style: Font.font500M13(),
                                              )
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "MOU (" +
                                                    (data["mou_dis_per"] ??
                                                        "0") + "%)",
                                                style: Font.font500M13(),
                                              ),
                                              Text(
                                                data["mou_dis_rs"] ?? "0.0",
                                                style: Font.font500M13(),
                                              )
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "Deductions",
                                                style: Font.font500M13(),
                                              ),
                                              Text(
                                                data['deductions'] ?? "0.0",
                                                style: Font.font500M13(),
                                              )
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "Net After Deductions",
                                                style: Font.font500M13(),
                                              ),
                                              Text(
                                                data['net_after_deduction'] ??
                                                    "0.0",
                                                style: Font.font500M13(),
                                              )
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "Sergeon Share(" +
                                                    (data["surgeon_share_per"] ??
                                                        "0") + "%)",
                                                style: Font.font500M13(),
                                              ),
                                              Text(
                                                data['surgeon_share_rs'] ??
                                                    "0.0",
                                                style: Font.font500M13(),
                                              )
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "TDS",
                                                style: Font.font500M13(),
                                              ),
                                              Text(
                                                data["tds"] ?? "0.0",
                                                style: Font.font500M13(),
                                              )
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "NET",
                                                style: Font.font500M13(),
                                              ),
                                              Text(
                                                data["net"] ?? "0.0",
                                                style: Font.font500M13(),
                                              )
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "NET Advance",
                                                style: Font.font500M13(),
                                              ),
                                              Text(
                                                data["net_advance"] ?? "0.0",
                                                style: Font.font500M13(),
                                              )
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "Balance",
                                                style: Font.font500M13(),
                                              ),
                                              Text(
                                                data["balance"] ?? "0.0",
                                                style: Font.font500M13(),
                                              )
                                            ],
                                          ),
                                        ),

                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment
                                                .spaceBetween,
                                            children: [
                                              Text("Billed on " +
                                                  (data["bill_submission_date"] ??
                                                      "-/-/-"),
                                                  style: TextStyle(
                                                      fontSize: 10,
                                                      color: AppColor.btnColor
                                                  )),
                                              /*
                                          InkWell(
                                            onTap: (){
                                              setState(() {
                                                detailFlag = true;
                                              });
                                            },
                                            child: detailFlag ?
                                            Text("Show details",
                                                style: TextStyle(
                                                    fontSize: 10,
                                                    color: AppColor.btnColor
                                                ))
                                            :
                                            Text("Hide details",
                                                style: TextStyle(
                                                    fontSize: 10,
                                                    color: AppColor.btnColor
                                                ))
                                          ),

                                           */
                                            ],
                                          ),
                                        )

                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 30,)
                                ],
                              );
                            }

                        );
                      } else {
                        return gui.dataNotFound();
                      }
                    }
                  }),
            ),
          ],
        )
      ),
      //bottomSheet: BottomTotalTab()
    );
  }
}

class PaymentDetailesList extends StatelessWidget {
  const PaymentDetailesList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 5,
      itemBuilder: (context, index) {
        return Column(
          children: [
            SizedBox(height: 5),
            Container(
                //height: 70,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Neelam Chauhan",
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                          Text(
                            "Star Health",
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Ayushman",
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                          Text(
                            "13107.8",
                            style: TextStyle(
                                color: Colors.greenAccent,
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                decoration: BoxDecoration(color: AppColor.primaryColor)),
            Container(
              //height: 200,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(color: Colors.white),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Total Bill:",
                          style: TextStyle(fontSize: 18),
                        ),
                        Text(
                          "44660",
                          style: TextStyle(fontSize: 18),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "MOU (%)",
                          style: TextStyle(fontSize: 18),
                        ),
                        Text(
                          "15",
                          style: TextStyle(fontSize: 18),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "MOU Discount",
                          style: TextStyle(fontSize: 18),
                        ),
                        Text(
                          "6699",
                          style: TextStyle(fontSize: 18),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Deductions",
                          style: TextStyle(fontSize: 18),
                        ),
                        Text(
                          "2000",
                          style: TextStyle(fontSize: 18),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Net After Deductions",
                          style: TextStyle(fontSize: 18),
                        ),
                        Text(
                          "35961",
                          style: TextStyle(fontSize: 18),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "TDS",
                          style: TextStyle(fontSize: 18),
                        ),
                        Text(
                          "1618",
                          style: TextStyle(fontSize: 18),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "NET",
                          style: TextStyle(fontSize: 18),
                        ),
                        Text(
                          "14564.2",
                          style: TextStyle(fontSize: 18),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "NET Advance",
                          style: TextStyle(fontSize: 18),
                        ),
                        Text(
                          "13107.8",
                          style: TextStyle(fontSize: 18),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Balance",
                          style: TextStyle(fontSize: 18),
                        ),
                        Text(
                          "1456.4",
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        )
                      ],
                    ),
                  ),
                  Text("*This is remark regarding payment")
                ],
              ),
            )
          ],
        );
      },
    );
  }
}

Widget BottomTotalTab() {
  return Container(
    height: 60,
    decoration: BoxDecoration(color: Colors.amber),
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Total",
            style: TextStyle(
                color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Text(
            "15590.37",
            style: TextStyle(
                color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
          )
        ],
      ),
    ),
  );
}

/*
class PaymentList extends StatelessWidget {
  const PaymentList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 5,
      itemBuilder: (context, index) {
        return Column(
          children: [
            SizedBox(height: 5),
            Container(
                //height: 70,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Neelam Chauhan",
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                          Text(
                            "Star Health",
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Ayushman",
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                          Text(
                            "13107.8",
                            style: TextStyle(
                                color: Colors.greenAccent,
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                decoration: BoxDecoration(color: AppColor.primaryColor)),
            Container(
              //height: 200,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(color: Colors.white),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Total Bill:",
                          style: TextStyle(fontSize: 18),
                        ),
                        Text(
                          "44660",
                          style: TextStyle(fontSize: 18),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "MOU (%)",
                          style: TextStyle(fontSize: 18),
                        ),
                        Text(
                          "15",
                          style: TextStyle(fontSize: 18),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "MOU Discount",
                          style: TextStyle(fontSize: 18),
                        ),
                        Text(
                          "6699",
                          style: TextStyle(fontSize: 18),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Deductions",
                          style: TextStyle(fontSize: 18),
                        ),
                        Text(
                          "2000",
                          style: TextStyle(fontSize: 18),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Net After Deductions",
                          style: TextStyle(fontSize: 18),
                        ),
                        Text(
                          "35961",
                          style: TextStyle(fontSize: 18),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "TDS",
                          style: TextStyle(fontSize: 18),
                        ),
                        Text(
                          "1618",
                          style: TextStyle(fontSize: 18),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "NET",
                          style: TextStyle(fontSize: 18),
                        ),
                        Text(
                          "14564.2",
                          style: TextStyle(fontSize: 18),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "NET Advance",
                          style: TextStyle(fontSize: 18),
                        ),
                        Text(
                          "13107.8",
                          style: TextStyle(fontSize: 18),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Balance",
                          style: TextStyle(fontSize: 18),
                        ),
                        Text(
                          "1456.4",
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        )
                      ],
                    ),
                  ),
                  Text("*This is remark regarding payment")
                ],
              ),
            )
          ],
        );
      },
    );
  }
}
*/

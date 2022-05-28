import 'dart:async';
import 'dart:convert';
import 'package:carelan/utils/constant/app_color.dart';
import 'package:carelan/utils/constant/component.dart';
import 'package:http/http.dart' as http;
import 'package:carelan/utils/constant/widgets.dart';
import 'package:flutter/material.dart';

import '../../../utils/constant/app_url.dart';
import '../../admin/model/allHospitalList.dart';
class AllHospitalList extends StatefulWidget {
  final int id;
  const AllHospitalList({Key? key, required this.id}) : super(key: key);

  @override
  _AllHospitalListState createState() => _AllHospitalListState();
}

class _AllHospitalListState extends State<AllHospitalList> {
  @override

  StreamController<AllHospitalListModel> _allHospitalListController =
  StreamController();
  //late SharedPreferences? logindata;
  @override
  void initState() {
    // TODO: implement initState
    getHospitalList();
    super.initState();
  }

  Future<void> getHospitalList() async {
    try {
      String url = AppUrl.getAllHospitalCityList;
      http.Response response = await http.post(Uri.parse(url));
      final databody = json.decode(response.body);
      AllHospitalListModel dataModel = AllHospitalListModel.fromJson(databody);
      return _allHospitalListController.sink.add(dataModel);
    } catch (Exception) {

    }
  }

  @override
  Widget build(BuildContext context) {
    int id = widget.id;
    return Scaffold(
        appBar: Widgets.appBarWidget("Hospitals"),
        body: Container(
          height: MediaQuery.of(context).size.height,
          child: Stack(
            alignment: AlignmentDirectional.topCenter,
            children: [
              Positioned(child: ClipPath(
                child: Container(
                  height: MediaQuery.of(context).size.height/3,
                  color: AppColor.appbgColor,
                ),
                clipper: CustomClipPath(),
              )),
              Positioned(
                top: 50,
                child: Container(
                  height: MediaQuery.of(context).size.height/1.3,
                  margin: const EdgeInsets.all(3.0),
                  width: MediaQuery.of(context).size.width - 50,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [BoxShadow(blurRadius: 1,color: Colors.grey,offset: Offset(1,3))]
                  ),
                  child: StreamBuilder(
                    stream: _allHospitalListController.stream,
                    builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                      if(!snapshot.hasData){
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      } else {
                        AllHospitalListModel hospitalList = snapshot.data;
                        if(hospitalList.data != null) {
                          int count = hospitalList.data!.length;
                          return ListView.builder(
                            itemCount: count,
                            //reverse: true,
                            itemBuilder: (BuildContext context, int index) {
                              int decInd = count - (index + 1);
                              var data = hospitalList.data
                                  ?.map((e) => e.toJson())
                                  .toList()[decInd];

                              return Container(
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment
                                            .spaceBetween,
                                        children: [
                                          Text(data!["hospital_name"] ?? "",
                                            style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold
                                            ),
                                          ),
                                          Text(data["city_name"] ?? "",
                                            style: TextStyle(
                                                fontSize: 13,
                                                color: AppColor.clOrange
                                            ),),
                                        ],
                                      ),
                                    ),
                                    Divider()
                                  ],
                                ),
                              );
                            },
                          );
                        } else {
                          return gui.dataNotFound();
                        }
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        ),

        floatingActionButton: Container(
          //margin: EdgeInsets.all(10),
          child: id == 3 ? Tooltip(
              message: 'Add Hospital',
              child: FlatButton(
                onPressed: () {
                  //Navigator.pop(context);
                  Navigator.pushNamed(context, '/addHospitalDetails');
                },
                child: Icon(Icons.add_box,
                  size: 60,
                  color: AppColor.clOrange,
                ),
              )
          )
          :
          Text(""),
        )


    );
  }
}

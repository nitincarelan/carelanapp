import 'package:carelan/home/admin/model/singleLeadDetailModel.dart';
import 'package:carelan/utils/constant/widgets.dart';
import 'package:flutter/material.dart';

class InsurnceDoumentViewer extends StatefulWidget {
  const InsurnceDoumentViewer({Key? key, required this.datalist})
      : super(key: key);
  final List<LeadDetails>? datalist;
  @override
  _InsurnceDoumentViewerState createState() => _InsurnceDoumentViewerState();
}

class _InsurnceDoumentViewerState extends State<InsurnceDoumentViewer> {
  @override
  Widget build(BuildContext context) {
    var ptDetails = widget.datalist?[0];
    return Scaffold(
        appBar: Widgets.appBarWidget("Insurence Document"),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: 100,
            child: Row(
              children: [
                Expanded(
                  child: Image.network(ptDetails!.insuranceDoc.toString()),
                ),
                Expanded(child: Column(
                  children: [
                    Text(ptDetails.name.toString(),
                    style: TextStyle(
                      color: Colors.teal,
                      fontWeight: FontWeight.bold,
                      fontSize: 22
                    ),
                    ),
                    Text(ptDetails.mobile.toString()),
                    SizedBox(height: 10,),
                    Text(ptDetails.surgeonName.toString(),
                      style: TextStyle(
                          //color: Colors.teal,
                          fontWeight: FontWeight.bold,
                          fontSize: 22
                      ),),
                    Text(ptDetails.surgery.toString())
                  ],
                ))
              ],
            ),
          ),
        ));
  }
}

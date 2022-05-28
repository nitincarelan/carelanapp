import 'dart:async';
import 'dart:convert';
import 'package:carelan/utils/constant/component.dart';
import 'package:carelan/utils/constant/widgets.dart';
import 'package:flutter/material.dart';
import '../../../utils/constant/app_color.dart';
import '../../../utils/constant/app_url.dart';
import 'package:http/http.dart' as http;
import '../../../utils/constant/appfont.dart';
import '../model/caseAssignedModel.dart';
import '../model/completedLeadDetailsModel.dart';
 class CaseComplted extends StatefulWidget {
   const CaseComplted({Key? key}) : super(key: key);

   @override
   _CaseCompltedState createState() => _CaseCompltedState();
 }

 class _CaseCompltedState extends State<CaseComplted> {
   StreamController<LeadCompletedDetails> _leadCompletedDetailstreamController =
   StreamController();
   //late SharedPreferences? logindata;
   @override
   void initState() {
     // TODO: implement initState
     getCaseAssignList();
     super.initState();
   }

   Future<void> getCaseAssignList() async {
     try {
       String url = AppUrl.completedLeadDetails;
       http.Response response = await http.get(Uri.parse(url));
       final databody = json.decode(response.body);
       LeadCompletedDetails dataModel = LeadCompletedDetails.fromJson(databody);
       return _leadCompletedDetailstreamController.sink.add(dataModel);
     } catch (Exception) {
       //print(Exception);
     }
   }

   @override
   Widget build(BuildContext context) {
     return Scaffold(
       appBar: Widgets.appBarWidget("Completed Case"),
       body: StreamBuilder<LeadCompletedDetails>(
         stream: _leadCompletedDetailstreamController.stream,
         builder: (BuildContext context, AsyncSnapshot snapshot) {
           if (!snapshot.hasData) {
             return Center(child: CircularProgressIndicator());
           } else {
             LeadCompletedDetails datalist = snapshot.data!;
             if(datalist.status != 0) {
               int? count = datalist.leadDetails?.length;
               return ListView.builder(
                   itemCount: count,
                   itemBuilder: (context, index) {
                     int decNum = count! - (index + 1);
                     var data = datalist.leadDetails?.map((e) => e.toJson())
                         .toList()[decNum];

                     return Padding(
                       padding: const EdgeInsets.all(8.0),
                       child: InkWell(
                         child: Container(
                           //height: 60,
                           decoration: BoxDecoration(
                               borderRadius: BorderRadius.circular(8.0),
                               border: Border.all(
                                   color: AppColor.primaryColor)),
                           child: Column(
                             children: [
                               Container(
                                 height: 45,
                                 decoration: BoxDecoration(
                                     borderRadius:
                                     BorderRadius.all(Radius.circular(4.0)),
                                     //border: Border.all(color: Colors.grey)
                                     color: AppColor.primaryColor),
                                 child: Row(
                                   mainAxisAlignment:
                                   MainAxisAlignment.spaceAround,
                                   //crossAxisAlignment: CrossAxisAlignment.stretch,
                                   children: [
                                     Text(
                                       data!["name"] ?? "",
                                       style: Font.font600B17wh(),
                                     ),
                                     Text(
                                       data["mobile"] ?? "",
                                       style: Font.font500M13wh()
                                     ),
                                   ],
                                 ),
                               ),
                               SizedBox(height: 10),
                               Padding(
                                 padding: const EdgeInsets.all(8.0),
                                 child: Row(
                                   mainAxisAlignment: MainAxisAlignment.start,
                                   children: [
                                     Expanded(
                                       child: Column(
                                         mainAxisAlignment: MainAxisAlignment.start,
                                         crossAxisAlignment: CrossAxisAlignment.start,
                                         children: [
                                           Text(
                                             'Assigned By',
                                             style: Font.font400R9gray(),
                                           ),
                                           SizedBox(height: 10),
                                           Text(
                                             data["surgeon_name"] ?? "",
                                             style: Font.font600B13(),
                                           ),
                                           SizedBox(width: 20),
                                           Text(
                                             data["reffered_by"] ?? "",
                                             style: Font.font500M12Black(),
                                           ),
                                           // SizedBox(width: 10),
                                           // Text(
                                           //   data["city"],
                                           //   style: TextStyle(
                                           //     fontSize: 16,
                                           //   ),
                                           // ),
                                         ],
                                       ),
                                     ),
                                     Expanded(
                                       child: Column(
                                         mainAxisAlignment:
                                         MainAxisAlignment.start,
                                         crossAxisAlignment: CrossAxisAlignment.start,
                                         children: [
                                           Text(
                                             'Case Assigned To',
                                             style: Font.font400R9gray(),
                                           ),
                                           SizedBox(height: 20),
                                           Text(
                                             data["hospital"] ?? "--",
                                             style: Font.font600B13(),
                                           ),
                                           SizedBox(width: 20),
                                           Text(
                                             data["surgery"] ?? "",
                                             style: Font.font500M12Black(),
                                           ),
                                           // SizedBox(width: 10),
                                         ],
                                       ),
                                     ),
                                   ],
                                 ),
                               ),
                               SizedBox(height: 10),
                               Row(
                                 mainAxisAlignment: MainAxisAlignment.center,
                                 children: [
                                   Icon(Icons.verified_outlined,
                                   size: 12,
                                   color: AppColor.clGreen,
                                   ),
                                   SizedBox(width: 5,),
                                   Text(
                                     data["status"] ?? "",
                                     style: TextStyle(
                                         fontSize: 10,
                                         fontWeight: FontWeight.bold,
                                         color: AppColor.clGreen),
                                   ),
                                 ],
                               ),
                               SizedBox(height: 10),
                             ],
                           ),
                         ),
                         onTap: () async {},
                       ),
                     );
                   });
             } else {
               return gui.dataNotFound();
             }
           }
         },
       ),
     );
   }
 }


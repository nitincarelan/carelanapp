import 'package:carelan/utils/constant/widgets.dart';
import 'package:flutter/material.dart';
import '../model/patientdatamodel.dart';

class PatientDescription extends StatelessWidget {
  const PatientDescription({Key? key, required this.person}) : super(key: key);
  final Person person;
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: Widgets.appBarWidget("Patient Details"),
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: Center(
              child: Image.network(person.image,
              scale: 1.0,),
            ),
          ),
          Expanded(
            flex: 1,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
            children: [

                Text(person.name,style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18
                ),),
                Text(person.mobile),
                SizedBox(height: 10,),
                Text(person.description)
            ],
          ),
              ))

        ],
      )
    );
  }
}

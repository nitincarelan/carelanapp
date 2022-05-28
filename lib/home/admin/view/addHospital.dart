import 'package:flutter/material.dart';

import '../../../utils/constant/app_color.dart';
import '../../../utils/constant/widgets.dart';
import '../controller/adminService.dart';
import '../model/addHospitalModel.dart';
import '../../doctor/view/allHospitalList.dart';

class AddHospitalDetails extends StatefulWidget {
  const AddHospitalDetails({Key? key}) : super(key: key);

  @override
  State<AddHospitalDetails> createState() => _AddHospitalDetailsState();

}

class _AddHospitalDetailsState extends State<AddHospitalDetails> {
  TextEditingController _hospitalNameController = new TextEditingController();
  String? _cityValue;
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Widgets.appBarWidget("Add Hospital"),
      body: Form(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextFormField(
                textCapitalization: TextCapitalization.sentences,
                controller: _hospitalNameController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Enter Hospital Name",
                  hintText: "Hospital Name",
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
                onChanged: (val) {},
              ),
              SizedBox(height: 10),
              /*
              TextFormField(
                textCapitalization: TextCapitalization.sentences,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Enter City Name",
                  hintText: "City Name",
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
                onChanged: (val) {},
              ),

               */
              DropdownButtonFormField<String>(
                dropdownColor: AppColor.clOrange,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                ),
                focusColor: Colors.grey,
                items:
                //items.map(buildMenuItem()).toList(),
                [
                  DropdownMenuItem<String>(
                    child: Text('Delhi'),
                    value: "1",
                  ),
                  DropdownMenuItem<String>(
                    child: Text('Gurgaon'),
                    value: '2',
                  ),
                  DropdownMenuItem<String>(
                    child: Text('Noida'),
                    value: '3',
                  ),
                  DropdownMenuItem<String>(
                    child: Text('Faridabad'),
                    value: '4',
                  ),
                  DropdownMenuItem<String>(
                    child: Text('Ghaziabad'),
                    value: '5',
                  ),
                  DropdownMenuItem<String>(
                    child: Text('Banglore'),
                    value: '6',
                  ),
                ],
                onChanged: (String? value2) {
                  setState(() {
                    _cityValue = value2;
                  });
                },
                hint: Text('--Select Your City--'),
                value: _cityValue,
              ),
              SizedBox(height: 10),
              isLoading ?
                  Center(child: CircularProgressIndicator())
              :
              ElevatedButton(onPressed: (){
                setState(() {
                  isLoading = true;
                });
                addHospital(
                  hname : _hospitalNameController.text,
                  cityId : '$_cityValue',
                ).then((value) {
                  AddHospital userRegisterModel = value;
                  if (userRegisterModel.status == 1) {
                    Navigator.pop(context);
                    setState(() {
                      isLoading = false;
                    });
                    var message = userRegisterModel.msg as String;
                    Widgets.showAlertDialog(context, message);
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                      return AllHospitalList(id: 3);
                    }));
                  } else {
                    Future.delayed(Duration(seconds: 5));
                    setState(() {
                      isLoading = false;
                    });
                    var msg = userRegisterModel
                        .msg as String;
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)),
                    );
                  }
                });
              },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(AppColor.clOrange)
                ),
                  child: Text("Submit",
                      style : TextStyle(
                        color: AppColor.clWhite
                      )),
              )
            ],
          ),
        ),

      ),

    );
  }
}

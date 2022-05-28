import 'package:carelan/utils/constant/widgets.dart';
import 'package:flutter/material.dart';

import '../../../utils/constant/app_color.dart';
import '../controller/acountService.dart';
import '../model/updateLeadAccount.dart';
import 'accountantDashbord.dart';

class PatientDetailsForm extends StatefulWidget {
  const PatientDetailsForm({Key? key, required this.leadId, required this.ptname, required this.hospital, required this.totalbill}) : super(key: key);
  final String leadId;
  final String ptname;
  final String hospital;
  final String totalbill;
  @override
  _PatientDetailsFormState createState() => _PatientDetailsFormState();
}

class _PatientDetailsFormState extends State<PatientDetailsForm> {
  TextEditingController ptnameController = new TextEditingController();
  TextEditingController hospitalController = new TextEditingController();
  TextEditingController insurenceController = new TextEditingController();
  TextEditingController totalBillController = new TextEditingController();
  TextEditingController mouDiscountInPercentController = new TextEditingController();
  TextEditingController mouDiscountInRsController = new TextEditingController();
  TextEditingController deductionController = new TextEditingController();
  TextEditingController netAfterDeductionController = new TextEditingController();
  TextEditingController surgeonSharePercentController = new TextEditingController();
  TextEditingController surgeonShareController = new TextEditingController();
  TextEditingController tdsController = new TextEditingController();
  TextEditingController netController = new TextEditingController();
  TextEditingController netAdvanceController = new TextEditingController();
  TextEditingController balanceController = new TextEditingController();
  TextEditingController remarkController = new TextEditingController();
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    ptnameController = new TextEditingController(text : widget.ptname);
    hospitalController = new TextEditingController(text : widget.hospital);
    totalBillController = new TextEditingController(text : widget.totalbill);
    return Scaffold(
      appBar: Widgets.appBarWidget("Patient Details"),
      body: GestureDetector(
        onTap: (){
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              child: Column(
                children: [
                  CustomTextFormField(
                      'Patient Name', 'Patient Name', ptnameController, 'text'),
                  SizedBox(height: 10),
                  CustomTextFormField(
                      'Hospital', 'Hospital', hospitalController, 'text'),
                  SizedBox(height: 10),
                  CustomTextFormField(
                      'Insurence', 'Insurence', insurenceController, 'text'),
                  SizedBox(height: 10),
                  CustomTextFormField(
                      'Total Bill', 'Bill', totalBillController, 'num'),
                  SizedBox(height: 10),
                  CustomTextFormField(
                      'MOU Discount(in %)', 'MOU Discount in %', mouDiscountInPercentController, 'num'),
                  SizedBox(height: 10),
                  CustomTextFormField(
                      'MOU Discount(Rs.)', 'MOU Discount in rs', mouDiscountInRsController, 'num'),
                  SizedBox(height: 10),
                  CustomTextFormField(
                      'Deductions', 'Deductions', deductionController, 'num'),
                  SizedBox(height: 10),
                  CustomTextFormField(
                      'Net After Deduction', 'Net After Deduction', netAfterDeductionController, 'num'),
                  SizedBox(height: 10),
                  CustomTextFormField(
                      'Surgeon Share(%)', 'Surgeon Share in %', surgeonSharePercentController, 'num'),
                  SizedBox(height: 10),
                  CustomTextFormField(
                      'Surgeon Share(in Rs)', 'Surgeon Share(in Rs)', surgeonShareController, 'num'),
                  SizedBox(height: 10),
                  CustomTextFormField(
                      'TDS', 'TDS', tdsController, 'num'),
                  SizedBox(height: 10),
                  CustomTextFormField(
                      'Net', 'Net', netController, 'num'),
                  SizedBox(height: 10),
                  CustomTextFormField(
                      'Net Advance', 'Net Advance', netAdvanceController, 'num'),
                  SizedBox(height: 10),
                  CustomTextFormField(
                      'Balance', 'Balance', balanceController, 'num'),
                  SizedBox(height: 10),
                  CustomTextFormField(
                      'Remark', 'Remark', remarkController, 'text'),
                  SizedBox(height: 10),
                  //ElevatedButton(
                  ButtonTheme(
                    minWidth: MediaQuery.of(context).size.width - 50,
                    height: 45,
                    child:
                    isLoading ?
                        Center(child: CircularProgressIndicator())
                        :
                    RaisedButton(
                      color: AppColor.btnColor,
                      textColor: Colors.white,
                      child: const Text('Submit'),
                      onPressed: (){
                        /*
                      print(ptnameController.text);
                          print(hospitalController.text);
                      print(insurenceController.text);
                          print(totalBillController.text);
                      print(mouDiscountInPercentController.text);
                          print(mouDiscountInRsController.text);
                      print(deductionController.text);
                          print(netAfterDeductionController.text);
                      print(surgeonSharePercentController.text);
                          print(surgeonShareController.text);
                      print(tdsController.text);
                          print(netController.text);
                      print(netAdvanceController.text);
                          print(balanceController.text);
                      print(remarkController.text);
                      print(widget.leadId);

                         */
                        setState(() {
                          isLoading = true;
                        });
                      updatePayment(
                          leadid : widget.leadId.toString(),
                          patientname : ptnameController.text,
                          hospital : hospitalController.text,
                          insurance : insurenceController.text,
                          billamount : totalBillController.text,
                          moudisper : mouDiscountInPercentController.text,
                          moudisrs : mouDiscountInRsController.text,
                          deductions : deductionController.text,
                          netafterdeduction : netAfterDeductionController.text,
                          surgeonshareper : surgeonSharePercentController.text,
                          surgeonsharers : surgeonShareController.text,
                          tds : tdsController.text,
                          netAdvance : netAdvanceController.text,
                          net : netController.text,
                          balance : balanceController.text,
                          remark : remarkController.text)
                          .then((value) {
                        UpdateLeadAcount datalist = value;
                            if(datalist.status == 1){
                              setState(() {
                                isLoading = false;
                              });
                              Widgets.showAlertDialog(context, datalist.msg.toString());
                              Future.delayed(const Duration(seconds: 1), () {
                                Navigator.of(context).pushAndRemoveUntil(
                                  MaterialPageRoute(
                                      builder: (BuildContext context) => AccountantDashboard()),
                                      (Route route) => false,
                                );
                              });
                            } else {
                              setState(() {
                                isLoading = false;
                              });
                              Widgets.showAlertDialog(context, datalist.msg.toString());
                            }
                      });

                    },
                        //child: Text('Submit'),


                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }


Widget CustomTextFormField(String lbl, String hnt, TextEditingController controller, String type) {
  return TextFormField(
    controller: controller,
      keyboardType: type != "num" ? TextInputType.text : TextInputType.number,
      textCapitalization: TextCapitalization.sentences,
    decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: lbl,
        hintText: hnt),
    validator: (value) {
      if (value == null || value.isEmpty) {
        return 'Please enter some text';
      }
      return null;
    },
        onChanged: (val) {
     if (lbl == 'MOU Discount(in %)') {
            double a = double.parse(totalBillController
                .text); // this is the value in my first text field (This is the percentage rate i intend to use)
            double b = double.parse(mouDiscountInPercentController
                .text); // this is my second text field
            double c = (a * b) / 100;//do your calculation
            mouDiscountInRsController.text = c.toStringAsFixed(2); // trying to set my third text field to display the calculated value here..
          }
          if(lbl == 'Deductions'){
            double d = double.parse(totalBillController.text);
            double e  = double.parse(mouDiscountInRsController.text);
            double f = double.parse(deductionController.text);
            netAfterDeductionController.text = (d - e - f).toStringAsFixed(2);
          }
          if(lbl == 'Surgeon Share(%)') {
            double a = double.parse(netAfterDeductionController
                .text); // this is the value in my first text field (This is the percentage rate i intend to use)
            double b = double.parse(surgeonSharePercentController
                .text); // this is my second text field
            double c = (a * b) / 100;
            double d = c / 10;
            double e = c - d;
            double f = e * 90/100;
            double g = e- f;
            surgeonShareController.text = c.toStringAsFixed(2);
            tdsController.text = d.toStringAsFixed(2);
            netController.text = e.toStringAsFixed(2);
            netAdvanceController.text = f.toStringAsFixed(2);
            balanceController.text = g.toStringAsFixed(2);
          }
        },
      onFieldSubmitted: (val) {
        // double a = double.parse(totalBillController.text); // this is the value in my first text field (This is the percentage rate i intend to use)
        // double b = double.parse(mouDiscountInPercentController.text); // this is my second text field
        // double c = ( a * b ) / 100; //do your calculation
        //mouDiscountInRsController.text = c.toString(); // trying to set my third text field to display the calculated value here..
      }
  );
}

}

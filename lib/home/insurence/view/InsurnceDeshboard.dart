import 'package:flutter/material.dart';

import '../../../utils/constant/app_color.dart';
import '../../../utils/constant/widgets.dart';
import '../../drawer/drawer.dart';
class InsurenceDashboard extends StatelessWidget {
  const InsurenceDashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Widgets.appBarWidget("Carelan Healthcare Insurence"),
      drawer: Drawer(child: HomeDrawer()),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Center(
              child: Image.asset('assets/images/logo.jpg',
                  height: 150,
                  width: 150,
                  fit: BoxFit.scaleDown),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                InkWell(
                  onTap: (){
                    Navigator.pushNamed(
                        context, '/insurenceOpenLead');
                  },
                  child: Container(
                      height: 130,
                      width: MediaQuery.of(context).size.width/2.5,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        color: AppColor.primaryColor,
                      ),
                      child: Center(
                        child: Text("Open Lead",
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white
                            )),
                      )),
                ),
              ],
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                InkWell(
                  onTap: (){
                    Navigator.pushNamed(
                        context, '/careBuddyCaseDone');
                  },
                  child: Container(
                    // transform: Matrix4.skewY(0.1),//.skewX(0.1),
                      height: 130,
                      width: MediaQuery.of(context).size.width/2.5,
                      decoration: BoxDecoration(
                        //border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        color: AppColor.primaryColor,
                      ),
                      child: Center(
                        child: Text("Case Done",
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white
                            )),
                      )),
                )
              ],
            ),
            SizedBox(height: 20),


          ],
        ),
      ),
    );
  }
}

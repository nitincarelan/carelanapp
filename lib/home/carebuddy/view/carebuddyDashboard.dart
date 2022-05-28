import 'package:flutter/material.dart';

import '../../../utils/constant/app_color.dart';
import '../../../utils/constant/widgets.dart';
import '../../drawer/drawer.dart';

class CareBuddyDashBoard extends StatelessWidget {
  const CareBuddyDashBoard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Widgets.appBarWidget(""),
      drawer: Drawer(child: HomeDrawer()),
      backgroundColor: Colors.white,
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
            Positioned(
              top: 10,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Center(child: Widgets.applogo()),
                  SizedBox(height: 50),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, '/assignedLead');
                        },
                        child: Container(
                            height: 80,
                            width: MediaQuery.of(context).size.width - 50,
                            decoration: BoxDecoration(
                              //border: Border.all(color: Colors.black),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                              color: AppColor.primaryColor,
                            ),
                            child: Center(
                                child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(width: 20),
                                Icon(
                                  Icons.event_note_outlined,
                                  color: Colors.white,
                                ),
                                SizedBox(width: 20),
                                Text("Assigned Lead",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white)),
                              ],
                            ))),
                      ),
                      SizedBox(height: 20),
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, '/careBuddyCaseDone');
                        },
                        child: Container(
                            //transform: Matrix4.skewX(0.1),//.skewX(0.1),
                            height: 80,
                            width: MediaQuery.of(context).size.width - 50,
                            decoration: BoxDecoration(
                              //border: Border.all(color: Colors.black),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                              color: AppColor.primaryColor,
                            ),
                            child: Center(
                                child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(width: 20),
                                Icon(
                                  Icons.verified_outlined,
                                  color: Colors.white,
                                ),
                                SizedBox(width: 20),
                                Text("Case Done",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white)),
                              ],
                            ))),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:carelan/utils/constant/app_color.dart';
import 'package:flutter/material.dart';

import '../../../utils/constant/appfont.dart';
import '../../../utils/constant/widgets.dart';
import '../../drawer/drawer.dart';
class AccountantDashboard extends StatefulWidget {
  const AccountantDashboard({Key? key}) : super(key: key);
  @override
  _AccountantDashboardState createState() => _AccountantDashboardState();
}

class _AccountantDashboardState extends State<AccountantDashboard> {
  GlobalKey key1 = new GlobalKey();
  GlobalKey key2 = new GlobalKey();
  GlobalKey key3 = new GlobalKey();
  @override
  //static const IconData currency_rupee = IconData(0xf04e1, fontFamily: 'MaterialIcons');
  IconData inr = const IconData(0x20B9, fontFamily: 'MaterialIcons');

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Widgets.appBarWidget("Account Home"),
      drawer: Drawer(
          child: HomeDrawer()
      ),
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              InkWell(
                onTap: (){
                  Navigator.pushNamed(context, '/sergeonListCompleted');
                },
                child: Container(
                  height: 90,
                  width: MediaQuery.of(context).size.width-50,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(inr,
                      color: AppColor.clWhite),
                      Text("Surgeon Payment",
                          style: Font.font600B17wh()
                      ),
                    ],
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: AppColor.primaryColor
                  ),
                ),
              ),
              Container(
                height: 75,
                width: MediaQuery.of(context).size.width-50,
                child: Center(child: Text("Search Surgeon by name",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white
                ),)),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    color: AppColor.primaryColor,

                ),
              ),
              Container(
                height: 75,
                width: MediaQuery.of(context).size.width-50,
                child: Center(child: Text("Ready to pay",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white
                    ))),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    color: AppColor.primaryColor
                ),
              ),
              SizedBox(height: 100,)
            ],
          ),
        ),
      ),
    );
  }
}

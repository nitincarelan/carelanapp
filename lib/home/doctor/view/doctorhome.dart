import 'package:carelan/utils/constant/appfont.dart';
import 'package:flutter/material.dart';

import '../../../utils/constant/app_color.dart';
import '../../../utils/constant/widgets.dart';
import '../../drawer/drawer.dart';
import 'allHospitalList.dart';

class DoctorHomeUI extends StatefulWidget {
  const DoctorHomeUI({Key? key}) : super(key: key);

  @override
  _DoctorHomeUIState createState() => _DoctorHomeUIState();
}

class _DoctorHomeUIState extends State<DoctorHomeUI> {
  //IconData next = IconData(0xff03cf, fontFamily: 'MaterialIcons');
  /*
  SharedPreferences? logindata;
  String? user_Type = "";
  String? user_Name = "";
  String phone = "";

  @override
  void dispose() {
    //_streamController.close();
    super.dispose();
  }

  @override
  void initState() {
    initial() async {
      logindata = await SharedPreferences.getInstance();
      setState(() {
        phone = logindata!.getString('mobile')!;
        // getUserProfile(phone);
        getUserProfile(
          mobile: phone,
        ).then((value) async {
          //
          UserProfile userProfile = value as UserProfile;
          if (userProfile.status != "1") {

              user_Type = (userProfile.userDetails)?.userType??"";
              user_Name = (userProfile.userDetails)?.name??"";
              logindata!.setString('userName', user_Name!);
              logindata!.setString('mobile',phone);
              logindata!.setString('userType', ((userProfile.userDetails)?.userType??""));
              logindata!.setString('id',((userProfile.userDetails)?.id??""));
              logindata!.setString('userTypeName', ((userProfile.userDetails)?.userTypeName??""));
              logindata!.setString('speciality',((userProfile.userDetails)?.speciality??""));
              logindata!.setString('practicesince',((userProfile.userDetails)?.practiceSince??""));
              logindata!.setString('certificate',((userProfile.userDetails)?.certificate??""));
              logindata!.setString('email', ((userProfile.userDetails)?.email??""));
              logindata!.setString("profilepic", ((userProfile.userDetails)?.profilePic??""));

          }
        });
      });
    }

    //initial();
    super.initState();
  }
  Future<void> getUserProfile1(String phone) async {
    // setState(() {
    //   logindata?.setString("name", "Nitin Sharma");
    // });
  }
*/
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 120,
        title: Image.asset(
          'assets/images/Logo.png',
          height: 40,
          width: 180,
        ),
        backgroundColor: AppColor.appbgColor,
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
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
              ),
            ),
            Container(
              child: Column(
                children: [
                  Widgets.homeImage(),
                  SizedBox(height: 30),
                  Container(
                    child: Column(
                      children: [
                        InkWell(
                          child: Container(
                            width: MediaQuery.of(context).size.width - 50,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8),
                                boxShadow: [BoxShadow(blurRadius: 1,color: Colors.grey,offset: Offset(1,1))]
                            ),
                            child: ListTile(
                              leading: Widgets.patient(),
                              title: Text("New Patients",
                              style: Font.bold20()),
                              subtitle: Text("Assign patient for addmission",
                              style: Font.normal14()),
                              trailing: CircleAvatar(
                                backgroundColor: Colors.white,
                                  foregroundColor: Colors.black,
                                  child: Icon(Icons.arrow_forward)),
                            ),
                          ),
                          onTap: (){
                            Navigator.pushNamed(context, '/addPatient');
                          },
                        ),
                        SizedBox(height: 20),
                        InkWell(
                          child: Container(
                            width: MediaQuery.of(context).size.width - 50,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8),
                                boxShadow: [BoxShadow(blurRadius: 1,color: Colors.grey,offset: Offset(1,1))]
                            ),
                            child: ListTile(
                              leading: Widgets.totalcase(),
                              title: Text("All Cases",
                                  style: Font.bold20()),
                              subtitle: Text("Track and manage all cases",
                                  style: Font.normal14()),
                              trailing: CircleAvatar(
                                  backgroundColor: Colors.white,
                                  foregroundColor: Colors.black,
                                  child: Icon(Icons.arrow_forward)),
                            ),
                          ),
                          onTap: (){
                            Navigator.pushNamed(
                                context, '/newLead');
                            //Navigator.pushNamed(context, '/totalCases');
                            // Navigator.of(context).push(
                            //     MaterialPageRoute(
                            //         builder: (context) =>
                            //             AttechMultipleCamera()));
                          },
                        ),
                        SizedBox(height: 20),
                        InkWell(
                          child: Container(
                            width: MediaQuery.of(context).size.width - 50,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8),
                                boxShadow: [BoxShadow(blurRadius: 1,color: Colors.grey,offset: Offset(1,1))]
                            ),
                            child: ListTile(
                              leading: Widgets.payment(),
                              title: Text("Payments",
                                  style: Font.bold20()),
                              subtitle: Text("Track your payments",
                                  style: Font.normal14()),
                              trailing: CircleAvatar(
                                  backgroundColor: Colors.white,
                                  foregroundColor: Colors.black,
                                  child: Icon(Icons.arrow_forward)),
                            ),
                          ),
                          onTap: (){
                            Navigator.pushNamed(context, '/paymentScreen');
                          },
                        ),
                        SizedBox(height: 20),
                        InkWell(
                          child: Container(
                            width: MediaQuery.of(context).size.width - 50,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8),
                                boxShadow: [BoxShadow(blurRadius: 1,color: Colors.grey,offset: Offset(1,1))]
                            ),
                            child: ListTile(
                              leading: Widgets.hospital(),
                              title: Text("Hospitals",
                                  style: Font.bold20()),
                              subtitle: Text("Check all partner hospital",
                                  style: Font.normal14()),
                              trailing: CircleAvatar(
                                  backgroundColor: Colors.white,
                                  foregroundColor: Colors.black,
                                  child: Icon(Icons.arrow_forward)),
                            ),
                          ),
                          onTap: (){
                            //Navigator.pushNamed(context, '/allHospitalList');
                            Navigator.push(
                                context,
                                new MaterialPageRoute(
                                    builder: (context) =>
                                    new AllHospitalList(id : 1)));
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      drawer: Drawer(
          child: HomeDrawer()
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text("1.0",
        textAlign: TextAlign.center),
      ),
    );
  }

}

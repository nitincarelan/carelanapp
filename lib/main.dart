import 'package:carelan/home/admin/view/admin_deshboard.dart';
import 'package:carelan/startup/loginnew.dart';
import 'package:carelan/startup/otp_screen.dart';
import 'package:carelan/startup/register.dart';
import 'package:carelan/startup/splash_screen.dart';
import 'package:flutter/material.dart';
import 'home/accountant/view/sergeonPtList.dart';
import 'home/admin/view/adminhome.dart';
import 'home/carebuddy/view/carebuddyDashboard.dart';
import 'home/admin/view/caseAssigned.dart';
import 'home/admin/view/caseDoneList.dart';
import 'home/admin/view/newLeadSergeonList.dart';
import 'home/carebuddy/view/cbCompletedLead.dart';
import 'home/admin/view/addHospital.dart';
import 'home/doctor/view/doctorhome.dart';
import 'home/doctor/view/newlead.dart';
import 'home/admin/view/openLeadSergeonList.dart';
import 'home/admin/view/openlead.dart';
import 'home/admin/view/patientList.dart';
import 'home/carebuddy/view/carebuddyAssignedList.dart';
import 'home/doctor/view/addPatient.dart';
import 'home/doctor/view/paymentScreen.dart';
import 'home/drawer/view/myaccount.dart';
import 'home/insurence/view/InsurnceDeshboard.dart';
import 'home/insurence/view/insurenceOpenLead.dart';

void main() {
  runApp(const MyApp());
}

// Future main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await SystemChrome.setPreferredOrientations([
//     DeviceOrientation.portraitUp,
//     DeviceOrientation.portraitDown,
//   ]);
//
//   await UserSimplePreferences.init();
//   runApp(MyApp());
// }


class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  get username => null;

  @override
  void initState(){
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Carelan',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: SplashScreen(),//DoctorDeshboard(),//const SplashScreen(),
      routes: {
        '/loginScreen' : (context) => const LoginNewScreen(),
        '/OtpScreen': (context) => const OtpScreen(),
        '/Register': (context) => const Register(),
        '/adminDeshboard': (context) => HomePage(),
        '/adminhomepage': (context) => AdminHome(),
        '/doctorDeshboard' : (context) =>  DoctorHomeUI(),
        '/carebuddyHome' : (context) => CareBuddyDashBoard(),
        '/addPatient' : (contxt) => const AddPatient(),
        '/myaccount' : (context) => MyAccount(),
        //New Lead
        '/newLead' : (context) => NewLead(),
        //'/patientDetailsForm' : (context) => PatientDetailsForm(),
        '/paymentScreen' : (context) => PaymentScreen(),
        '/newLeadSergeonList' : (context) => NewLeadSergeonList(),
        '/patientList' : (context) => PatientList(),
        //open Lead
        '/openLead' : (context) => OpenLead(),
        '/openLeadSergeonList' : (context) => OpenLeadSergeonList(),
       // '/carebuddylist' : (context) => CareBuddyList(),
        //case assigned
        '/caseAssigned' : (context) => CaseAssigned(),
       // '/careBuddyStatus' : (context) => CareBuddyStatusForAdmin(),
        //case completed
        '/caseComplted' : (context) => CaseComplted(),
        //addHospital
        //'/allHospitalList' : (context) => AllHospitalList(),
        '/addHospitalDetails' : (context) => AddHospitalDetails(),

        //care buddy
        '/assignedLead' : (context) => CareBuddyAssignedLead(),
        '/careBuddyCaseDone' : (context) => CareBuddyCompledLeadList(),
        //'/patientProgressForm' :(context) => PatientProgressForm(),
        //'/hospitalList' :(context) => HopitalList(),
        //accountant
        '/sergeonListCompleted' : (context) => SergeonListWithCompletedStatus(),
        //Insurence
        '/insurenceDashboard' : (context) => InsurenceDashboard(),
        '/insurenceOpenLead' : (context) => InsurenceOpenLead()
      },
    );
  }
}

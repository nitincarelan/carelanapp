// import 'package:shared_preferences/shared_preferences.dart';
//
// class UserSimplePreferences {
//   static SharedPreferences? _preferences;
//   static const mobileNumber = 'mobileNumber';
//
//   static Future init() async =>
//       _preferences = await SharedPreferences.getInstance();
//
//   static Future setUsername(String mobileNumber) async {
//
//     await _preferences?.setString(mobileNumber, mobileNumber);
//   }
//   static String? getUsername(String mobileNumber) {
//     print('mobileNumber------'+mobileNumber);
//     _preferences?.getString(mobileNumber);
//   }
//
// }
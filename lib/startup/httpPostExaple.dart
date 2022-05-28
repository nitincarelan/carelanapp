// import 'package:carelan/model/deshboardmodel/all_user.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:async';
// import 'dart:convert';
//
// class MyHomePage extends StatefulWidget {
//   @override
//   _MyHomePageState createState() => new _MyHomePageState();
// }
//
// class _MyHomePageState extends State<MyHomePage> {
//   late StreamController<AllUser> _postsController;
//   final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
//
//   int count = 1;
//
//   Future<AllUser> fetchPost() async {
//     String url = 'https://www.carelan.in/api/get-all-user-profile';
//     final response = await http.get(Uri.parse(url));
//     print('----------hello--');
//     print(response);
//
//     if (response.statusCode == 200) {
//       return AllUser.fromJson(json.decode(response.body));
//     } else {
//       throw Exception('Failed to load post');
//     }
//   }
//
//   // loadPosts() async {
//   //   fetchPost().then((res) async {
//   //     _postsController.add(res);
//   //     return res;
//   //   });
//   // }
//
//   showSnack() {
//     return scaffoldKey.currentState!.showSnackBar(
//       SnackBar(
//         content: Text('New content loaded'),
//       ),
//     );
//   }
//
//   // Future<Null> _handleRefresh() async {
//   //   count++;
//   //   print(count);
//   //   fetchPost().then((res) async {
//   //     _postsController.add(res);
//   //     showSnack();
//   //     return null;
//   //   });
//   // }
//
//   @override
//   void initState() {
//     _postsController = new StreamController<AllUser>();
//     //loadPosts();
//     // fetchPost().then((res) async {
//     //   _postsController.add(res);
//     //   showSnack();
//     //   return null;
//     // });
//
//     fetchPost().then((value) async{
//       AllUser allUser = value;
//       print('------all user------');
//       print(allUser);
//       if (allUser.status == 1) {
//         return _postsController.add(allUser);
//         // Navigator.pushNamed(
//         //     context, '/OtpScreen',
//         //     arguments: _controller.text);
//       }
//       // ScaffoldMessenger.of(context)
//       //     .showSnackBar(SnackBar(
//       //     content: Text(
//       //       loginByMobileModel.msg ?? "",
//       //     )));
//     });
//
//     super.initState();
//   }
//   void dispose() {
//     //_postsController.close();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return new Scaffold(
//       key: scaffoldKey,
//       // appBar: new AppBar(
//       //   title: new Text('StreamBuilder'),
//       //   actions: <Widget>[
//       //     IconButton(
//       //       tooltip: 'Refresh',
//       //       icon: Icon(Icons.refresh),
//       //       onPressed: _handleRefresh,
//       //     )
//       //   ],
//       // ),
//       body: StreamBuilder<AllUser>(
//         stream: _postsController.stream,
//         builder: (BuildContext context, AsyncSnapshot<AllUser> snapshot) {
//           // print('Has error: ${snapshot.hasError}');
//           // print('Has data: ${snapshot.hasData}');
//           print('Snapshot Data ${(snapshot.data)}');
//
//           AllUser alldata = (snapshot.data)!.status as AllUser;
//             print(alldata);
//           if (snapshot.hasError) {
//             return Text('error');
//           }
//
//           if (snapshot.hasData) {
//             return Column(
//               children: <Widget>[
//                /* Expanded(
//                   child: Scrollbar(
//                     child: RefreshIndicator(
//                       onRefresh: _handleRefresh,
//                       child: ListView.builder(
//                         physics: const AlwaysScrollableScrollPhysics(),
//                         itemCount: snapshot.data.length,
//                         itemBuilder: (context, index) {
//                           //var post = snapshot.data[index];
//                           return ListTile(
//                             //title: Text(snapshot.data),
//                             //title: Text(post['title']['rendered']),
//                             //subtitle: Text(post['date']),
//                           );
//                         },
//                       ),
//                     ),
//                   ),
//                 ),*/
//               ],
//             );
//           }
//
//           if (snapshot.connectionState != ConnectionState.done) {
//             return Center(
//               child: CircularProgressIndicator(),
//             );
//           }
//
//           if (!snapshot.hasData &&
//               snapshot.connectionState == ConnectionState.done) {
//             return Text('No Posts');
//           }
//           return Text('No post');
//         },
//       ),
//     );
//   }
// }
//

import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:carelan/home/drawer/view/helpandsupport.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:image_picker/image_picker.dart';
import '../../startup/loginnew.dart';
import '../../utils/constant/app_color.dart';
import '../../utils/constant/appfont.dart';
import 'controller/updateAcService.dart';
import 'model/profileImageUpdate.dart';
import 'package:share_plus/share_plus.dart';

class HomeDrawer extends StatefulWidget {
  const HomeDrawer({Key? key}) : super(key: key);

  @override
  _HomeDrawerState createState() => _HomeDrawerState();
}

class _HomeDrawerState extends State<HomeDrawer> {
  late SharedPreferences logindata;
  String accountName = "";
  String accountEmail = "";
  String userspecility = "";
  String mobileNo= "";

  ImagePicker picker = ImagePicker();
  PickedFile? pickedImage;
  File? imageFilename = null;
  //File? imageFile = null;
  String? imagePath = "";
  String profilePicture = "";

  @override
  void initState() {
    initial();
    super.initState();
  }

  initial() async {
    logindata = await SharedPreferences.getInstance();
    String? name = logindata.getString('userName');
    String? profilepic = logindata.getString('profilepic');
    String? specility = logindata.getString('speciality');
    String? mobilenumber = logindata.getString("mobile");

    setState(() {
      accountName = name??"";
      userspecility = specility??"" ;
      mobileNo = mobilenumber??"";
      profilePicture = profilepic??"";
    });
  }
  Future<void> uploadProfilePicture(File imageFilename) async {
   if(imageFilename != null) {
      imagePath = imageFilename.path;
      File imagefile = File(imagePath!);
      Uint8List imagebytes = await imagefile.readAsBytes();
      String base64string = base64.encode(imagebytes);

    updateProfilePic(
        mobile : mobileNo,
        image: base64string
    ).then((value) {
      UpdateUserProfileImage data = value;
      if(data.status == 1){
        setState(() {
          profilePicture = data.imagePath.toString();
          logindata.setString('profilepic', profilePicture);
        });
      }else {
      }
    });
    }
  }


  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        UserAccountsDrawerHeader(
          currentAccountPicture: CircleAvatar(
            backgroundColor: Colors.transparent,
            //backgroundImage: AssetImage(imageFilename!.path),
            child: InkWell(
              child:
              // imageFilename == null
              //     ?
              //Text('N',style: TextStyle(fontSize: 35.0))
              // ClipOval(child: Image.network(profilePicture))
              //Image.network("https://www.carelan.in/assets/images/patient_image/patient_VpllXQNIY8.png")
              //ClipOval(child: Image.network(profilePicture))
              //ClipOval(child: Image.file(imageFilename!))
              profilePicture == ""?
              CircleAvatar(
                radius: 60.0,
                //backgroundImage:NetworkImage(profilePicture),
                child: Icon(Icons.add_a_photo),
                backgroundColor: Colors.transparent,
              ) :
              CircleAvatar(
                radius: 60.0,
                backgroundImage:NetworkImage(profilePicture),
                backgroundColor: Colors.transparent,
              ),
              // : ClipOval(
              //         child: Image.file(imageFilename!),
              //         clipper: MyClip(),
              //       ),
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  builder: ((builder) => bottomSheet()),
                );
              },
            ),
          ),
          decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [AppColor.grd2,AppColor.grd1]),
          ),
          accountName: Text(accountName, style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),),
          accountEmail: Text(userspecility),
        ),
        ListTile(
          leading:
              Icon(Icons.account_circle_outlined, color: Colors.black, size: 30),
          title: Text('My Account',
            style: Font.font500N15()
          ),
          onTap: () {
            Navigator.pushNamed(context, '/myaccount');
            //Navigator.pushNamed(context, '/testFormField');
          },
        ),
        ListTile(
          leading: Icon(Icons.help_outline,
              color: Colors.black, size: 30
          ),
          title: const Text('Help and Support'),
          onTap: () {
            Navigator.push(context, MaterialPageRoute(
                builder: (context) => HelpAndSupport()));
          },
        ),
        ListTile(
          leading: Icon(Icons.share_outlined, color: Colors.black, size: 30),
          title: const Text('Share'),
          onTap: () async{
            final box = context.findRenderObject() as RenderBox?;
            await Share.share("https://play.google.com/store/apps/details?id=com.carelan.carelanapp",
                subject: "Carelan HealthCare Pvt. Ltd.",
                sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size
            );
          },
        ),
        ListTile(
          leading: Icon(Icons.logout, color: Colors.black, size: 30),
          title: const Text('Logout'),
          onTap: () async {
            return showDialog<void>(
              context: context,
              barrierDismissible: false, // user must tap button!
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text('Are you sure?'),
                  content: SingleChildScrollView(
                    child: ListBody(
                      children: <Widget>[
                        Text('You want to Logout.'),
                      ],
                    ),
                  ),
                  actions: <Widget>[
                    FlatButton(
                      child: Text('No'),
                      onPressed: () {
                        Navigator.of(context).pop(); // Dismiss the Dialog
                      },
                    ),
                    FlatButton(
                      child: Text('Yes'),
                      onPressed: () {
                        logindata.remove('userName');
                        logindata.remove('mobile');
                        logindata.remove('userType');
                        logindata.remove('id');
                        logindata.remove('userTypeName');
                        logindata.remove('speciality');
                        logindata.remove('practicesince');
                        logindata.remove('certificate');
                        logindata.remove('email');
                        logindata.remove("profilepic");
                        //await Future.delayed(Duration(seconds: 0));
                        Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                              builder: (BuildContext context) => LoginNewScreen()),
                          (Route route) => false,
                        );
                      },
                    ),
                  ],
                );
              },
            );
          },
        ),
      ],
    );
  }

  Widget bottomSheet() {
    return Container(
      height: 100.0,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      child: Column(
        children: <Widget>[
          Text(
            "Choose Profile photo",
            style: TextStyle(
              fontSize: 20.0,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
            FlatButton.icon(
              icon: Icon(Icons.camera),
              onPressed: () {
                takePhotoFromCamera();
                Navigator.pop(context);
              },
              label: Text("Camera"),
            ),
            FlatButton.icon(
              icon: Icon(Icons.image),
              onPressed: () {
                takePhotoFromGallery();
                Navigator.pop(context);
              },
              label: Text("Gallery"),
            ),
          ])
        ],
      ),
    );
  }

  void takePhotoFromGallery() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
      maxWidth: 1000,
      maxHeight: 1000,
    );
    if (pickedFile != null) {
      setState(() {
        imageFilename = File(pickedFile.path);
        uploadProfilePicture(imageFilename!);
      });
    }
  }

  void takePhotoFromCamera() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.camera,
      maxWidth: 400,
      maxHeight: 400,
    );
    if (pickedFile != null) {
      setState(() {
        imageFilename = File(pickedFile.path);
        uploadProfilePicture(imageFilename!);
      });
    }
  }

  getTemporaryDirectory() async {
    Directory tempDir = await getTemporaryDirectory();
    String tempPath = tempDir.path;

  }

}

class MyClip extends CustomClipper<Rect> {
  Rect getClip(Size size) {
    return Rect.fromCenter(height: 55, width: 55, center: Offset(27.0, 27.0));
  }

  bool shouldReclip(oldClipper) {
    return false;
  }
}

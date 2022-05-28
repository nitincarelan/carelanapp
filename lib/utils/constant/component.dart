import 'package:flutter/material.dart';

import 'appfont.dart';
class gui {
  static dataNotFound(){
    return Stack(
      alignment: AlignmentDirectional.topCenter,
      children: [
        Positioned(
            top : 10,
            child: Text("Data not found",
              style: Font.font600B17(),
            ))
      ],
    );
  }
  static getUserProfile(){

  }
}
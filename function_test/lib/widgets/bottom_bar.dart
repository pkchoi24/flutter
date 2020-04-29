import 'package:flutter/material.dart';

class Bottom extends StatelessWidget {

  double iconSize = 30;
  double textSize = 20;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      child: Container(
        child: TabBar(
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white60,
          indicatorColor: Colors.transparent,
          tabs: <Widget>[
            Tab(
              icon: Icon(
                Icons.home,
                size: iconSize
                ),
              child: Text(
                'Home',
                style: TextStyle(fontSize: textSize),
                textScaleFactor: 1.0,
                ),
            ),
            Tab(
              icon: Icon(
                Icons.image,
                size: iconSize
                ),
              child: Text(
                'Image Picker',
                style: TextStyle(fontSize: textSize),
                textScaleFactor: 1.0,
                ),
            ),
            Tab(
              icon: Icon(
                Icons.library_music,
                size: iconSize
                ),
              child: Text(
                'Music Player',
                style: TextStyle(fontSize: textSize),
                textScaleFactor: 1.0,
                ),
            ),
            Tab(
              icon: Icon(
                Icons.video_library,
                size: iconSize
                ),
              child: Text(
                'Video Player',
                style: TextStyle(fontSize: textSize),
                textScaleFactor: 1.0,
                ),
            ),
            Tab(
              icon: Icon(
                Icons.calendar_today,
                size: iconSize
                ),
              child: Text(
                'Calender',
                style: TextStyle(fontSize: textSize),
                ),
            ),
          ],
        ),
        padding: EdgeInsets.only(left: 10, right: 10),
      )
    );
  }
}
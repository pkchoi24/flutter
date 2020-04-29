import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class HomeScreen extends StatefulWidget {
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      //width: double.maxFinite,
      color: Colors.black26,
      child: SafeArea(
        child:Center(
          child:Column(
            children: <Widget>[
              FutureBuilder<Directory>(
                future: getTemporaryDirectory(),
                builder: (context, snapshot) {
                  if(snapshot.connectionState == ConnectionState.done) {
                    return Text("tempDir : ${snapshot.data.path}");
                  }
                },
              ),
              FutureBuilder<Directory>(
                future: getApplicationDocumentsDirectory(),
                builder: (context, snapshot) {
                  if(snapshot.connectionState == ConnectionState.done) {
                    return Text("appDir : ${snapshot.data.path}");
                  }
                },
              ),
              FutureBuilder<Directory>(
                future: getExternalStorageDirectory(),
                builder: (context, snapshot) {
                  if(snapshot.connectionState == ConnectionState.done) {
                    return Text("externalDir : ${snapshot.data.path}");
                  }
                },
              ),
            ],
          )
        )
        ,),
    );
  }
}
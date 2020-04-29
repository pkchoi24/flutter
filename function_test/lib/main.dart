import 'package:flutter/material.dart';

import 'package:function_test/widgets/bottom_bar.dart';
import 'package:function_test/screens/login_screen.dart';
import 'package:function_test/screens/home_screen.dart';
import 'package:function_test/screens/imagePicker_screen.dart';
import 'package:function_test/screens/musicPlayer_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget  {
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool loginState ;

  @override
  void initState() {
    super.initState();
    loginState = false;
  }

  @override
  build(BuildContext context) {
    return MaterialApp(
      title: 'Tomo English',
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.black,
        accentColor: Colors.white
      ),
      
      home: loginState
      ? DefaultTabController(
          length: 5, //home, photo picker, musicPlayer, videoPlayer, Calender
          child: Scaffold(
            body:TabBarView(
              physics: NeverScrollableScrollPhysics(),
              children: <Widget>[
                //HomeScreen(),
                //ImagePickerScreen(),
                //MusicPlayerScreen(),
              ],
            ),
            bottomNavigationBar: Bottom(),
          ),
        )
      : Container(child: LoginScreen())

    );
  }
}
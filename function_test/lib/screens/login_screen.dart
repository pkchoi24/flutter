import 'package:flutter/material.dart';
import 'package:function_test/screens/home_screen.dart';
import 'package:function_test/widgets/bottom_bar.dart';
import 'package:function_test/screens/imagePicker_screen.dart';
import 'package:function_test/screens/musicPlayer_screen.dart';

class LoginScreen extends StatefulWidget  {
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>  {
  final TextEditingController _id_filter = TextEditingController();
  final TextEditingController _pw_filter = TextEditingController();
  FocusNode focusNode = FocusNode();
  String _idText = '';
  String _pwText = '';

  _LoginScreenState(){
    _id_filter.addListener(() {
      setState(() {
        _idText = _id_filter.text;
      });
    });
    _pw_filter.addListener(() {
      setState(() {
      _pwText = _pw_filter.text;
    });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      resizeToAvoidBottomInset: false, // 키보드가 올라오면서 화면이 밀리는 현상 방지
      backgroundColor: Colors.black,
        body:Container(
          padding: EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                child: Column(
                  children: <Widget>[
                    Container(
                      width: 800,
                      color: Colors.black,
                      alignment: Alignment.center,
                      child: Image.asset('images/logo_eduXR_big.png'),
                      height: 300,
                    ),
                    Container(
                      child: TextField(
                        style: TextStyle(height: 2, fontSize: 15), //height : default 1.2
                        //focusNode: focusNode,
                        autofocus: true,
                        controller: _id_filter,
                        maxLength: 10,
                        decoration: InputDecoration(
                          icon: Icon(Icons.perm_identity),
                          border: OutlineInputBorder(),
                          labelText: 'ID'
                        ),
                      ),
                      padding: EdgeInsets.fromLTRB(200, 20, 200, 20),
                    ),
                    Container(
                      child: TextField(
                        style: TextStyle(height: 2),
                        controller: _pw_filter,
                        obscureText: true,
                        decoration: InputDecoration(
                          icon: Icon(Icons.security),
                          border: OutlineInputBorder(),
                          labelText: 'Password'
                        ),
                      ),
                      padding: EdgeInsets.fromLTRB(200, 0, 200, 50),
                    ),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          //Padding(padding: EdgeInsets.only(right: 100),),
                          SizedBox(
                            width: 350,
                            height: 80,
                            child: FlatButton(
                              color: Colors.cyan,
                              //padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                              child: Text('Login', style: TextStyle(fontSize: 20),),
                              onPressed: () {
                                if(_idText == 'aaa' && _pwText == 'bbb'){
                                  _id_filter.clear(); _idText = '';
                                  _pw_filter.clear(); _pwText = '';
                                  Navigator.of(context).push(MaterialPageRoute<Null>(
                                    fullscreenDialog: true,
                                    builder: (BuildContext context) {
                                      return DefaultTabController(
                                            length: 5, //home, photo picker, musicPlayer, videoPlayer, Calender
                                            child: Scaffold(
                                              body:TabBarView(
                                                physics: NeverScrollableScrollPhysics(),
                                                children: <Widget>[
                                                  HomeScreen(),
                                                  ImagePickerScreen(),
                                                  MusicPlayerScreen(),
                                                  HomeScreen(),
                                                  HomeScreen(),
                                                  //ImagePicker(),
                                                ],
                                              ),
                                              bottomNavigationBar: Bottom(),
                                            ),
                                          );
                                    }
                                    ));
                                }
                                else{
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      _id_filter.clear(); _idText = '';
                                      _pw_filter.clear(); _pwText = '';
                                      return AlertDialog(content: Text('아이디 혹은 비밀번호를 잘못 입력했어요!'));
                                    }
                                  );
                                }
                              },
                            ),
                          ),
                          Padding(padding: EdgeInsets.only(right: 20),),
                          SizedBox(
                            width: 350,
                            height: 80,
                            child: FlatButton(
                              color: Colors.cyan,
                              //padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                              child: Text('Join', style: TextStyle(fontSize: 20),),
                              onPressed: () {},
                            ),
                          ),
                        ],
                      )
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      );
  }
}



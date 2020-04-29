import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/cupertino.dart';

// 이미지 불러오기 -> 이전 목록 / 카메라 / 라이브러리
                  //  -> 이전 목록 페이지 구성 

class ImagePickerScreen extends StatefulWidget {

  _ImagePickerScreenState createState() => _ImagePickerScreenState();
} 

class _ImagePickerScreenState extends State<ImagePickerScreen> {
  File _imageFile;
  dynamic _pickImageEror;
  bool isVideo = false;
  String _retrieveDataEror;

  final double maxWidth = 640;
  final double maxHeight = 480;
  int quality = 100; //0~100

  void _onImageButtonPressed(ImageSource source, BuildContext context) async {
    if(!isVideo) {
      try{
        var image = await ImagePicker.pickImage(
            source: source,
            maxWidth: maxWidth,
            maxHeight: maxHeight,
            imageQuality: quality
        );
        setState((){_imageFile = image;});
      }catch(e) {
        _pickImageEror = e;
      }
    }
    else {

    }
    Image.file(_imageFile);
  }

  @override
  void initState() {
    super.initState();
    
  }
  
  actionSheerMethod(BuildContext context) {
    showCupertinoModalPopup(
      context: context,
      builder: (context) {
        return CupertinoActionSheet(
          title: Text('Load Photos'),
          message: Text('Select How to Load Photos'),
          cancelButton: CupertinoActionSheetAction(
            onPressed: () {Navigator.of(context).pop();},
            child: Text('Cancel', style: TextStyle(color: Colors.red),),
          ),
          actions: <Widget>[
            CupertinoActionSheetAction(
              onPressed: (){
                _onImageButtonPressed(ImageSource.gallery, context);
                Navigator.of(context).pop();
              },
              child: Text('Library'),       
            ),
            CupertinoActionSheetAction(
              onPressed: (){
                _onImageButtonPressed(ImageSource.camera, context);
                Navigator.of(context).pop();
              },
              child: Text('Camera'),       
            )
          ],
          
        );
      },

    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black26,
      body: SafeArea(
        child : Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[     
            SizedBox(
              height: 20,
            ),  
            Container(
              //alignment: Alignment.center,
              child: Text('사진 선택하기', style: TextStyle(fontSize: 20)),
              //padding: EdgeInsets.only(top: 40)
            ),
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.fromLTRB(100, 50, 100, 10),
              child: _imageFile == null ? Padding(padding: EdgeInsets.symmetric(vertical: 200), child: Text('No Image')) : Image.file(_imageFile)
            ),
          ],
        ),
      ),

      floatingActionButton : Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          FloatingActionButton(
            child: Icon(Icons.photo_library),
            onPressed: (){
              actionSheerMethod(context);
            },
          )
        ],
      )
      // floatingActionButton: Column(
      //   mainAxisAlignment: MainAxisAlignment.end,
      //   children: <Widget>[
      //     FloatingActionButton(
      //       onPressed: () {
      //         _onImageButtonPressed(ImageSource.gallery, context);
      //         },
      //         heroTag: 'image0',
      //         tooltip: 'Pick Image From Gallery',
      //         child: const Icon(Icons.photo_library),
      //     ),
      //     Padding(
      //       padding: const EdgeInsets.only(top: 16.0),
      //       child: FloatingActionButton(
      //         onPressed: () {
      //           isVideo = false;
      //           _onImageButtonPressed(ImageSource.camera, context);
      //         },
      //         heroTag: 'image1',
      //         tooltip: 'Take a Photo',
      //         child: const Icon(Icons.camera_alt),
      //       )
      //     )
      //   ],
      // ),
    );
  }
}






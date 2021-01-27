import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test_app/util/like_button.dart';
import 'package:flutter_test_app/util/utils/like_button_model.dart';

class LikeButtonView extends StatefulWidget {
  const LikeButtonView({Key key}) : super(key: key);

  @override
  _LikeButtonView createState() => _LikeButtonView();
}

class _LikeButtonView extends State<LikeButtonView> {

  double dCount = 0;

  SetCount setCountFunc;

  String strC = '';

  @override
  void initState() {
    checkConnect();
    super.initState();
  }

  Timer timer;
  void checkConnect(){
    //每秒发一次心跳请求
    timer = Timer.periodic(Duration(milliseconds: 200), (t) {
//      sendMsg(101);
////      lastSendHeartTime = new DateTime.now().millisecondsSinceEpoch;
//      setState(() {
      dCount++;
      if(setCountFunc != null){
        setCountFunc(dCount);
      }
//      });
    });
  }

  void printResult(){
    String str1 = '123';
    String str2 = '123.0';
    String str3 = '12.01';
    String str4 = '123.10';
    String str5 = '1234.10';
    String str6 = '1234.109';
    String str7 = '1234.1099';
    String str8 = '1234567890.1099';
    List list1 = str1.split('.');
    List list2 = str2.split('.');
    List list3 = str3.split('.');
    List list4 = str4.split('.');
    List list5 = str5.split('.');
    List list6 = str6.split('.');
    List list7 = str7.split('.');
    List list8 = str8.split('.');
    String lastStr1 = '';
    if(list1.length > 1){
      lastStr1 = '.' + list1[1];
    }
    String lastStr2 = '';
    if(list2.length > 1){
      lastStr2 = '.' + list2[1];
    }
    String lastStr3 = '';
    if(list3.length > 1){
      lastStr3 = '.' + list3[1];
    }
    String lastStr4 = '';
    if(list4.length > 1){
      lastStr4 = '.' + list4[1];
    }
    String lastStr5 = '';
    if(list5.length > 1){
      lastStr5 = '.' + list5[1];
    }
    String lastStr6 = '';
    if(list6.length > 1){
      lastStr6 = '.' + list6[1];
    }
    String lastStr7 = '';
    if(list7.length > 1){
      lastStr7 = '.' + list7[1];
    }
    String lastStr8 = '';
    if(list8.length > 1){
      lastStr8 = '.' + list8[1];
    }
    str1 = (list1[0].replaceAllMapped(new RegExp(r"(\d)(?=(?:\d{3})+\b)"), (match)=>"${match.group(1)},")) + lastStr1;
    str2 = (list2[0].replaceAllMapped(new RegExp(r"(\d)(?=(?:\d{3})+\b)"), (match)=>"${match.group(1)},")) + lastStr2;
    str3 = (list3[0].replaceAllMapped(new RegExp(r"(\d)(?=(?:\d{3})+\b)"), (match)=>"${match.group(1)},")) + lastStr3;
    str4 = (list4[0].replaceAllMapped(new RegExp(r"(\d)(?=(?:\d{3})+\b)"), (match)=>"${match.group(1)},")) + lastStr4;
    str5 = (list5[0].replaceAllMapped(new RegExp(r"(\d)(?=(?:\d{3})+\b)"), (match)=>"${match.group(1)},")) + lastStr5;
    str6 = (list6[0].replaceAllMapped(new RegExp(r"(\d)(?=(?:\d{3})+\b)"), (match)=>"${match.group(1)},")) + lastStr6;
    str7 = (list7[0].replaceAllMapped(new RegExp(r"(\d)(?=(?:\d{3})+\b)"), (match)=>"${match.group(1)},")) + lastStr7;
    str8 = (list8[0].replaceAllMapped(new RegExp(r"(\d)(?=(?:\d{3})+\b)"), (match)=>"${match.group(1)},")) + lastStr8;
    print(str1);
    print(str2);
    print(str3);
    print(str4);
    print(str5);
    print(str6);
    print(str7);
    print(str8);

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text('LikeButtonView'),
        ),
        body:Center(
          child: Column(
            children: <Widget>[
              Text(
                strC
              ),
              GestureDetector(
                onTap: (){
                  printResult();
                },
                child: Text(
                  'onTap Print'
                ),
              ),
              LikeButton(
                dCount: dCount,
                changerView:(setCountFunc){
                  this.setCountFunc = setCountFunc;
                },
              )
            ],
          ),
        )
    );
  }
}
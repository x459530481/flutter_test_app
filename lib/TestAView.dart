import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test_app/util/like_button.dart';
import 'package:flutter_test_app/util/utils/like_button_model.dart';

import 'TestBView.dart';

class TestAView extends StatefulWidget {
  const TestAView({Key key}) : super(key: key);

  @override
  _TestAView createState() => _TestAView();
}

class _TestAView extends State<TestAView> with WidgetsBindingObserver{

//  AppLifecycleState _lastLifecycleState;

  void log(String str){
    print('_TestAView---'+str);
  }

  @override
  void initState() {
    log('initState');
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeDependencies() {
    log('didChangeDependencies');
    super.didChangeDependencies();
  }

//  @override
//  void didUpdateWidget(LifecycleAppPage oldWidget) {
//    print('didUpdateWidget');
//    super.didUpdateWidget(oldWidget);
//  }

  @override
  void deactivate() {
    log('deactivate');
    super.deactivate();
  }

  @override
  void dispose() {
    log('dispose');
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
//    switch (state) {
//      case AppLifecycleState.inactive:
//        print('AppLifecycleState.inactive');
//        break;
//      case AppLifecycleState.paused:
//        print('AppLifecycleState.paused');
//        break;
//      case AppLifecycleState.resumed:
//        print('AppLifecycleState.resumed');
//        break;
//      case AppLifecycleState.suspending:
//        print('AppLifecycleState.suspending');
//        break;
//    }

    log('didChangeAppLifecycleState --- ' + state.toString());

    super.didChangeAppLifecycleState(state);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text('TestAView'),
        ),
        body:Center(
          child: Column(
            children: <Widget>[
              GestureDetector(
                onTap: (){
//                  Navigator.of(context).push(
//                    new MaterialPageRoute(
//                      builder: (context) {
//                        return TestBView();
//                      },
//                    ),
//                  );

                  Navigator.of(context).push(
                      PageRouteBuilder(
                          opaque:false,
                          pageBuilder: (context, animation, secondaryAnimation) {
                            return TestBView();
                          }
                      ));
                },
                child: Text(
                  '打开B页面'
                ),
              ),
            ],
          ),
        )
    );
  }
}
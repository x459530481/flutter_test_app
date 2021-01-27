import 'dart:async';

import 'package:flutter/material.dart';

class TestBView extends StatefulWidget {
  const TestBView({Key key}) : super(key: key);

  @override
  _TestBView createState() => _TestBView();
}

class _TestBView extends State<TestBView>  with WidgetsBindingObserver{

  void log(String str){
    print('_TestBView---'+str);
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
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: const Text('Next page'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
        body:Center(
          child: Column(
            children: <Widget>[
              GestureDetector(
                onTap: (){

                },
                child: Text(
                    '打开C页面',style: TextStyle(color: Colors.white)
                ),
              ),
              TextField()
            ],
          ),
        )
//      Container(
//          color: Colors.transparent,
//          child: Text(
//            '打开C页面',style: TextStyle(color: Colors.white),
//          ),
//        )

    );
  }
}
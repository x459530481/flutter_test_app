import 'dart:async';

import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test_app/util/TDCScanSocket.dart';
import 'package:flutter_test_app/util/like_button.dart';
import 'package:flutter_test_app/util/utils/like_button_model.dart';

import 'ConfigUtil.dart';
import 'TestBView.dart';
import 'eventbus/EventBusUtil.dart';

class TDCTestView extends StatefulWidget {
  const TDCTestView({Key key}) : super(key: key);

  @override
  _TDCTestView createState() => _TDCTestView();
}

class _TDCTestView extends State<TDCTestView> with WidgetsBindingObserver{

//  AppLifecycleState _lastLifecycleState;
  static TextEditingController _ipControl = TextEditingController();
  static TextEditingController _deviceCodeControl = TextEditingController();
  ScrollController _scrollController = new ScrollController();

  void log(String str){
    print('_TDCTestView---'+str);
  }

  bool deviceStatus = false;
  List<String> rows = List();

  showMyDialog(String msg){
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('提示'),
            content: Text(msg),
            actions: <Widget>[
              FlatButton(child: Text('确认'),onPressed: (){
                Navigator.pop(context);
              },),
            ],
          );
        });
  }

  @override
  void initState() {
    log('initState');
    super.initState();

    _ipControl.text = '10.1.36.64:1234';
    _deviceCodeControl.text = 'CN17-D5-1';
    WidgetsBinding.instance.addObserver(this);

    EventBusUtil.getInstance().on<ObjectEvent>().listen((data) {
      if (data.tag == ObjectEvent.EVENT_TAG_TDC_DEVICE_STATUS) {
        if(ConfigUtil.TDC_GET_IP_EXCEPTION_CODE == data.obj){
          showMyDialog('TDC地址不正确');
        }else if(ConfigUtil.TDC_CONNECT_EXCEPTION_CODE == data.obj){
          showMyDialog('TDC连接异常');
          deviceStatus = false;
          setState(() {

          });
        }else if(ConfigUtil.TDC_GET_DATA_EXCEPTION_CODE== data.obj){
          showMyDialog('解析接收数据异常');
          deviceStatus = false;
          setState(() {

          });
        }
      }else if (data.tag == ObjectEvent.EVENT_TAG_TDC_CONNECT_SUCCESS) {
        deviceStatus = true;
        setState(() {

        });
      }else if (data.tag == ObjectEvent.EVENT_TAG_TDC_DVEICE_EXCEPTION_CODE) {
        showMyDialog(data.obj.toString());
        deviceStatus = false;
        setState(() {

        });
      }else if(data.tag == ObjectEvent.EVENT_TAG_TDC_TEST_DATA){
        //接收到的内容
        DateTime now = new DateTime.now();
        rows.insert(0, '接收:'+data.obj.toString() + '\r\n' + now.toString());
        setState(() {

        });
      }else if(data.tag == ObjectEvent.EVENT_TAG_TDC_TEST_SEND_DATA){
        //发送的内容
        DateTime now = new DateTime.now();
        rows.insert(0, '发送:'+data.obj.toString() + '\r\n' + now.toString());
        setState(() {

        });
      }
    });
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
          title: Text('TDCTestView'),
        ),
        body:Center(
          child: Column(
            children: <Widget>[
              Flex(
                direction: Axis.horizontal,
                children:[
                  Expanded(
                    flex: 1,
                    child: TextField(
                      controller: _ipControl,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          alignLabelWithHint: false,
                          hintStyle: TextStyle(color: Color(0xffb2b2b2), fontSize: 14),
                          contentPadding: EdgeInsets.only(left: 5),
                          labelText: 'TDC地址',
                        )),
                  ),
                  Expanded(
                    flex: 1,
                    child: Row(
                      children: [
                        RaisedButton(
                          child: Text('点击连接'),
                          onHighlightChanged:(bool b) {
                            print(b);
                          },
                          onPressed: (){
                            ConfigUtil.TDC_IP = _ipControl.text;
                            ConfigUtil.TDC_DEVICE_CODE = _deviceCodeControl.text;
                            if(ConfigUtil.TDC_IP.trim() == ''){
                              showMyDialog('TDC地址不能为空');
                              return;
                            }
                            if(ConfigUtil.TDC_DEVICE_CODE.trim() == ''){
                              showMyDialog('TDC读写器名称不能为空');
                              return;
                            }
                            TDCScanSocket.getInstance().initPDASocket();
                          },
                        ),
                        Offstage(
                          offstage: deviceStatus,
                          child: Text('TDC未连接',style:TextStyle(color: Colors.red)),
                        ),
                        Offstage(
                          offstage: !deviceStatus,
                          child: Text('TDC已连接',style:TextStyle(color: Colors.green)),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Flex(
                direction: Axis.horizontal,
                children: [
                  Expanded(
                    flex: 1,
                    child: TextField(
                      controller: _deviceCodeControl,
                    decoration: InputDecoration(
                      alignLabelWithHint: false,
                      hintStyle: TextStyle(color: Color(0xffb2b2b2), fontSize: 14),
                      contentPadding: EdgeInsets.only(left: 5),
                      labelText: 'TDC读写器名称',
                    ),
                  ),
                  ),
                  Expanded(
                    flex: 1,
                    child: RaisedButton(
                    child: Text('获取读写器状态'),
                    onHighlightChanged:(bool b) {
                      print(b);
                    },
                    onPressed: (){
                      ConfigUtil.TDC_DEVICE_CODE = _deviceCodeControl.text;
                      if(ConfigUtil.TDC_DEVICE_CODE.trim() == ''){
                        showMyDialog('TDC读写器名称不能为空');
                      }else{
                        TDCScanSocket.getInstance().getDeviceStatus();
                      }
                    },
                  ),)
                ],
              ),


              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  RaisedButton(
                    child: Text('清空列表'),
                    onHighlightChanged:(bool b) {
                      print(b);
                    },
                    onPressed: (){
                      rows.clear();
                      setState(() {

                      });
                    },
                  ),

                  RaisedButton(
                    child: Text('开始扫描'),
                    onHighlightChanged:(bool b) {
                      print(b);
                    },
                    onPressed: (){
                      if(!deviceStatus){
                        showMyDialog('尚未连接到TDC');
                      }else{
                        TDCScanSocket.getInstance().beginScan();
                      }
                    },
                  ),
                ],
              ),
              Expanded(
                  flex: 1,
                  child: _billList()
              ),
            ],
          ),
        )
    );
  }

  ///单据列表
  Widget _billList() {
    return Container(
      ///ListView没有和AppBar一起使用时，头部会有一个padding，为了去掉padding，可以使用MediaQuery.removePadding:
        child: MediaQuery.removePadding(
          context: context,
          removeTop: true,
          child: new ListView.builder(
            itemCount: rows.length,
            itemBuilder: (BuildContext context, int index) {
              return new Container(
                padding: const EdgeInsets.all(8.0),
                child: _buildItem(rows[index]),
              );
            },
            controller: _scrollController,
            //解决item太少不满一屏时不能下拉刷新问题。
            physics: AlwaysScrollableScrollPhysics(),
          ),
        ));
  }

  Widget _buildItem(String str) {
    if(str.indexOf('发送') == 0){
      return Text(str,style:TextStyle(color: Colors.red));
    }else if(str.indexOf('接收') == 0){
      return Text(str,style:TextStyle(color: Colors.green));
    }else{
      return Text(str);
    }

  }
}
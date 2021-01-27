import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flustars/flustars.dart';
import 'package:flutter_test_app/ConfigUtil.dart';
import 'package:flutter_test_app/bean/TDCBean.dart';
import 'package:flutter_test_app/eventbus/EventBusUtil.dart';

class TDCScanSocket {

  //写一个单例
  //在 Dart 里，带下划线开头的变量是私有变量
  static TDCScanSocket _instance;

  String socketIp = '';
  String host = '';
  int port = 0;
  static Socket socket;

  static TDCScanSocket getInstance() {
    if (_instance == null) {
      _instance = TDCScanSocket();
    }
    return _instance;
  }

  //获取设备状态是否成功
  // {"command": "device_status_result","deviceCode": "CN17-D5-1","code":0,"errMsg": ""}
  // {"command": "device_status_result","deviceCode": "CN17-D5-1","code":1,"errMsg": "错误原因"}

  //获取读码是否成功
  // {"command": "begin_scan_result","deviceCode": "CN17-D5-1","code":0,"data":"码内容EEEEEEEEEEEEEEEEEEEEEEE","errMsg": ""}
  // {"command": "begin_scan_result","deviceCode": "CN17-D5-1","code":1,"data":"","errMsg": "错误原因"}

  //发送获取TDC设备状态指令
  Map<String,dynamic> _get_device_status(){
    return {'command':'get_device_status','deviceCode':ConfigUtil.TDC_DEVICE_CODE};
  }

  //发送TDC设备开始扫描指令
  Map<String,dynamic> _begin_scan(){
    return {'command':'begin_scan','deviceCode':ConfigUtil.TDC_DEVICE_CODE};
  }

  TDCScanSocket() {
//    initPDASocket();
  }

  static closeSocket(){
    try {
      if (socket != null) {
        socket.close();
        socket = null;
      }
    }catch(e){
      print("关闭异常："+e.toString());
    }
  }

  Future initPDASocket() async {

    closeSocket();
//
    socketIp = ConfigUtil.TDC_IP;
    if (TextUtil.isEmpty(socketIp) || socketIp.indexOf(":")==-1) {
      EventBusUtil.getInstance().fire(ObjectEvent(ObjectEvent.EVENT_TAG_TDC_DEVICE_STATUS,ConfigUtil.TDC_GET_IP_EXCEPTION_CODE));
    //todo 以上改为  eventbus
      return;
    }
    List<String> ipStr = socketIp.split(":");
    if (ipStr != null && ipStr.length >= 2) {
      host = ipStr[0];
      port = int.parse(ipStr[1]);
    }

    //todo 以上改为 eventbus

    try {
      socket = await Socket.connect(host, port, timeout: Duration(seconds: 3));
      sendData(_get_device_status());
//      EventBusUtil.getInstance().fire(ObjectEvent(ObjectEvent.EVENT_TAG_TDC_DEVICE_STATUS,ConfigUtil.TDC_CONNECT_SUCCESS_CODE));
    } catch (e) {
      print("连接socket出现异常，e=${e.toString()}");
      EventBusUtil.getInstance().fire(ObjectEvent(ObjectEvent.EVENT_TAG_TDC_DEVICE_STATUS,ConfigUtil.TDC_CONNECT_EXCEPTION_CODE));
      //todo 以上改为 eventbus
      return;
    }

    //todo 以上改为 eventbus

    List<int> byteStr = new List();
    socket.listen(
            (onData){
              print('TDCSocket listen onData==' + onData.toString());
              print('TDCSocket listen utf8.decode(onData)==' + utf8.decode(onData));
              StringBuffer stringBuffer = new StringBuffer(utf8.decode(onData));
              String jsonStr = stringBuffer.toString();
              log("TDCSocket服务器："+jsonStr);
              if(!TextUtil.isEmpty(jsonStr)){
                EventBusUtil.getInstance().fire(ObjectEvent(
                    ObjectEvent.EVENT_TAG_TDC_TEST_DATA,
                    jsonStr+'\r\n'+onData.toString()));
                try {
                  Map<String, dynamic> srcJson = json.decode(jsonStr);
                  var tdcBean = TDCBean.fromJson(srcJson);
                  if(tdcBean != null && tdcBean.deviceCode !=null && tdcBean.deviceCode == ConfigUtil.TDC_DEVICE_CODE && tdcBean.command != null){
                    if(tdcBean.command == 'device_status_result'){
                      //读写器状态
                      if (tdcBean.code == 0) {
                        EventBusUtil.getInstance().fire(ObjectEvent(
                            ObjectEvent.EVENT_TAG_TDC_CONNECT_SUCCESS, ""));
                      }else{
                        EventBusUtil.getInstance().fire(ObjectEvent(
                            ObjectEvent.EVENT_TAG_TDC_DVEICE_EXCEPTION_CODE,
                            tdcBean.errMsg));
                      }
                    } else if(tdcBean.command == 'begin_scan_result'){
                      //采集到的数据
                      if(tdcBean.code ==0){
                        EventBusUtil.getInstance().fire(ObjectEvent(
                            ObjectEvent.EVENT_TAG_TDC_SCAN_CODE_RESULT, tdcBean.data));
                      }else{
                        EventBusUtil.getInstance().fire(ObjectEvent(
                            ObjectEvent.EVENT_TAG_TDC_SCAN_CODE_ERROR_RESULT, tdcBean.errMsg));
                      }
                    }
                  }
                }catch(e){
                  //todo
                  print(e);
                  EventBusUtil.getInstance().fire(ObjectEvent(ObjectEvent.EVENT_TAG_TDC_DEVICE_STATUS,ConfigUtil.TDC_GET_DATA_EXCEPTION_CODE));
                }
              }
        },
        onError: (err){
          print('服务器  失败');
          print('服务器 error==' + err.toString());
          EventBusUtil.getInstance().fire(ObjectEvent(ObjectEvent.EVENT_TAG_TDC_DEVICE_STATUS,ConfigUtil.TDC_CONNECT_EXCEPTION_CODE));
          // EventBusUtil.getInstance().fire(ObjectEvent(ObjectEvent.EVENT_TAG_TDC_CONNECT_FAIL,ConfigUtil.TDC_CONNECT_EXCEPTION_CODE));
          //todo 以上改为 eventbus
        },
        onDone: (){
          print('服务器 done');
          ///控制设备状态的显示
//          EventBusUtil.getInstance().fire(ObjectEvent(ObjectEvent.EVENT_TAG_TDC_CONNECT_FTDCL,ConfigUtil.TDC_CONNECT_EXCEPTION_CODE));
          //todo 以上改为 eventbus
        },
        cancelOnError: true);
  }


  getDeviceStatus(){
    sendData(_get_device_status());
  }

  beginScan(){
    sendData(_begin_scan());
  }

 static Future sendData(Map<String,dynamic> mapData)async{
    String jsonData =  jsonEncode(mapData);
    EventBusUtil.getInstance().fire(ObjectEvent(ObjectEvent.EVENT_TAG_TDC_TEST_SEND_DATA,jsonData));
    if(socket != null){
      print('socket');
      try{
        print("jsonData："+jsonData);
        socket.write(jsonData);
        print("codeChannel准备写入");
        await socket.flush(); //发
        print("写入成功");
        //todo 以上改为 eventbus
      }catch(e){
//        print("socket写入异常准备恢复手机摄像头扫码");
        EventBusUtil.getInstance().fire(ObjectEvent(ObjectEvent.EVENT_TAG_TDC_DEVICE_STATUS,ConfigUtil.TDC_CONNECT_EXCEPTION_CODE));
        print("写入失败");
        print(e.toString());
        return;
      }
    }
  }
}
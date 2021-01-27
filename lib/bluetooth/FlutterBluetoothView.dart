import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bluetooth/flutterbluetooth.dart';

class FlutterBluetoothView extends StatefulWidget {
  const FlutterBluetoothView({Key key}) : super(key: key);

  @override
  _FlutterBluetoothView createState() => _FlutterBluetoothView();
}

class _FlutterBluetoothView extends State<FlutterBluetoothView> {

  String macAddress = '';
  MethodChannel _channel;
  bool bluetoothConnection = false;
  String byteList = '';
  String byteList2Str = '';
  void log(String str){
    print('_FlutterBluetoothView---'+str);
  }

  @override
  void initState() {
    log('initState');
    this._channel = new MethodChannel('flutterbluetooth');
    this._channel.setMethodCallHandler((handler) {
      switch (handler.method) {
        case "connection_successful":
         log(handler.arguments.toString());
         setState(() {
           bluetoothConnection = true;
         });
          break;
        case "connection_failed":
          log(handler.arguments.toString());
          setState(() {
            bluetoothConnection = false;
          });
          break;
        case "disconnect_success":
          log(handler.arguments.toString());
          break;
        case "found_result":
          log(handler.arguments.toString());
          String str = handler.arguments.toString();
          if(str != null && str != ''){
            Map<String, dynamic> map = json.decode(str);
            if(map['name'] == 'irxon'){
              setState(() {
                macAddress = map['address'];
              });
            }
          }
          break;
        case "found_finish":
          log(handler.arguments.toString());
          break;
        case "no_bluetooth":
          log(handler.arguments.toString());
          break;
        case "no_enabled_bluetooth":
          log(handler.arguments.toString());
          break;
        case "received":
          String str = handler.arguments.toString();
          log(str);
          String origin_bytes = '';
          String bytes_to_hex = '';
//          String bytes_to_utf8 = '';
          if(str != null && str != ''){
            Map<String, dynamic> map = json.decode(str);
            origin_bytes = map['origin_bytes'];
            bytes_to_hex = map['bytes_to_hex'];
//            bytes_to_utf8 = map['bytes_to_utf8'];
          }

          print('origin_bytes='+origin_bytes);
          print('bytes_to_hex='+bytes_to_hex);
//          print('bytes_to_utf8='+bytes_to_utf8);

          if(bytes_to_hex != ''){
            List <String> list = bytes_to_hex.split(' ');
            if(list.length > 0 && list[0] == '02'){
              if(list.last == '0A'){
                String hexStr = bytes_to_hex.substring(2,bytes_to_hex.length-5);
                log("hexStr="+hexStr);
                Flutterbluetooth.hex2utf8(hexStr);
                return;
              }
            }
          }
          setState(() {
            byteList2Str = bytes_to_hex;
          });
          break;
        case "hex2utf8_successful":
        //接收转换成功后的值
          log(handler.arguments.toString());
          setState(() {
            byteList2Str = handler.arguments.toString();
          });
          break;
        case "hex2utf8_error":
        //接收转换失败
          log(handler.arguments.toString());
          setState(() {
            byteList2Str = handler.arguments.toString();
          });
          break;
        case "connection_failed_11":
        //连接断开
          log(handler.arguments.toString());
          break;
        case "connection_successful_11":
        //连接断开后重连成功
          log(handler.arguments.toString());
          break;
        case "connecting":
        //连接中
          log(handler.arguments.toString());
          break;
      }
    });

    super.initState();
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
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('FlutterBluetoothView'),
          elevation: 0,
        ),
        body:Center(
          child: Column(
            children: <Widget>[
              Text('mac:${macAddress ?? 'no address'}'),
              GestureDetector(
                onTap: (){
                  Flutterbluetooth.init();
                },
                child: Container(
                    alignment: Alignment.center,
                    height: 40,
                    child: Text(
                        '初始化蓝牙设备'
                    )
                ),
              ),
              GestureDetector(
                onTap: (){
                  Flutterbluetooth.discovery();
                },
                child: Container(
                  alignment: Alignment.center,
                  height: 40,
                  child: Text(
                    '搜索蓝牙设备'
                  )),
              ),
              GestureDetector(
                onTap: (){
                  Flutterbluetooth.cancelDiscovery();
                },
                child: Container(
                  alignment: Alignment.center,
                  height: 40,
                  child: Text(
                    '停止搜索蓝牙设备'
                  )),
              ),
              GestureDetector(
                onTap: (){
                  Flutterbluetooth.connting(macAddress);
                },
                child: Container(
                  alignment: Alignment.center,
                  height: 40,
                  child: Text(
                      '连接蓝牙设备'
                  ),
                ),
              ),
              GestureDetector(
                onTap: (){
//                  Flutterbluetooth.checkConnected();
                  Flutterbluetooth.sendData(Uint8List.fromList([00]));
                },
                child: Container(
                  alignment: Alignment.center,
                  height: 40,
                  child: Text(
                      '检测蓝牙连接状态'
                  ),
                ),
              ),
              Offstage(
                offstage: !bluetoothConnection,
                child:Container(
                  alignment: Alignment.center,
                  height: 40,
                  child: Text(
                      byteList2Str
                  ),
                ),
              ),
              Offstage(
                offstage: !bluetoothConnection,
                child: GestureDetector(
                  onTap: (){

                    Flutterbluetooth.sendData(Uint8List.fromList([06]));
                  },
                  child: Container(
                    alignment: Alignment.center,
                    height: 40,
                    child: Text(
                        '发送反馈[06]'
                    ),
                  ),
                ),
              )
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
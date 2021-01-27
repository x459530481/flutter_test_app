import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';

/** 消息长度用2个字节描述 */
const int msgByteLen = 2;

/** 消息号用2个字节描述 */
const int msgCodeByteLen = 2;

/** 最小的消息长度为4个字节（即消息长度+消息号） */
const int minMsgByteLen = msgByteLen + msgCodeByteLen;

class SocketView extends StatefulWidget {
  const SocketView({Key key}) : super(key: key);

  @override
  _SocketView createState() => _SocketView();
}

class _SocketView extends State<SocketView> {
  TextEditingController textController = TextEditingController();

  /** 缓存的网络数据，暂未处理（一般这里有数据，说明当前接收的数据不是一个完整的消息，需要等待其它数据的到来拼凑成一个完整的消息） */
  Int8List cacheData = Int8List(0);

  @override
  void initState(){
    checkConnect();
  }

  Socket codeChannel;
  void initConnect() async {
    if(codeChannel != null){
      timer.cancel();
      codeChannel.close();
      codeChannel.destroy();
      codeChannel = null;
    }
    checkConnect();

//    String socketUrl = 'ws://' + StringUtil.getString(pdaCommandConfig.deviceAddressConfig.Address);
//    print('socketUrl=' + socketUrl);

//    List urlList = StringUtil.getString(pdaCommandConfig.deviceAddressConfig.Address).split(':');
    String ipStr = '10.1.36.88';
    int portInt = 1234;
//    if(urlList != null && urlList.length > 1){
//      ipStr = urlList[0];
//      String portStr = urlList[1];
//      if(int.tryParse(portStr) != null){
//        portInt = int.parse(portStr);
//      }
//    }

    await Socket.connect(ipStr,portInt).then((Socket socket)  {
      print('服务器  成功');
      codeChannel = socket;
//      codeChannel.listen((onData){
//        print('服务器==' + utf8.decode(onData));
//      },onError:(err){
//        print('服务器  失败');
//        print('服务器 error==' + err);
//      },onDone:(){
//        print('服务器  完成');
//        print('服务器 done');
//        if(codeChannel != null){
//          codeChannel.close();
//          codeChannel = null;
//        }
//      });      //多次订阅的流 如果直接用socket.listen只能订阅一次


      codeChannel.listen(decodeHandle,
          onError: errorHandler,
          onDone: doneHandler,
          cancelOnError: false);
    }).catchError((e) {
      print('connectException:$e');
//      initCodeConnect();
    });
  }

  @override
  void dispose() {
    if(codeChannel != null){
      codeChannel.close();
      codeChannel = null;
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text('SocketView'),
      ),
      body:Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: textController,
            ),
            RaisedButton(
              child: const Text('发送',),
              onPressed: () {
                sendMsg(100);
              },
            ),
            RaisedButton(
              child: const Text('连接',),
              onPressed: () {
                initConnect();
              },
            ),
          ],
        ),
      )
    );
  }

  Timer timer;
  void checkConnect(){
    //每秒发一次心跳请求
    timer = Timer.periodic(Duration(seconds: 1), (t){
      sendMsg(101);
//      lastSendHeartTime = new DateTime.now().millisecondsSinceEpoch;
    });
  }

  void sendMsg(int type) async{
    print('send ' + type.toString());
    if(codeChannel != null){
      print('socket');
      if(type == 100){
        codeChannel.writeln(textController.text.toString());
      }else if(type == 101){
        codeChannel.writeln('');
      }
      await codeChannel.flush(); //发送
    }
  }

  /**
   * 解码处理方法
   * 处理服务器发过来的数据，注意，这里要处理粘包，这个data参数不一定是一个完整的包
   */
  void decodeHandle(newData){
    print('服务器==' + utf8.decode(newData));
    //拼凑当前最新未处理的网络数据
    cacheData = Int8List.fromList(cacheData + newData);

    //缓存数据长度符合最小包长度才尝试解码
    while(cacheData.length >= minMsgByteLen){
      //读取消息长度
      var byteData = cacheData.buffer.asByteData();
      var msgLen = byteData.getInt16(0);

      //数据长度小于消息长度，说明不是完整的数据，暂不处理
      if(cacheData.length < msgLen + msgByteLen){
        return;
      }
      //读取消息号
      int msgCode = byteData.getInt16(msgCodeByteLen);
      //读取pb数据
      int pbLen = msgLen - msgCodeByteLen;
      Int8List pbBody;
      if(pbLen > 0){
        pbBody = cacheData.sublist(minMsgByteLen, msgLen + msgByteLen);
      }

      //整理缓存数据
      int totalLen = msgByteLen + msgLen;
      cacheData = cacheData.sublist(totalLen, cacheData.length);

//      Function handler = msgHandlerPool[msgCode];
//      if(handler == null){
//        print("没有找到消息号$msgCode的处理器");
//        return;
//      }
//
//      //处理消息
//      handler(pbBody);
    }
  }

//  ByteBuffer encodeKey(String key) {
//    try {
//      return ByteBuffer.wrap(key.getBytes("utf-8"));
//    } catch (UnsupportedEncodingException e) {
//    e.printStackTrace();
//    }
//    return ByteBuffer.wrap(key.getBytes());
//  }
//
//
//  /**
//   * 发消息，指定消息号，pb对象可以为不传(例如发心跳包的时候)
//   */
//  void sendMsg(int msgCode, ){
//    String msg = textController.text.toString();
//
//    ByteBuffer buffer = ByteBuffer();
//    buffer.
//
//    //序列化pb对象
//    Uint8List pbBody;
//    int pbLen = 0;
////    if(pb != null) {
////      pbBody = pb.writeToBuffer();
////      pbLen = pbBody.length;
////    }
//
//    //包头部分
//    var header = ByteData(minMsgByteLen);
//    header.setInt16(0, msgCodeByteLen + pbLen);
//    header.setInt16(msgByteLen, msgCode);
//
//    //包头+pb组合成一个完整的数据包
//    var msg = pbBody == null ? header.buffer.asUint8List() : header.buffer.asUint8List() + pbBody.buffer.asUint8List();
//
//    //给服务器发消息
//    try {
//      codeChannel.add(msg);
//      print("给服务端发送消息，消息号=$msgCode");
//    } catch (e) {
//      print("send捕获异常：msgCode=${msgCode}，e=${e.toString()}");
//    }
//  }

  void errorHandler(error, StackTrace trace){
    print('服务器  失败');
    print('服务器 error==' + error);
    print("捕获socket异常信息：error=$error，trace=${trace.toString()}");
    codeChannel.close();
  }

  void doneHandler(){
    print('服务器  完成');
    print('服务器 done');
    codeChannel.destroy();
    print("socket关闭处理");
  }
}
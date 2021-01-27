//import 'package:flutter_test_app/tts/tts_helper.dart';
//
//import 'package:flutter/material.dart';
//
//class VoiceSetPage extends StatefulWidget {
//  VoiceSetPage({Key key, this.title}) : super(key: key);
//
//  final String title;
//
//  @override
//  _VoiceSetPageState createState() => _VoiceSetPageState();
//}
//
//class _VoiceSetPageState extends State<VoiceSetPage> {
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      appBar: AppBar(
//
//        backgroundColor: Colors.blue,
//        title: Text(widget.title),
//        elevation: 5.0, // shadow the bottom of AppBar
//      ),
//      body: Center(
//        child: ListView(
//          children: <Widget>[
//            ListTile(
//              title: Text(
//                'test vioce',
//                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20.0),
//              ),
//              onTap: () {
//                showAlertDialog(context);
//                TtsHelper.instance.setLanguageAndSpeak("你能听到声音么", "zh");
//              },
//            ),
//            Divider(
//              height: 1,
//            )
//          ],
//        ),
//      ),
//    );
//  }
//}
//
//void showAlertDialog(BuildContext context) {
//  NavigatorState navigator =
//  context.rootAncestorStateOfType(const TypeMatcher<NavigatorState>());
//  debugPrint("navigator is null?" + (navigator == null).toString());
//  showDialog(
//      context: context,
//      builder: (_) => new AlertDialog(
//          title: new Text("Dialog Title"),
//          content: new Text("This is my content"),
//          actions: <Widget>[
//            new FlatButton(
//              child: new Text("CANCEL"),
//              onPressed: () {
//                Navigator.of(context).pop();
//              },
//            ),
//            new FlatButton(
//              child: new Text("OK"),
//              onPressed: () {
//                Navigator.of(context).pop();
//              },
//            )
//          ]));
//}

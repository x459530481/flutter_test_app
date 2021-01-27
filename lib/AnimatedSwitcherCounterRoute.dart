//import 'package:flutter/material.dart';
//
//class AnimatedSwitcherCounterRoute extends StatefulWidget {
//  const AnimatedSwitcherCounterRoute({Key key}) : super(key: key);
//
//  @override
//  _AnimatedSwitcherCounterRouteState createState() => _AnimatedSwitcherCounterRouteState();
//}
//
//class _AnimatedSwitcherCounterRouteState extends State<AnimatedSwitcherCounterRoute> {
//  int _count = 0;
//  List <String> strList = List();
//
//  @override
//  Widget build(BuildContext context) {
//    if(strList.length == 0){
//      strList.add('0');
//    }
//    return Scaffold(
//      appBar: AppBar(
//        // Here we take the value from the MyHomePage object that was created by
//        // the App.build method, and use it to set our appbar title.
//        title: Text('AnimatedSwitcherCounterRoute'),
//      ),
//      body:Center(
//        child: Column(
//          mainAxisAlignment: MainAxisAlignment.center,
//          children: <Widget>[
//            Text('TextLiquidFill'),
//            SizedBox(
//              width: 250.0,
//              child: TextLiquidFill(
//                text: 'LIQUIDY',
//                waveColor: Colors.blueAccent,
//                boxBackgroundColor: Colors.redAccent,
//                textStyle: TextStyle(
//                  fontSize: 20.0,
//                  fontWeight: FontWeight.bold,
//                ),
//                boxHeight: 75.0,
//              ),
//            ),
//            Text('ColorizeAnimatedTextKit'),
//            SizedBox(
//              width: 250.0,
//              child: ColorizeAnimatedTextKit(
//                  onTap: () {
//                    print("Tap Event");
//                  },
//                  text: [
//                    "Larry Page",
//                    "Bill Gates",
//                    "Steve Jobs",
//                  ],
//                  textStyle: TextStyle(
//                      fontSize: 50.0,
//                      fontFamily: "Horizon"
//                  ),
//                  colors: [
//                    Colors.purple,
//                    Colors.blue,
//                    Colors.yellow,
//                    Colors.red,
//                  ],
//                  textAlign: TextAlign.start,
//                  alignment: AlignmentDirectional.topStart // or Alignment.topLeft
//              ),
//            ),
//            Text('ScaleAnimatedTextKit'),
//            SizedBox(
//              width: 250.0,
//              child: ScaleAnimatedTextKit(
//                  onTap: () {
//                    print("Tap Event");
//                  },
//                  text: [
//                    "Think",
//                    "Build",
//                    "Ship"
//                  ],
//                  textStyle: TextStyle(
//                      fontSize: 16.0,
//                      fontFamily: "Canterbury"
//                  ),
//                  textAlign: TextAlign.start,
//                  alignment: AlignmentDirectional.topStart // or Alignment.topLeft
//              ),
//            ),
//            Text('TypewriterAnimatedTextKit'),
//            SizedBox(
//              width: 250.0,
//              child: TypewriterAnimatedTextKit(
//                  onTap: () {
//                    print("Tap Event");
//                  },
//                  text: [
//                    "Discipline is the best tool",
//                    "Design first, then code",
//                    "Do not patch bugs out, rewrite them",
//                    "Do not test bugs out, design them out",
//                  ],
//                  textStyle: TextStyle(
//                      fontSize: 16.0,
//                      fontFamily: "Agne"
//                  ),
//                  textAlign: TextAlign.start,
//                  alignment: AlignmentDirectional.topStart // or Alignment.topLeft
//              ),
//            ),
//            Text('TyperAnimatedTextKit'),
//            SizedBox(
//              width: 250.0,
//              child: TyperAnimatedTextKit(
//                  onTap: () {
//                    print("Tap Event");
//                  },
//                  text: [
//                    "It is not enough to do your best,",
//                    "you must know what to do,",
//                    "and then do your best",
//                    "- W.Edwards Deming",
//                  ],
//                  textStyle: TextStyle(
//                      fontSize: 16.0,
//                      fontFamily: "Bobbers"
//                  ),
//                  textAlign: TextAlign.start,
//                  alignment: AlignmentDirectional.topStart // or Alignment.topLeft
//              ),
//            ),
//            Text('FadeAnimatedTextKit'),
//            SizedBox(
//              width: 250.0,
//              child: FadeAnimatedTextKit(
//                  onTap: () {
//                    print("Tap Event");
//                  },
//                  text: [
//                    "do IT!",
//                    "do it RIGHT!!",
//                    "do it RIGHT NOW!!!"
//                  ],
//                  textStyle: TextStyle(
//                      fontSize: 16.0,
//                      fontWeight: FontWeight.bold
//                  ),
//                  textAlign: TextAlign.start,
//                  alignment: AlignmentDirectional.topStart // or Alignment.topLeft
//              ),
//            ),
//            Text('RotateAnimatedTextKit'),
//            Row(
//              mainAxisSize: MainAxisSize.min,
//              children: <Widget>[
//                SizedBox(width: 20.0, height: 50.0),
//                Text(
//                  "Be",
//                  style: TextStyle(fontSize: 16.0),
//                ),
//                SizedBox(width: 20.0, height: 50.0),
//                RotateAnimatedTextKit(
//                    onTap: () {
//                      print("Tap Event");
//                    },
////                    text: ["AWESOME", "OPTIMISTIC", "DIFFERENT"],
//                    text: strList,
//                    textStyle: TextStyle(fontSize: 16.0, fontFamily: "Horizon"),
//                    textAlign: TextAlign.start,
//                    alignment: AlignmentDirectional.topStart // or Alignment.topLeft
//                ),
//              ],
//            ),
//            Text('TypewriterAnimatedTextKit'),
//            TypewriterAnimatedTextKit(
////              duration: Duration(milliseconds: 2000),
//                totalRepeatCount: 4,
//                pause: Duration(milliseconds:  1000),
//                text: ["do IT!", "do it RIGHT!!", "do it RIGHT NOW!!!"],
//                textStyle: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
////                pause: Duration(milliseconds: 1000),
//                displayFullTextOnTap: true,
//                stopPauseOnTap: true
//            ),
//            Text('上下左右'),
//            Container(
//              height: 30,
//              child: AnimatedSwitcher(
//                duration: Duration(milliseconds: 200),
//                transitionBuilder: (Widget child, Animation<double> animation) {
////                  var tween=Tween<Offset>(begin: Offset(1, 0), end: Offset(0, 0));
//                  return SlideTransitionX(
//                    child: child,
//                    direction: AxisDirection.down, //上入下出
//                    position: animation,
//                  );
//                },
//                child: Text(
//                  '$_count',
//                  //显示指定key，不同的key会被认为是不同的Text，这样才能执行动画
//                  key: ValueKey<int>(_count),
//                ),
//              ),
//            ),
//            Text('左右'),
//            AnimatedSwitcher(
//                duration: Duration(milliseconds: 200),
//                transitionBuilder: (Widget child, Animation<double> animation) {
//                  var tween=Tween<Offset>(begin: Offset(1, 0), end: Offset(0, 0));
//                  return MySlideTransition(
//                    child: child,
//                    position: tween.animate(animation),
//                  );
//                },
//              child: Text(
//                '$_count',
//                //显示指定key，不同的key会被认为是不同的Text，这样才能执行动画
//                key: ValueKey<int>(_count),
//                style: Theme.of(context).textTheme.display1,
//              ),
//            ),
//            Text('大小'),
//            AnimatedSwitcher(
//              duration: const Duration(milliseconds: 500),
//              transitionBuilder: (Widget child, Animation<double> animation) {
//                //执行缩放动画
//                return ScaleTransition(child: child, scale: animation);
//              },
//              child: Text(
//                '$_count',
//                //显示指定key，不同的key会被认为是不同的Text，这样才能执行动画
//                key: ValueKey<int>(_count),
//                style: Theme.of(context).textTheme.display1,
//              ),
//            ),
//            RaisedButton(
//              child: const Text('+1',),
//              onPressed: () {
//                setState(() {
//                  _count += 1;
//                  strList.clear();
//                  strList.add('$_count');
//                });
//              },
//            ),
//          ],
//        ),
//      )
//    );
//  }
//}
//
//class MySlideTransition extends AnimatedWidget {
//  MySlideTransition({
//    Key key,
//    @required Animation<Offset> position,
//    this.transformHitTests = true,
//    this.child,
//  })
//      : assert(position != null),
//        super(key: key, listenable: position) ;
//
//  Animation<Offset> get position => listenable;
//  final bool transformHitTests;
//  final Widget child;
//
//  @override
//  Widget build(BuildContext context) {
//    Offset offset=position.value;
//    //动画反向执行时，调整x偏移，实现“从左边滑出隐藏”
//    if (position.status == AnimationStatus.reverse) {
//      offset = Offset(-offset.dx, offset.dy);
//    }
//    return FractionalTranslation(
//      translation: offset,
//      transformHitTests: transformHitTests,
//      child: child,
//    );
//  }
//}
//
//
//class SlideTransitionX extends AnimatedWidget {
//  SlideTransitionX({
//    Key key,
//    @required Animation<double> position,
//    this.transformHitTests = true,
//    this.direction = AxisDirection.down,
//    this.child,
//  })
//      : assert(position != null),
//        super(key: key, listenable: position) {
//    // 偏移在内部处理
//    switch (direction) {
//      case AxisDirection.up:
//        _tween = Tween(begin: Offset(0, 1), end: Offset(0, 0));
//        break;
//      case AxisDirection.right:
//        _tween = Tween(begin: Offset(-1, 0), end: Offset(0, 0));
//        break;
//      case AxisDirection.down:
//        _tween = Tween(begin: Offset(0, -1), end: Offset(0, 0));
//        break;
//      case AxisDirection.left:
//        _tween = Tween(begin: Offset(1, 0), end: Offset(0, 0));
//        break;
//    }
//  }
//
//
//  Animation<double> get position => listenable;
//
//  final bool transformHitTests;
//
//  final Widget child;
//
//  //退场（出）方向
//  final AxisDirection direction;
//
//  Tween<Offset> _tween;
//
//  @override
//  Widget build(BuildContext context) {
//    Offset offset = _tween.evaluate(position);
//    if (position.status == AnimationStatus.reverse) {
//      switch (direction) {
//        case AxisDirection.up:
//          offset = Offset(offset.dx, -offset.dy);
//          break;
//        case AxisDirection.right:
//          offset = Offset(-offset.dx, offset.dy);
//          break;
//        case AxisDirection.down:
//          offset = Offset(offset.dx, -offset.dy);
//          break;
//        case AxisDirection.left:
//          offset = Offset(-offset.dx, offset.dy);
//          break;
//      }
//    }
//    return FractionalTranslation(
//      translation: offset,
//      transformHitTests: transformHitTests,
//      child: child,
//    );
//  }
//}
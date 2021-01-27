import 'package:flutter/material.dart';

class AnimatedSwitcherCounterRouteChildView extends StatefulWidget {
  const AnimatedSwitcherCounterRouteChildView({Key key}) : super(key: key);

  @override
  _AnimatedSwitcherCounterRouteChildView createState() => _AnimatedSwitcherCounterRouteChildView();
}

class _AnimatedSwitcherCounterRouteChildView extends State<AnimatedSwitcherCounterRouteChildView> {
  int _count = 0;
  List <String> strList = List();

  @override
  Widget build(BuildContext context) {
    if(strList.length == 0){
      strList.add('0');
      strList.add('1');
      strList.add('2');
    }
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text('AnimatedSwitcherCounterRoute'),
      ),
      body:Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

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
            Text('上下左右'),
            Container(
              height: 30,
              child: AnimatedSwitcher(
                duration: Duration(milliseconds: 200),
                transitionBuilder: (Widget child, Animation<double> animation) {
//                  var tween=Tween<Offset>(begin: Offset(1, 0), end: Offset(0, 0));
                  return SlideTransitionX(
                    child: child,
                    direction: AxisDirection.down, //上入下出
                    position: animation,
                  );
                },
                child: Text(
                  '$_count',
                  //显示指定key，不同的key会被认为是不同的Text，这样才能执行动画
                  key: ValueKey<int>(_count),
                ),
              ),
            ),
            Text('左右'),
            AnimatedSwitcher(
                duration: Duration(milliseconds: 200),
                transitionBuilder: (Widget child, Animation<double> animation) {
                  var tween=Tween<Offset>(begin: Offset(1, 0), end: Offset(0, 0));
                  return MySlideTransition(
                    child: child,
                    position: tween.animate(animation),
                  );
                },
              child: Text(
                '$_count',
                //显示指定key，不同的key会被认为是不同的Text，这样才能执行动画
                key: ValueKey<int>(_count),
                style: Theme.of(context).textTheme.display1,
              ),
            ),
            Text('大小'),
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 500),
              transitionBuilder: (Widget child, Animation<double> animation) {
                //执行缩放动画
                return ScaleTransition(child: child, scale: animation);
              },
              child: Text(
                '$_count',
                //显示指定key，不同的key会被认为是不同的Text，这样才能执行动画
                key: ValueKey<int>(_count),
                style: Theme.of(context).textTheme.display1,
              ),
            ),
            RaisedButton(
              child: const Text('+1',),
              onPressed: () {
                int c = _count +1;
                List<String> newList = List();
                newList.addAll(strList);
                newList.add('$c');
                setState(() {
                  _count = c;
                  strList = newList;
                  print('$_count');
                });


                double d = 1.1;
                int ii = d.toInt();
                print(ii);
                int i = int.tryParse(d.toString());
                if(i != null){
                  print(d.toString() + 'iiiiiii' + i.toString());
                }else{
                  print(d.toString() + 'iiiiiii null');
                }
              },
            ),
          ],
        ),
      )
    );
  }
}

class MySlideTransition extends AnimatedWidget {
  MySlideTransition({
    Key key,
    @required Animation<Offset> position,
    this.transformHitTests = true,
    this.child,
  })
      : assert(position != null),
        super(key: key, listenable: position) ;

  Animation<Offset> get position => listenable;
  final bool transformHitTests;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    Offset offset=position.value;
    //动画反向执行时，调整x偏移，实现“从左边滑出隐藏”
    if (position.status == AnimationStatus.reverse) {
      offset = Offset(-offset.dx, offset.dy);
    }
    return FractionalTranslation(
      translation: offset,
      transformHitTests: transformHitTests,
      child: child,
    );
  }
}


class SlideTransitionX extends AnimatedWidget {
  SlideTransitionX({
    Key key,
    @required Animation<double> position,
    this.transformHitTests = true,
    this.direction = AxisDirection.down,
    this.child,
  })
      : assert(position != null),
        super(key: key, listenable: position) {
    // 偏移在内部处理
    switch (direction) {
      case AxisDirection.up:
        _tween = Tween(begin: Offset(0, 1), end: Offset(0, 0));
        break;
      case AxisDirection.right:
        _tween = Tween(begin: Offset(-1, 0), end: Offset(0, 0));
        break;
      case AxisDirection.down:
        _tween = Tween(begin: Offset(0, -1), end: Offset(0, 0));
        break;
      case AxisDirection.left:
        _tween = Tween(begin: Offset(1, 0), end: Offset(0, 0));
        break;
    }
  }


  Animation<double> get position => listenable;

  final bool transformHitTests;

  final Widget child;

  //退场（出）方向
  final AxisDirection direction;

  Tween<Offset> _tween;

  @override
  Widget build(BuildContext context) {
    Offset offset = _tween.evaluate(position);
    if (position.status == AnimationStatus.reverse) {
      switch (direction) {
        case AxisDirection.up:
          offset = Offset(offset.dx, -offset.dy);
          break;
        case AxisDirection.right:
          offset = Offset(-offset.dx, offset.dy);
          break;
        case AxisDirection.down:
          offset = Offset(offset.dx, -offset.dy);
          break;
        case AxisDirection.left:
          offset = Offset(-offset.dx, offset.dy);
          break;
      }
    }
    return FractionalTranslation(
      translation: offset,
      transformHitTests: transformHitTests,
      child: child,
    );
  }
}
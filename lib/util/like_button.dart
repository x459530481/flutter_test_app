///
///  create by zmtzawqlp on 2019/5/27
///

import 'package:flutter/material.dart';
import 'package:flutter_test_app/util/painter/bubbles_painter.dart';
import 'package:flutter_test_app/util/painter/circle_painter.dart';
import 'package:flutter_test_app/util/utils/like_button_model.dart';
import 'package:flutter_test_app/util/utils/like_button_typedef.dart';
import 'package:flutter_test_app/util/utils/like_button_util.dart';
//import 'package:like_button/src/painter/circle_painter.dart';
//import 'package:like_button/src/painter/bubbles_painter.dart';
//import 'package:like_button/src/utils/like_button_model.dart';
//import 'package:like_button/src/utils/like_button_typedef.dart';
//import 'package:like_button/src/utils/like_button_util.dart';


typedef void ChangerView(SetCount setCount);
typedef void SetCount(double dCount);

class LikeButton extends StatefulWidget {

  /// tap call back of like button
  final LikeButtonTapCallback onTap;

  ///whether it is liked
  final bool isLiked;

  final double dCount;

  /// mainAxisAlignment for like button
  final MainAxisAlignment mainAxisAlignment;

  // crossAxisAlignment for like button
  final CrossAxisAlignment crossAxisAlignment;

  ///builder to create like count widget
  final LikeCountWidgetBuilder countBuilder;

  ///animation duration to change like count
  final Duration likeCountAnimationDuration;

  ///animation type to change like count(none,part,all)
  final LikeCountAnimationType likeCountAnimationType;

  ///padding for like count widget
  final EdgeInsetsGeometry likeCountPadding;

  final CountPostion countPostion;

  /// padding of like button
  final EdgeInsetsGeometry padding;

  ///return count widget with decoration
  final CountDecoration countDecoration;

  final ChangerView changerView;

  const LikeButton(
      {Key key,
      this.countBuilder,
      this.dCount,
      this.isLiked: false,
      this.mainAxisAlignment: MainAxisAlignment.center,
      this.crossAxisAlignment: CrossAxisAlignment.center,
      this.likeCountAnimationType = LikeCountAnimationType.part,
      this.likeCountAnimationDuration = const Duration(milliseconds: 500),
      this.likeCountPadding = const EdgeInsets.only(left: 3.0),
      this.onTap,
      this.countPostion: CountPostion.right,
      this.padding,
      this.countDecoration,
      this.changerView,
      })
      :
        assert(mainAxisAlignment != null),
        assert(crossAxisAlignment != null),
        super(key: key);

  @override
  State<StatefulWidget> createState() => _LikeButtonState();
}

class _LikeButtonState extends State<LikeButton> with TickerProviderStateMixin {
  Animation<Offset> _slidePreValueAnimation;
  Animation<Offset> _slideCurrentValueAnimation;
  AnimationController _likeCountController;
  Animation<double> _opacityAnimation;

  bool _isLiked = false;
  double _dCount;
  double _preDCount;
  @override
  void initState() {
    super.initState();
    _isLiked = widget.isLiked;
    _dCount = widget.dCount;

    _preDCount = _dCount;

    _likeCountController = AnimationController(
        duration: widget.likeCountAnimationDuration, vsync: this);

    _initAnimations();

    _initChanger();
  }

  void _initChanger(){
    if(widget.changerView != null){
      widget.changerView(_handleCountChanged);
    }
  }

  @override
  void didUpdateWidget(LikeButton oldWidget) {
    _isLiked = widget.isLiked;

    _dCount = widget.dCount;
    _preDCount = _dCount;

    _likeCountController = AnimationController(
        duration: widget.likeCountAnimationDuration, vsync: this);

    _initAnimations();

    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _likeCountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget likeCountWidget = _getLikeCountWidget();
    if (widget.countDecoration != null) {
      likeCountWidget =
          widget.countDecoration(likeCountWidget) ?? likeCountWidget;
    }
    if (widget.likeCountPadding != null) {
      likeCountWidget = Padding(
        padding: widget.likeCountPadding,
        child: likeCountWidget,
      );
    }

    List<Widget> children = <Widget>[
      likeCountWidget
    ];

    if (widget.countPostion == CountPostion.left ||
        widget.countPostion == CountPostion.top) {
      children = children.reversed.toList();
    }
    Widget result = (widget.countPostion == CountPostion.left ||
            widget.countPostion == CountPostion.right)
        ? Row(
            mainAxisAlignment: widget.mainAxisAlignment,
            crossAxisAlignment: widget.crossAxisAlignment,
            children: children,
          )
        : Column(
            mainAxisAlignment: widget.mainAxisAlignment,
            crossAxisAlignment: widget.crossAxisAlignment,
            children: children,
          );

    if (widget.padding != null) {
      result = Padding(
        padding: widget.padding,
        child: result,
      );
    }

    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: _onTap,
      child: result,
    );
  }

  Widget _getLikeCountWidget() {
    if (_dCount == null) return Container();
    var likeCount = _dCount.toString();
    var preLikeCount = _preDCount.toString();

    int didIndex = 0;
    if (preLikeCount.length == likeCount.length) {
      for (; didIndex < likeCount.length; didIndex++) {
        if (likeCount[didIndex] != preLikeCount[didIndex]) {
          break;
        }
      }
    }
    bool allChange = preLikeCount.length != likeCount.length || didIndex == 0;

    Widget result;

    if (widget.likeCountAnimationType == LikeCountAnimationType.none ||
        _dCount == _preDCount) {
      result = _createLikeCountWidget(
          _dCount, (_isLiked ?? true), _dCount.toString());
    } else if (widget.likeCountAnimationType == LikeCountAnimationType.part &&
        !allChange) {
      var samePart = likeCount.substring(0, didIndex);
      var preText = preLikeCount.substring(didIndex, preLikeCount.length);
      var text = likeCount.substring(didIndex, likeCount.length);
      var preSameWidget =
          _createLikeCountWidget(_preDCount, !(_isLiked ?? true), samePart);
      var currentSameWidget =
          _createLikeCountWidget(_dCount, (_isLiked ?? true), samePart);
      var preWidget =
          _createLikeCountWidget(_preDCount, !(_isLiked ?? true), preText);
      var currentWidget =
          _createLikeCountWidget(_dCount, (_isLiked ?? true), text);

      result = AnimatedBuilder(
          animation: _likeCountController,
          builder: (b, w) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Stack(
                  fit: StackFit.passthrough,
                  overflow: Overflow.clip,
                  children: <Widget>[
                    Opacity(
                      child: currentSameWidget,
                      opacity: _opacityAnimation.value,
                    ),
                    Opacity(
                      child: preSameWidget,
                      opacity: 1.0 - _opacityAnimation.value,
                    ),
                  ],
                ),
                Stack(
                  fit: StackFit.passthrough,
                  overflow: Overflow.clip,
                  children: <Widget>[
                    FractionalTranslation(
                        translation: _preDCount > _dCount
                            ? _slideCurrentValueAnimation.value
                            : -_slideCurrentValueAnimation.value,
                        child: currentWidget),
                    FractionalTranslation(
                        translation: _preDCount > _dCount
                            ? _slidePreValueAnimation.value
                            : -_slidePreValueAnimation.value,
                        child: preWidget),
                  ],
                )
              ],
            );
          });
    } else {
      result = AnimatedBuilder(
        animation: _likeCountController,
        builder: (b, w) {
          return Stack(
            fit: StackFit.passthrough,
            overflow: Overflow.clip,
            children: <Widget>[
              FractionalTranslation(
                  translation: _preDCount > _dCount
                      ? _slideCurrentValueAnimation.value
                      : -_slideCurrentValueAnimation.value,
                  child: _createLikeCountWidget(
                      _dCount, (_isLiked ?? true), _dCount.toString())),
              FractionalTranslation(
                  translation: _preDCount > _dCount
                      ? _slidePreValueAnimation.value
                      : -_slidePreValueAnimation.value,
                  child: _createLikeCountWidget(_preDCount,
                      !(_isLiked ?? true), _preDCount.toString())),
            ],
          );
        },
      );
    }

    result = ClipRect(
      child: result,
      clipper: LikeCountClip(),
    );

    return result;
  }

  Widget _createLikeCountWidget(double dCount, bool isLiked, String text) {
    return widget.countBuilder?.call(dCount, isLiked, text) ??
        Text(text, style: TextStyle(color: Colors.grey));
  }

  void _onTap() {
    _handleCountChanged(widget.dCount);
  }

  void setDCount(double newCount){
    _handleCountChanged(newCount);
  }

  SetCount _handleCountChanged(double newCount) {
    if(_dCount != null){
      _preDCount = _dCount;
    }
    if(newCount > _dCount){
      _dCount = newCount;
      if (mounted) {
        setState(() {
          if (widget.likeCountAnimationType != LikeCountAnimationType.none) {
            _likeCountController.reset();
            _likeCountController.forward();
          }
        });
      }
    }else if(newCount < _dCount){
      _dCount = newCount;
      if (mounted) {
        setState(() {
          if (widget.likeCountAnimationType != LikeCountAnimationType.none) {
            _likeCountController.reset();
            _likeCountController.forward();
          }
        });
      }
    }
  }

  void _initAnimations() {
    _initLikeCountControllerAnimation();
  }

  void _initLikeCountControllerAnimation() {
    _slidePreValueAnimation = _likeCountController.drive(Tween<Offset>(
      begin: Offset.zero,
      end: Offset(0.0, 1.0),
    ));
    _slideCurrentValueAnimation = _likeCountController.drive(Tween<Offset>(
      begin: const Offset(0.0, -1.0),
      end: Offset.zero,
    ));

    _opacityAnimation = _likeCountController.drive(Tween<double>(
      begin: 0.0,
      end: 1.0,
    ));
  }
}

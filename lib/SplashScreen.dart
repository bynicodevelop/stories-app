import 'package:flutter/material.dart';
import 'package:animator/animator.dart';

class SplashScreen extends StatefulWidget {
  final Function onEndAnimation;
  final isAnimate;

  const SplashScreen({
    Key key,
    this.onEndAnimation,
    this.isAnimate = true,
  }) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Align(
          alignment: Alignment(0.0, -0.3),
          child: widget.isAnimate
              ? Animator(
                  endAnimationListener: (state) {
                    if (widget.onEndAnimation != null &&
                        state.controller.status == AnimationStatus.completed) {
                      widget.onEndAnimation();
                    }
                  },
                  tween: Tween<double>(begin: 0, end: 200),
                  cycles: 1,
                  duration: Duration(milliseconds: 800),
                  builder: (context, animatorState, child) => Opacity(
                    opacity: animatorState.value / 200,
                    child: Image(
                      image: AssetImage('assets/images/logo-splashscreen.png'),
                    ),
                  ),
                )
              : Image(
                  image: AssetImage('assets/images/logo-splashscreen.png'),
                ),
        ),
      ),
    );
  }
}

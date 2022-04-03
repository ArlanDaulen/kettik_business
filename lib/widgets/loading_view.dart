import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class LoadingView extends StatefulWidget {
  const LoadingView({Key? key}) : super(key: key);

  @override
  State<LoadingView> createState() => _LoadingViewState();
}

class _LoadingViewState extends State<LoadingView> {
  RiveAnimationController? _controller;

  @override
  void initState() {
    super.initState();
    _controller = OneShotAnimation(
      'loading',
      autoplay: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 120,
        height: 120,
        child: RiveAnimation.asset(
          'assets/riv/loading_view.riv',
          controllers: [_controller!],
        ),
      ),
    );
  }
}

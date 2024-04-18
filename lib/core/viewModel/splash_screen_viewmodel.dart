import 'package:aldlal/view/home/control_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';

class SplashScreenViewModel extends GetxController implements TickerProvider {
  late final AnimationController _controller;
  late final Animation<Offset> _offsetAnimation;

  @override
  void onInit() {
    super.onInit();
    move();
    animate(); // Initialize the animations when the controller is initialized
  }

  @override
  void onClose() {
    _controller
        .dispose(); // Dispose of the controller when the controller is no longer needed
    super.onClose();
  }

  AnimationController get controller => _controller;
  Animation<Offset> get offsetAnimation => _offsetAnimation;

  void move() async {
    await Future.delayed(const Duration(seconds: 5));
    Get.off(() => ControlView(),
        transition: Transition.downToUp, duration: Duration(milliseconds: 600));
  }

  void animate() {
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _offsetAnimation = Tween<Offset>(
      begin: const Offset(0.0, 1.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.decelerate,
    ));

    _controller.forward(); // Start the animation
  }

  @override
  Ticker createTicker(onTick) {
    return Ticker(onTick);
  }
}

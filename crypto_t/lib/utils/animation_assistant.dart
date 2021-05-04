import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:loader_overlay/loader_overlay.dart';

class AnimationAssistant {

  bool _isAnimating = false;

  final BuildContext context;

  AnimationAssistant(this.context);

  StreamController<bool> _streamController = new StreamController<bool>();
  Stream<bool>? get stream => _streamController.stream;

  bool getIsAnimating() => _isAnimating;

  void startAnimation() {
    context.loaderOverlay.show();
    _isAnimating = true;
    _streamController.add(true);
  }

  void stopAnimation() {
    context.loaderOverlay.hide();
    _isAnimating = false;
    _streamController.add(false);
  }
}


import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

class LoadingCubit extends Cubit<double> {
  Timer? _timer;
  double _opacity = 1.0;
  bool _fadeOut = true;

  LoadingCubit() : super(1.0) {
    _startAnimation();
  }

  void _startAnimation() {
    _timer = Timer.periodic(const Duration(milliseconds: 50), (timer) {
      if (_fadeOut) {
        _opacity -= 0.05;
        if (_opacity <= 0.3) _fadeOut = false;
      } else {
        _opacity += 0.05;
        if (_opacity >= 1.0) _fadeOut = true;
      }
      emit(_opacity);
    });
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}

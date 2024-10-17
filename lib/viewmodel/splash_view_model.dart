import 'package:flutter/material.dart';

class SplashViewModel extends ChangeNotifier {
  AnimationController? animationController;
  bool _initLoading = true;

  bool get initLoading => _initLoading;

  void start(BuildContext context, TickerProvider ticker) {
    animationController = AnimationController(
      vsync: ticker,
      duration: const Duration(milliseconds: 500),
    );
    
    if (context.findRenderObject()?.attached == true) {
      notifyListeners();
    }
  }

  void updateLoadingState(){
    _initLoading = false;
    notifyListeners();
  }

  @override
  void dispose() {
    super.dispose();
    animationController?.dispose();
  }
}
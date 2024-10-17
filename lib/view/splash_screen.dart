import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app_mvvm/constants/constants.dart';
import 'package:to_do_app_mvvm/view/task_screen.dart';
import 'package:to_do_app_mvvm/viewmodel/splash_view_model.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    Future.delayed(
      const Duration(milliseconds: 5000),
      () {
        Navigator.of(context).pushReplacement(
          PageRouteBuilder(
            pageBuilder: (context, animation1, animation2) => const TaskScreen(),
            transitionDuration: const Duration(milliseconds: 500),
            transitionsBuilder: (context, animation1, animation2, child) {
              return SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(1.0, 0.0),
                  end: Offset.zero,
                ).animate(animation1),
                child: child,
              );
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return ChangeNotifierProvider(
      create: (context) => SplashViewModel(),
      builder: (context, _) {
        final state = Provider.of<SplashViewModel>(context, listen: false);
        state.start(context, this);
        return Scaffold(
          body: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  primary, 
                  secondary, 
                ],
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: AnimatedBuilder(
                    animation: state.animationController!,
                    builder: (context, _) {
                      return AnimatedRotation(
                        duration: const Duration(milliseconds: 500),
                        turns: state.animationController!.value,
                        child: Image.asset(
                          'assets/images/logo.png',
                          width: screenWidth * 0.7, 
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 30), 
                Text(
                  "My TODO",
                  style: TextStyle(
                    fontSize: screenWidth * 0.1, 
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: 1.5,
                    shadows: const [
                      Shadow(
                        offset: Offset(2, 2),
                        blurRadius: 5,
                        color: Colors.black26, 
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20), 
                Text(
                  "Organize your day effortlessly", 
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: screenWidth * 0.05,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

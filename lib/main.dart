import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app_mvvm/constants/constants.dart';
import 'package:to_do_app_mvvm/service/db_helper.dart';
import 'package:to_do_app_mvvm/view/splash_screen.dart';
import 'package:to_do_app_mvvm/viewmodel/splash_view_model.dart';
import 'package:to_do_app_mvvm/viewmodel/task_view_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<SplashViewModel>(create: (context) => SplashViewModel()),
        ChangeNotifierProvider<TaskViewmodel>(create: (_) => TaskViewmodel(DbHelper())),
      ],
      child: MaterialApp(
        title: 'Flutter To Do App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          textTheme: GoogleFonts.poppinsTextTheme(),
          colorScheme: ColorScheme.fromSeed(seedColor: primary),
          useMaterial3: true,
        ),
       home: const SplashScreen(),
      ),
    );
  }
}


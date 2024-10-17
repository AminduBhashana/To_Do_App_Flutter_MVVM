import 'package:flutter/material.dart';
import 'package:to_do_app_mvvm/constants/constants.dart';
import 'package:to_do_app_mvvm/widgets/custom_dialog.dart';

class CustomFAB extends StatelessWidget {
  const CustomFAB({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      foregroundColor: Colors.white,
      backgroundColor: primary,
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) {
            return const CustomDialog();
          },
        );
      },
      child: const Icon(
        Icons.add,
        size: 40,
      ),
    );
  }
}
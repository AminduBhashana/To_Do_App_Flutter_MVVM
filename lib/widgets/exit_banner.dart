import 'package:flutter/material.dart';
import 'package:to_do_app_mvvm/constants/constants.dart';

Future<bool> onExitPop(BuildContext context) async {
    final widthOfScreen = MediaQuery.of(context).size.width;
    return await showDialog(
    context: context,
    builder: (context) => Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      backgroundColor: Colors.white,
      elevation: 16.0,
      child: Container(
        padding: const EdgeInsets.all(20.0),
        width: (widthOfScreen > 600) ? widthOfScreen*0.6 : widthOfScreen*0.8,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Icon(
              Icons.info_outline_rounded,
              color: Colors.red,
              size: 48.0,
            ),
            const SizedBox(height: 15.0),
            const Text(
              'Exit App',
              style: TextStyle(
                color: textColor2,
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10.0),
            const Text(
              'Are you sure you want to exit?',
              style: TextStyle(
                color: textColor2,
                fontSize: 16.0,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey,
                    padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 24.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  child: const Text(
                    'No',
                    style: TextStyle(
                      color: textColor1,
                      fontSize: 18.0,
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop(true);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primary,
                    padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 24.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  child: const Text(
                    'Yes',
                    style: TextStyle(
                      color: textColor1,
                      fontSize: 18.0,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  ) ?? false;
  }
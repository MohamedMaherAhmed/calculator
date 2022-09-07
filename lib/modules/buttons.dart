import 'package:flutter/material.dart';

class MyButtons extends StatelessWidget {
  final Color? buttonColor;
  final Color? textColor;
  final String buttonText;
  final buttonTapped;

  const MyButtons(
      {Key? key,
      required this.buttonColor,
      required this.textColor,
      required this.buttonText,
      required this.buttonTapped})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: buttonTapped,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Container(
            color: buttonColor,
            child: Center(
              child: Text(
                buttonText,
                style: TextStyle(
                  color: textColor,
                  fontSize: 20,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

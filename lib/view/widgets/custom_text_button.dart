import '../../utils/constance.dart';
import 'package:admin_grad_pro/view/widgets/custom_text.dart';
import 'package:flutter/material.dart';

class CustomTextButton extends StatelessWidget {
  final Function onPressed;
  final String text;
  final Color color;
  final Color textColor;

  CustomTextButton({
    @required this.text,
    @required this.onPressed,
    this.color = primaryColor,
    this.textColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        backgroundColor: color,
        padding: EdgeInsets.all(14),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      onPressed: () => onPressed(),
      child: CustomText(
        text: text,
        alignment: Alignment.center,
        color: textColor,
      ),
    );
  }
}

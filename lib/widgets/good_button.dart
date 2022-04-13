import '/utils/utils.dart';
import 'package:flutter/material.dart';

class GoodButton extends StatelessWidget {
  const GoodButton({
    Key? key,
    required this.text,
    required this.onTap,
    this.textStyle,
    this.bgColor,
    this.textColor,
    this.borderColor,
    this.customWidth,
    this.customHeight,
  }) : super(key: key);
  final String text;
  final Function() onTap;
  final TextStyle? textStyle;
  final Color? textColor;
  final Color? bgColor;
  final double? customWidth;
  final double? customHeight;
  final Color? borderColor;
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: onTap,
      child: Align(
        alignment: Alignment.center,
        child: Container(
          width: customWidth ?? width * 0.8,
          height: customHeight ?? height * 0.065,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: bgColor ?? Colors.white,
            border: Border.all(
              color: borderColor ?? Colors.green,
            ),
          ),
          alignment: Alignment.center,
          child: Text(
            text,
            style: textStyle ?? defaultTextStyle.copyWith(color: textColor),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}

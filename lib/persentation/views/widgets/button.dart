import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final bool? enable;
  final Color? color;
  final Function() onPressed;
  final TextStyle? labelStyle;
  final String labelText;

  const Button(
      {Key? key,
      this.enable,
      this.color,
      required this.onPressed,
      this.labelStyle,
      required this.labelText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      height: 50,
      onPressed: !enable! ? () {} : () => onPressed(),
      color: !enable! ? Colors.grey : color ?? Colors.blue,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.5)),
      child: Text(
        labelText,
        style: const TextStyle(
                fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)
            .merge(labelStyle),
      ),
    );
  }
}

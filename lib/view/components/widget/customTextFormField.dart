import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomFormField extends StatelessWidget {
  CustomFormField(
      {super.key,
      this.textController,
      required this.hintText,
      this.helperText = "",
      required this.typeText,
      this.validator,
      this.onChanged,
      this.icon = const Icon(CupertinoIcons.question_circle),
      this.obscureText = false,
      this.viewText,
      this.label,
      this.textStyle = const TextStyle(color: Colors.white),
      this.textInputAction = TextInputAction.none});

  final TextEditingController? textController;
  final String hintText;
  String helperText = "";
  TextInputType typeText;
  String? Function(String?)? validator;
  String? Function(String?)? onChanged;
  Icon? icon;
  bool obscureText;
  Function? viewText;
  Widget? label;
  TextStyle textStyle;
  TextInputAction textInputAction;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textInputAction: textInputAction,
      keyboardType: typeText,
      controller: textController,
      validator: validator,
      onChanged: onChanged,
      obscureText: obscureText,
      style: textStyle,
      decoration: InputDecoration(
          label: label,
          labelStyle: textStyle,
          hintText: hintText,
          errorBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.redAccent, width: 0.0),
          ),
          helperText: helperText,
          helperStyle: const TextStyle(color: Colors.redAccent),
          prefixIcon: icon,
          suffixIcon: viewText != null
              ? IconButton(
                  tooltip: "Ver password",
                  hoverColor: Colors.blueGrey,
                  onPressed: () {
                    viewText!();
                  },
                  icon: const Icon(Icons.remove_red_eye_outlined))
              : null),
    );
  }
}

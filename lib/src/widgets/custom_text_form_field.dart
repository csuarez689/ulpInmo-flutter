import 'package:flutter/material.dart';
import 'package:ulp_inmo/src/helpers/validators.dart';

class CustomTextFormField extends StatelessWidget {
  CustomTextFormField({
    Key? key,
    this.inputController,
    this.validator,
    this.obscure = false,
    this.hintText = '',
    this.prefixIcon,
    this.suffixIcon,
    this.keyboardType,
    this.onSaved,
    this.initialValue,
    required this.title,
  }) : super(key: key);

  TextEditingController? inputController;
  Function? validator;
  Function(String?)? onSaved;
  bool obscure;
  String hintText;
  Widget? suffixIcon;
  Widget? prefixIcon;
  TextInputType? keyboardType;
  String title;
  String? initialValue;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
          const SizedBox(height: 10),
          TextFormField(
            initialValue: initialValue,
            onSaved: onSaved,
            keyboardType: keyboardType,
            controller: inputController,
            validator: (value) => validator != null ? validator!(value) : null,
            obscureText: obscure,
            decoration: InputDecoration(
              hintText: hintText,
              border: InputBorder.none,
              fillColor: const Color(0xfff3f3f4),
              filled: true,
              suffixIcon: suffixIcon,
              prefix: prefixIcon,
            ),
          )
        ],
      ),
    );
  }
}

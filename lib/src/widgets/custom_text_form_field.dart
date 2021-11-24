import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
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

  final TextEditingController? inputController;
  final Function? validator;
  final Function(String?)? onSaved;
  final bool obscure;
  final String hintText;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final TextInputType? keyboardType;
  final String title;
  final String? initialValue;

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

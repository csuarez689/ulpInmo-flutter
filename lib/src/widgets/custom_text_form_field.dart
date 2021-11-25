import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
    this.inputFormatters,
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
  final List<TextInputFormatter>? inputFormatters;
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
            inputFormatters: inputFormatters,
            initialValue: initialValue,
            onSaved: onSaved,
            keyboardType: keyboardType,
            controller: inputController,
            validator: (value) => validator != null ? validator!(value) : null,
            obscureText: obscure,
            decoration: InputDecoration(
              isDense: true,
              hintText: hintText,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(style: BorderStyle.none, width: 0),
              ),
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

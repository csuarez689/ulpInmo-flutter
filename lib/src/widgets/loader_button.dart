import 'package:flutter/material.dart';

class LoaderButton extends StatelessWidget {
  final Widget child;
  final bool loading;
  final VoidCallback onPressed;

  const LoaderButton({Key? key, required this.child, required this.loading, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          primary: const Color(0xff14279B),
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
          textStyle: const TextStyle(fontSize: 20, color: Colors.white),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          minimumSize: const Size.fromHeight(50)),
      child: loading
          ? const SizedBox(
              height: 24,
              width: 24,
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            )
          : child,
      onPressed: loading ? () {} : onPressed,
    );
  }
}

import 'package:flutter/material.dart';

void showSnackbar(BuildContext context, String mensaje) {
  ScaffoldMessenger.of(context).clearSnackBars();
  final snack = SnackBar(
    content: Text(
      mensaje,
      textAlign: TextAlign.center,
      style: const TextStyle(color: Colors.white, fontSize: 14.0, fontWeight: FontWeight.w600),
    ),
    backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(.8),
    duration: const Duration(seconds: 5),
    dismissDirection: DismissDirection.horizontal,
    elevation: 2.0,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(topLeft: Radius.circular(10.0), topRight: Radius.circular(10.0)),
    ),
  );
  ScaffoldMessenger.of(context).showSnackBar(snack);
}

void showSnackbarError(BuildContext context, String mensaje) {
  ScaffoldMessenger.of(context).clearSnackBars();
  final snack = SnackBar(
    content: Text(
      mensaje,
      textAlign: TextAlign.center,
      style: const TextStyle(color: Colors.white, fontSize: 14.0, fontWeight: FontWeight.w600),
    ),
    backgroundColor: Theme.of(context).colorScheme.secondary.withOpacity(.8),
    duration: const Duration(seconds: 5),
    dismissDirection: DismissDirection.horizontal,
    elevation: 2.0,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(topLeft: Radius.circular(10.0), topRight: Radius.circular(10.0)),
    ),
  );
  ScaffoldMessenger.of(context).showSnackBar(snack);
}

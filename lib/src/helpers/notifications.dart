import 'package:flutter/material.dart';

void showSnackbar(BuildContext context, String mensaje) {
  ScaffoldMessenger.of(context).clearSnackBars();
  final snack = SnackBar(
    content: Text(
      mensaje,
      textAlign: TextAlign.center,
      style: const TextStyle(color: Colors.white, fontSize: 14.0, fontWeight: FontWeight.w600),
    ),
    backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(.9),
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
    backgroundColor: Theme.of(context).colorScheme.secondary.withOpacity(.9),
    duration: const Duration(seconds: 5),
    dismissDirection: DismissDirection.horizontal,
    elevation: 2.0,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(topLeft: Radius.circular(10.0), topRight: Radius.circular(10.0)),
    ),
  );
  ScaffoldMessenger.of(context).showSnackBar(snack);
}

void deleteAlert(BuildContext context, {required String message, required VoidCallback onOk}) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          contentPadding: const EdgeInsets.only(top: 30, left: 30, right: 30, bottom: 10),
          content: Text(
            message,
            textAlign: TextAlign.center,
            style: TextStyle(color: Theme.of(context).colorScheme.error, fontSize: 15.0, fontWeight: FontWeight.w600),
          ),
          actions: [
            TextButton(
                style: TextButton.styleFrom(primary: Colors.grey),
                onPressed: () => Navigator.pop(context),
                child: const Text(
                  'Cancelar',
                )),
            TextButton(
                style: TextButton.styleFrom(primary: Theme.of(context).colorScheme.error),
                onPressed: onOk,
                child: const Text(
                  'Aceptar',
                  style: TextStyle(decoration: TextDecoration.underline),
                )),
          ],
        );
      });
}

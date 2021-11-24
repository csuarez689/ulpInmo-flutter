import 'package:flutter/material.dart';

class CustomErrorWidget extends StatelessWidget {
  final String title;
  final IconData icon;
  const CustomErrorWidget({Key? key, this.title = 'Ocurrio un error inesperado!', this.icon = Icons.error}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, size: 50, color: Theme.of(context).errorColor.withOpacity(.8)),
        Center(
          child: Text(title, textAlign: TextAlign.center, style: TextStyle(fontSize: 18, color: Theme.of(context).errorColor.withOpacity(.8))),
        ),
      ],
    );
  }
}

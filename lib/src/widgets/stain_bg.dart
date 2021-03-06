import 'package:flutter/material.dart';

class StainBg extends StatelessWidget {
  const StainBg({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return ClipPath(
      clipper: _ClipPainter(),
      child: Container(
        height: height * .5,
        width: width,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xff14279B),
              Color(0xffE6E6E6),
            ],
          ),
        ),
      ),
    );
  }
}

class _ClipPainter extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var height = size.height;
    var width = size.width;
    var path = Path();

    path.lineTo(0, height * .11);
    final fstControlPoint = Offset(width * .01, height * .19);
    final fstEndPoint = Offset(width * .2, height * .12);
    path.quadraticBezierTo(fstControlPoint.dx, fstControlPoint.dy, fstEndPoint.dx, fstControlPoint.dy);

    final sndControlPoint = Offset(width * .4, height * .18);
    final sndEndPoint = Offset(width * .5, height * .35);
    path.quadraticBezierTo(sndControlPoint.dx, sndControlPoint.dy, sndEndPoint.dx, sndEndPoint.dy);

    final trdControlPoint = Offset(width * .6, height * .6);
    final trdEndPoint = Offset(width * .85, height * .61);
    path.quadraticBezierTo(trdControlPoint.dx, trdControlPoint.dy, trdEndPoint.dx, trdEndPoint.dy);

    final fthControlPoint = Offset(width * .95, height * .615);
    final fthEndPoint = Offset(width, height * .64);
    path.quadraticBezierTo(fthControlPoint.dx, fthControlPoint.dy, fthEndPoint.dx, fthEndPoint.dy);

    path.lineTo(width, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}

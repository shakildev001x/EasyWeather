import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class InvertedLargeCurveClipper extends CustomClipper<Path> {
  final double radius;

  InvertedLargeCurveClipper({this.radius = 45}); // Border radius

  @override
  Path getClip(Size size) {
    Path path = Path();

    // Top-left rounded corner
    path.moveTo(0, radius);
    path.quadraticBezierTo(0, 0, radius, 0);

    // Top inward curve
    path.quadraticBezierTo(
      size.width / 2, // control point X
      30.h, // control point Y
      size.width - radius, // end X
      0, // end Y
    );

    // Top-right rounded corner
    path.quadraticBezierTo(size.width, 0, size.width, radius);

    // ডান পাশে নিচে
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

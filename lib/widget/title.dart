import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'colors.dart';

class CustomText extends StatelessWidget {
  final String text;
  final double size;
  final Color color;
  final FontStyle fontStyle;
  final FontWeight fontWeight;

  CustomText(
      {@required this.text,
      this.size,
      this.color,
      this.fontWeight,
      this.fontStyle});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.montserrat(
        fontSize: size ?? 16,
        fontWeight: fontWeight ?? FontWeight.normal,
        fontStyle: fontStyle ?? FontStyle.normal,
        color: color ?? black,
      ),
    );
  }
}

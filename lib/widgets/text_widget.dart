import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextWidget extends StatelessWidget {
  final String text;
  final int? maxLines;
  final double fontsize;
  final FontStyle? fontStyle;
  final Color? textcolor;
  final FontWeight? fontweight;
  final TextOverflow? overflow;
  const TextWidget(
      {Key? key,
      required this.text,
      required this.fontsize,
      this.maxLines,
      this.fontStyle,
      this.textcolor,
      this.fontweight,
      this.overflow})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: maxLines,
      style: GoogleFonts.raleway(
        textStyle: TextStyle(
          color: textcolor ?? Colors.white,
          fontSize: fontsize,
          fontStyle: fontStyle,
          overflow: overflow,
          fontWeight: fontweight ?? FontWeight.bold,
        ),
      ),
      overflow: TextOverflow.ellipsis,
    );
  }
}

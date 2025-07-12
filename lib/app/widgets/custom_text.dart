import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomText extends StatelessWidget {
  final String text;
  final double? fontSize;
  final int? maxline;
  final FontStyle? fontStyle;
  final TextAlign? textAlign;
  final FontWeight? fontWeight;
  final Color color;
  final TextOverflow? overflow;
  final bool? softWrap;

  const CustomText({
    super.key,
      required this.color,
      required this.text,
      this.fontSize,
      this.maxline,
      this.overflow,
      this.textAlign,
      this.fontWeight,
      this.fontStyle,
      this.softWrap
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      overflow: TextOverflow.ellipsis,
      maxLines: maxline,
      softWrap: softWrap,
      style: GoogleFonts.inter(
          fontSize: fontSize,
          fontStyle: fontStyle,
          color: color,
          fontWeight: fontWeight),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BigText extends StatelessWidget {
  final String text;
  final double? size;
  final TextOverflow? overflow;
  final FontWeight? fontWeight;
  final int? maxLines;
  final Color? color;
  final FontStyle? fontStyle;
  const BigText({
    super.key,
    this.size,
    this.overflow,
    this.fontWeight,
    this.maxLines,
    this.color,
    this.fontStyle,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      overflow: overflow,
      maxLines: maxLines,
      style: TextStyle(
        fontSize: size,
        fontWeight: fontWeight,
        color: color ?? Colors.white,
        fontStyle: fontStyle,
      ),
    );
  }
}

TextStyle get titleStyle {
  return GoogleFonts.lato(
      textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400));
}

TextStyle get subHeadingStyle {
  return GoogleFonts.lato(
      textStyle: const TextStyle(
    fontSize: 45 / 2,
    fontWeight: FontWeight.w400,
  ));
}

TextStyle get headingStyle {
  return GoogleFonts.lato(
      textStyle:
          const TextStyle(fontSize: 50 / 2, fontWeight: FontWeight.bold));
}

TextStyle get favouriteMusicStyle {
  return GoogleFonts.abrilFatface(
      textStyle: const TextStyle(
          fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white));
}

TextStyle get playlistStyle {
  return GoogleFonts.allura(
      textStyle: const TextStyle(
          fontSize: 50, fontWeight: FontWeight.bold, color: Colors.white));
}

TextStyle get homeStyle {
  return GoogleFonts.allura(
      textStyle: const TextStyle(
          fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white));
}

TextStyle get welcomeStyle {
  return GoogleFonts.allura(
      textStyle: const TextStyle(
          fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white));
}

TextStyle get sectionHeaderStyle {
  return GoogleFonts.lato(
      textStyle: const TextStyle(
          fontSize: 50 / 2.3,
          fontWeight: FontWeight.bold,
          color: Colors.white));
}

TextStyle get sectionHeaderSub {
  return GoogleFonts.lato(
      textStyle: const TextStyle(
          fontSize: 30 / 2, fontWeight: FontWeight.bold, color: Colors.white));
}

TextStyle get subTitleStyle {
  return GoogleFonts.lato(
      textStyle: const TextStyle(
          color: Colors.white, fontSize: 20, fontWeight: FontWeight.w400));
}

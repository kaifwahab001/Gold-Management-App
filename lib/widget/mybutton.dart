import 'package:flutter/material.dart';
import 'package:gold_app/constants/textstyle.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants/colors.dart';

class Mybutton extends StatelessWidget {
  const Mybutton({
    super.key,
    required this.btntext,
    required this.ontap,
    this.btnclr = Appcolor.mainColor,
    this.size = const Size(200, 48),
    this.textclr =  Colors.white,
  });
  final String btntext;
  final VoidCallback ontap;
  final Color btnclr;
  final Color textclr;
  final Size size;
  @override
  Widget build(BuildContext context) {
    final ressize = MediaQuery.of(context).size;
    return FilledButton(
      onPressed: ontap,
      style: FilledButton.styleFrom(
        backgroundColor: btnclr,
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        foregroundColor: textclr,
        // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
        fixedSize: size,
      ),
      child: Text(btntext, style: GoogleFonts.roboto(
        fontSize: ressize.height*0.016,
        fontWeight: FontWeight.normal,
      )),
    );
  }
}

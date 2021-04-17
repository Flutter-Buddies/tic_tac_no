import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ButtonBanner extends StatelessWidget {
  const ButtonBanner(this.label);
  final String label;
  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: -7,
      left: -2,
      child: Transform.rotate(
        angle: -0.2,
        child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Colors.white,
              boxShadow: const [
                BoxShadow(
                  color: Colors.grey,
                  blurRadius: 3.0,
                  spreadRadius: 2.0,
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Text(
                label,
                style: GoogleFonts.cairo().copyWith(color: Colors.grey[800]),
              ),
            )),
      ),
    );
  }
}

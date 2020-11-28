import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TitleWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'TIC',
          style: GoogleFonts.firaCode(
              textStyle: Theme.of(context).textTheme.headline1),
        ),
        Text(
          'TAC',
          style: GoogleFonts.firaCode(
              textStyle: Theme.of(context).textTheme.headline1),
        ),
        Text(
          'NO',
          style: GoogleFonts.firaCode(
              textStyle: Theme.of(context).textTheme.headline1),
        ),
      ],
    );
  }
}

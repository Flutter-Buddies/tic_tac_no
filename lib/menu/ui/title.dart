import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tic_tac_no/utils/utils.dart';

class TitleWidget extends StatelessWidget {
  const TitleWidget();
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        textTheme: const TextTheme(
          headline1: TextStyle(
            fontSize: 100,
            color: Colors.white,
            letterSpacing: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      child: Builder(
        builder: (context) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'TIC',
                style: Utils.isCurrentLocaleRTL(context)
                    ? GoogleFonts.cairo(
                        textStyle: Theme.of(context).textTheme.headline1,
                      )
                    : GoogleFonts.firaCode(
                        textStyle: Theme.of(context).textTheme.headline1,
                      ),
              ),
              Text(
                'TAC',
                style: Utils.isCurrentLocaleRTL(context)
                    ? GoogleFonts.cairo(
                        textStyle: Theme.of(context).textTheme.headline1,
                      )
                    : GoogleFonts.firaCode(
                        textStyle: Theme.of(context).textTheme.headline1,
                      ),
              ),
              Text(
                'NO',
                style: Utils.isCurrentLocaleRTL(context)
                    ? GoogleFonts.cairo(
                        textStyle: Theme.of(context).textTheme.headline1,
                      )
                    : GoogleFonts.firaCode(
                        textStyle: Theme.of(context).textTheme.headline1,
                      ),
              ),
            ],
          );
        },
      ),
    );
  }
}

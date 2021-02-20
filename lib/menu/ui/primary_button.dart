import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton(
      {this.buttonIcon,
      this.buttonText,
      this.buttonPress,
      this.buttonGradient});

  final String buttonText;
  final IconData buttonIcon;
  final Function buttonPress;
  final LinearGradient buttonGradient;

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      elevation: 10,
      onPressed: buttonPress,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50),
      ),
      padding: EdgeInsets.all(0),
      child: Ink(
        decoration: BoxDecoration(
          gradient: buttonGradient,
          borderRadius: BorderRadius.circular(50),
        ),
        child: Container(
          constraints: BoxConstraints(minWidth: 88, minHeight: 36),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                getButtonIcon(),
                SizedBox(
                  // If there is no icon we don't want any spacing so the text is properly centered
                  width: buttonIcon == null ? 0 : 5,
                ),
                Text(
                  buttonText,
                  style: GoogleFonts.cairo(
                    textStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Icon getButtonIcon() {
    if (buttonIcon == null) {
      return Icon(
        Icons.add,
        size: 0,
        color: Colors.transparent,
      );
    } else {
      return Icon(
        buttonIcon,
        color: Colors.white,
      );
    }
  }
}

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    Key? key,
    this.buttonIcon,
    required this.buttonText,
    this.buttonPress,
    this.buttonGradient,
  }) : super(key: key);

  final String buttonText;
  final IconData? buttonIcon;
  final VoidCallback? buttonPress;
  final LinearGradient? buttonGradient;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: buttonPress,
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.all(0),
        elevation: 10,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
      ),
      child: Ink(
        decoration: BoxDecoration(
          gradient: buttonGradient,
          borderRadius: BorderRadius.circular(50),
        ),
        child: Container(
          constraints: const BoxConstraints(minWidth: 88, minHeight: 36),
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
                Expanded(
                  child: Text(
                    buttonText,
                    overflow: TextOverflow.fade,
                    maxLines: 1,
                    softWrap: false,
                    style: GoogleFonts.cairo(
                      textStyle: const TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
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
      return const Icon(
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

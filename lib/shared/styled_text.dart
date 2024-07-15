import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:xprapp/theme.dart';

class StyledText extends StatelessWidget {
  const StyledText(this.text, {super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(text, style: GoogleFonts.roboto(
      textStyle: TextStyle(
        fontSize: 12,
        color: lightColorScheme.onSurfaceVariant
      ),
    ));
  }
}

class StyledHeadline extends StatelessWidget {
  const StyledHeadline(this.text, {super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(text.toUpperCase(), style: GoogleFonts.roboto(
      textStyle: Theme.of(context).textTheme.headlineMedium,
    ));
  }
}

class StyledTitle extends StatelessWidget {
  const StyledTitle(this.text, {super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(text.toUpperCase(), style: GoogleFonts.roboto(
      textStyle: Theme.of(context).textTheme.titleMedium,
    ));
  }
}

class StyledDisplay extends StatelessWidget {
  const StyledDisplay(this.text, {super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(text.toUpperCase(), style: GoogleFonts.roboto(
      textStyle: Theme.of(context).textTheme.displayMedium,
    ));
  }
}

class StyledLabel extends StatelessWidget {
  const StyledLabel(this.text, {super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(text.toUpperCase(), style: GoogleFonts.roboto(
      textStyle: Theme.of(context).textTheme.labelMedium,
    ));
  }
}
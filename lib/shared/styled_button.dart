import 'package:flutter/material.dart';
import 'package:xprapp/theme.dart';

class StyledButton extends StatelessWidget {
  const StyledButton({
    super.key,
    required this.onPressed,
    required this.child,
  });

  final Function() onPressed;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: onPressed,
        style: ButtonStyle(
            backgroundColor: const WidgetStatePropertyAll(Colors.transparent),
            foregroundColor:
                WidgetStatePropertyAll(lightColorScheme.onSurface)),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(24)),
          ),
          child: child,
        ));
  }
}

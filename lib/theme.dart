import 'package:flutter/material.dart';

const lightColorScheme = ColorScheme(
  brightness: Brightness.light,
  primary: Color(0xFF385CA9),
  onPrimary: Color(0xFFFFFFFF),
  primaryContainer: Color(0xFFD9E2FF),
  onPrimaryContainer: Color(0xFF001945),
  secondary: Color(0xFF3C5BA9),
  onSecondary: Color(0xFFFFFFFF),
  secondaryContainer: Color(0xFFDAE1FF),
  onSecondaryContainer: Color(0xFF001849),
  tertiary: Color(0xFF86468B),
  onTertiary: Color(0xFFFFFFFF),
  tertiaryContainer: Color(0xFFFFD6FC),
  onTertiaryContainer: Color(0xFF36003E),
  error: Color(0xFFBA1A1A),
  errorContainer: Color(0xFFFFDAD6),
  onError: Color(0xFFFFFFFF),
  onErrorContainer: Color(0xFF410002),
  surface: Color(0xFFFEFBFF),
  onSurface: Color(0xFF001849),
  surfaceContainerHighest: Color(0xFFE1E2EC),
  onSurfaceVariant: Color(0xFF44464F),
  outline: Color(0xFF757780),
  onInverseSurface: Color(0xFFEEF0FF),
  inverseSurface: Color(0xFF002B75),
  inversePrimary: Color(0xFFB0C6FF),
  shadow: Color(0xFF000000),
  surfaceTint: Color(0xFF385CA9),
  outlineVariant: Color(0xFFC5C6D0),
  scrim: Color(0xFF000000),
);

const darkColorScheme = ColorScheme(
  brightness: Brightness.dark,
  primary: Color(0xFFB0C6FF),
  onPrimary: Color(0xFF002C70),
  primaryContainer: Color(0xFF1A438F),
  onPrimaryContainer: Color(0xFFD9E2FF),
  secondary: Color(0xFFB3C5FF),
  onSecondary: Color(0xFF002B75),
  secondaryContainer: Color(0xFF20428F),
  onSecondaryContainer: Color(0xFFDAE1FF),
  tertiary: Color(0xFFF8ADFB),
  onTertiary: Color(0xFF511459),
  tertiaryContainer: Color(0xFF6B2D72),
  onTertiaryContainer: Color(0xFFFFD6FC),
  error: Color(0xFFFFB4AB),
  errorContainer: Color(0xFF93000A),
  onError: Color(0xFF690005),
  onErrorContainer: Color(0xFFFFDAD6),
  surface: Color(0xFF001849),
  onSurface: Color(0xFFDBE1FF),
  surfaceContainerHighest: Color(0xFF44464F),
  onSurfaceVariant: Color(0xFFC5C6D0),
  outline: Color(0xFF8F9099),
  onInverseSurface: Color(0xFF001849),
  inverseSurface: Color(0xFFDBE1FF),
  inversePrimary: Color(0xFF385CA9),
  shadow: Color(0xFF000000),
  surfaceTint: Color(0xFFB0C6FF),
  outlineVariant: Color(0xFF44464F),
  scrim: Color(0xFF000000),
);

ThemeData primaryTheme = ThemeData(
  useMaterial3: true,

  colorScheme: lightColorScheme,

  // Scaffold BG Color
  scaffoldBackgroundColor: lightColorScheme.secondaryContainer,

  // App Bar Theme
  appBarTheme: AppBarTheme(
    backgroundColor: lightColorScheme.surface,
    foregroundColor: lightColorScheme.onSurface,
    surfaceTintColor: Colors.transparent,
    centerTitle: true,
    toolbarHeight: 76,
    iconTheme: IconThemeData(size: 36, color: lightColorScheme.primary),
  ),

  dropdownMenuTheme: DropdownMenuThemeData(
    inputDecorationTheme: InputDecorationTheme(
      fillColor: lightColorScheme.surface,
      filled: true,
    ),
  ),

  inputDecorationTheme: InputDecorationTheme(
    fillColor: lightColorScheme.surface,
    filled: true,
    labelStyle:
        TextStyle(color: lightColorScheme.onSurfaceVariant, fontSize: 12),
    hintStyle: TextStyle(
      color: lightColorScheme.secondary,
      fontSize: 12,
    ),
    enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: lightColorScheme.outline,
          width: 2,
        ),
        borderRadius: BorderRadius.circular(24)),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: lightColorScheme.primary,
        width: 2,
      ),
      borderRadius: BorderRadius.circular(24),
    ),
    errorBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: lightColorScheme.error,
        width: 2,
      ),
      borderRadius: BorderRadius.circular(24),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: lightColorScheme.error,
        width: 2,
      ),
      borderRadius: BorderRadius.circular(24),
    ),
    contentPadding: const EdgeInsets.all(16),
    suffixIconColor: lightColorScheme.onSurface,
    errorStyle: const TextStyle(
      fontSize: 0,
    ),
  ),

  textTheme: TextTheme(
    // Display Theme
    displayLarge: TextStyle(
      color: lightColorScheme.inversePrimary,
      fontSize: 14,
    ),
    displayMedium: TextStyle(
      color: lightColorScheme.inversePrimary,
      fontSize: 14,
    ),
    displaySmall: TextStyle(
      color: lightColorScheme.inversePrimary,
      fontSize: 14,
    ),

    // Headline Theme
    headlineLarge: TextStyle(
      color: lightColorScheme.onPrimaryContainer,
      fontSize: 14,
    ),
    headlineMedium: TextStyle(
      color: lightColorScheme.onPrimaryContainer,
      fontSize: 14,
    ),
    headlineSmall: TextStyle(
      color: lightColorScheme.onPrimaryContainer,
      fontSize: 14,
    ),

    // Title Theme
    titleLarge: TextStyle(
      color: lightColorScheme.onSecondaryContainer,
      fontSize: 14,
    ),
    titleMedium: TextStyle(
      color: lightColorScheme.onSecondaryContainer,
      fontSize: 14,
    ),
    titleSmall: TextStyle(
      color: lightColorScheme.onSecondaryContainer,
      fontSize: 14,
    ),

    // Body Theme
    bodyLarge: TextStyle(
      color: lightColorScheme.onSecondaryContainer,
      fontSize: 14,
    ),
    bodyMedium: TextStyle(
      color: lightColorScheme.onSecondaryContainer,
      fontSize: 14,
    ),
    bodySmall: TextStyle(
      color: lightColorScheme.onSecondaryContainer,
      fontSize: 14,
    ),

    // Label Theme
    labelLarge: TextStyle(
      color: lightColorScheme.onSurfaceVariant,
      fontSize: 14,
    ),
    labelMedium: TextStyle(
      color: lightColorScheme.onSurfaceVariant,
      fontSize: 14,
    ),
    labelSmall: TextStyle(
      color: lightColorScheme.onSurfaceVariant,
      fontSize: 14,
    ),
  ),

  textButtonTheme: TextButtonThemeData(
    style: ButtonStyle(
        backgroundColor: WidgetStatePropertyAll(lightColorScheme.primary),
        foregroundColor: WidgetStatePropertyAll(lightColorScheme.onPrimary),
        elevation: const WidgetStatePropertyAll(2),
        padding: const WidgetStatePropertyAll(
            EdgeInsets.symmetric(vertical: 6, horizontal: 16))),
  ),
);

ThemeData darkTheme = ThemeData(
  colorScheme: darkColorScheme,
);

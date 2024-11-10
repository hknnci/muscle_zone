import "package:flutter/material.dart";

class MaterialTheme {
  final TextTheme textTheme;

  const MaterialTheme(this.textTheme);

  static ColorScheme lightScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(4282474385),
      surfaceTint: Color(4282474385),
      onPrimary: Color(4294967295),
      primaryContainer: Color(4292273151),
      onPrimaryContainer: Color(4278197054),
      secondary: Color(4283850609),
      onSecondary: Color(4294967295),
      secondaryContainer: Color(4292535033),
      onSecondaryContainer: Color(4279442475),
      tertiary: Color(4281426573),
      onTertiary: Color(4294967295),
      tertiaryContainer: Color(4291814911),
      onTertiaryContainer: Color(4278197555),
      error: Color(4290386458),
      onError: Color(4294967295),
      errorContainer: Color(4294957782),
      onErrorContainer: Color(4282449922),
      surface: Color(4294572543),
      onSurface: Color(4279835680),
      onSurfaceVariant: Color(4282664782),
      outline: Color(4285822847),
      outlineVariant: Color(4291086032),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4281217078),
      inversePrimary: Color(4289382399),
      primaryFixed: Color(4292273151),
      onPrimaryFixed: Color(4278197054),
      primaryFixedDim: Color(4289382399),
      onPrimaryFixedVariant: Color(4280829815),
      secondaryFixed: Color(4292535033),
      onSecondaryFixed: Color(4279442475),
      secondaryFixedDim: Color(4290692828),
      onSecondaryFixedVariant: Color(4282271577),
      tertiaryFixed: Color(4291814911),
      onTertiaryFixed: Color(4278197555),
      tertiaryFixedDim: Color(4288465915),
      onTertiaryFixedVariant: Color(4279323251),
      surfaceDim: Color(4292467168),
      surfaceBright: Color(4294572543),
      surfaceContainerLowest: Color(4294967295),
      surfaceContainerLow: Color(4294177786),
      surfaceContainer: Color(4293783028),
      surfaceContainerHigh: Color(4293388526),
      surfaceContainerHighest: Color(4293059305),
    );
  }

  ThemeData light() {
    return theme(lightScheme(), lightTextTheme());
  }

  static ColorScheme darkScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(4289382399),
      surfaceTint: Color(4289382399),
      onPrimary: Color(4278857823),
      primaryContainer: Color(4280829815),
      onPrimaryContainer: Color(4292273151),
      secondary: Color(4290692828),
      onSecondary: Color(4280824129),
      secondaryContainer: Color(4282271577),
      onSecondaryContainer: Color(4292535033),
      tertiary: Color(4288465915),
      onTertiary: Color(4278203220),
      tertiaryContainer: Color(4279323251),
      onTertiaryContainer: Color(4291814911),
      error: Color(4294948011),
      onError: Color(4285071365),
      errorContainer: Color(4287823882),
      onErrorContainer: Color(4294957782),
      surface: Color(4279309080),
      onSurface: Color(4293059305),
      onSurfaceVariant: Color(4291086032),
      outline: Color(4287533209),
      outlineVariant: Color(4282664782),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4293059305),
      inversePrimary: Color(4282474385),
      primaryFixed: Color(4292273151),
      onPrimaryFixed: Color(4278197054),
      primaryFixedDim: Color(4289382399),
      onPrimaryFixedVariant: Color(4280829815),
      secondaryFixed: Color(4292535033),
      onSecondaryFixed: Color(4279442475),
      secondaryFixedDim: Color(4290692828),
      onSecondaryFixedVariant: Color(4282271577),
      tertiaryFixed: Color(4291814911),
      onTertiaryFixed: Color(4278197555),
      tertiaryFixedDim: Color(4288465915),
      onTertiaryFixedVariant: Color(4279323251),
      surfaceDim: Color(4279309080),
      surfaceBright: Color(4281809214),
      surfaceContainerLowest: Color(4278980115),
      surfaceContainerLow: Color(4279835680),
      surfaceContainer: Color(4280098852),
      surfaceContainerHigh: Color(4280822319),
      surfaceContainerHighest: Color(4281546042),
    );
  }

  ThemeData dark() {
    return theme(darkScheme(), lightTextTheme());
  }

  ThemeData theme(ColorScheme colorScheme, TextTheme textTheme) => ThemeData(
        useMaterial3: true,
        brightness: colorScheme.brightness,
        colorScheme: colorScheme,
        textTheme: textTheme.apply(
          bodyColor: colorScheme.onSurface,
          displayColor: colorScheme.onSurface,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: lightScheme().primary,
            foregroundColor: lightScheme().onPrimary,
          ),
        ),
        scaffoldBackgroundColor: colorScheme.surface,
        canvasColor: colorScheme.surface,
      );

  static TextTheme lightTextTheme() {
    return const TextTheme(
      displayLarge: TextStyle(
        fontFamily: 'Poppins',
        fontSize: 57,
        fontWeight: FontWeight.normal,
      ),
      displayMedium: TextStyle(
        fontFamily: 'Poppins',
        fontSize: 45,
        fontWeight: FontWeight.normal,
      ),
      displaySmall: TextStyle(
        fontFamily: 'Poppins',
        fontSize: 36,
        fontWeight: FontWeight.normal,
      ),
      headlineLarge: TextStyle(
        fontFamily: 'Poppins',
        fontSize: 32,
        fontWeight: FontWeight.normal,
      ),
      headlineMedium: TextStyle(
        fontFamily: 'Poppins',
        fontSize: 28,
        fontWeight: FontWeight.normal,
      ),
      headlineSmall: TextStyle(
        fontFamily: 'Poppins',
        fontSize: 24,
        fontWeight: FontWeight.normal,
      ),
      titleLarge: TextStyle(
        fontFamily: 'Poppins',
        fontSize: 22,
        fontWeight: FontWeight.normal,
      ),
      titleMedium: TextStyle(
        fontFamily: 'Lato',
        fontSize: 16,
        fontWeight: FontWeight.w500,
      ),
      titleSmall: TextStyle(
        fontFamily: 'Lato',
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
      bodyLarge: TextStyle(
        fontFamily: 'Lato',
        fontSize: 16,
        fontWeight: FontWeight.normal,
      ),
      bodyMedium: TextStyle(
        fontFamily: 'Lato',
        fontSize: 14,
        fontWeight: FontWeight.normal,
      ),
      bodySmall: TextStyle(
        fontFamily: 'Lato',
        fontSize: 12,
        fontWeight: FontWeight.normal,
      ),
      labelLarge: TextStyle(
        fontFamily: 'Lato',
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
      labelSmall: TextStyle(
        fontFamily: 'Lato',
        fontSize: 11,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}

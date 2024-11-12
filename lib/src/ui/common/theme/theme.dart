import 'package:flutter/material.dart';
import 'package:material_color_utilities/material_color_utilities.dart';

@immutable
class MainTheme extends ThemeExtension<MainTheme> {
  final Color primaryColor;
  final Color secondaryColor;
  final Color tertiaryColor;
  final Color neutralColor;
  final Color errorColor;
  final Color accessColor;

  const MainTheme({
    this.primaryColor = const Color(0xFF3A3A3A),
    this.secondaryColor = const Color(0xFF2E2E2E),
    this.tertiaryColor = const Color(0xFFF0F0F0),
    this.neutralColor = const Color(0xFF979797),
    this.errorColor = const Color(0xFFAD281F),
    this.accessColor = const Color(0xFF15DC3B),
  });

  ThemeData themeData(Brightness brightness) {
    final colorScheme = _scheme().toColorScheme(brightness);
    return _theme(colorScheme);
  }

  ThemeData _theme(ColorScheme colorScheme) {
    final isLight = colorScheme.brightness == Brightness.light;

    return ThemeData(
      fontFamily: 'Comfortaa',
      appBarTheme: AppBarTheme(
        iconTheme: const IconThemeData(
          size: 24,
          color: Color(0xFF5F5F5F),
        ),
        elevation: 0.5,
        centerTitle: true,
        actionsIconTheme: IconThemeData(color: colorScheme.tertiary),
        backgroundColor:
            isLight ? colorScheme.primaryContainer : colorScheme.tertiary,
        titleTextStyle: TextStyle(
          color: isLight ? colorScheme.tertiary : colorScheme.surface,
          fontSize: 18,
        ),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: colorScheme.tertiary,
        unselectedItemColor: const Color(0x84999999),
        selectedItemColor: const Color(0xFF5F5F5F),
        elevation: 2,
        type: BottomNavigationBarType.fixed,
        selectedLabelStyle: TextStyle(
          color: colorScheme.secondaryContainer,
          fontSize: 13,
        ),
        selectedIconTheme: IconThemeData(
          size: 24,
          color: colorScheme.primaryContainer,
        ),
        unselectedLabelStyle: TextStyle(
          color: colorScheme.inverseSurface.withOpacity(0.2),
          fontSize: 12,
        ),
        unselectedIconTheme: IconThemeData(
          size: 24,
          color: colorScheme.inverseSurface.withOpacity(0.2),
        ),
      ),
      iconTheme: IconThemeData(
        size: 26,
        color: colorScheme.primaryContainer,
      ),
      primaryIconTheme: IconThemeData(
        size: 26,
        color: colorScheme.primaryContainer,
      ),
      iconButtonTheme: IconButtonThemeData(
        style: ButtonStyle(
          iconColor: MaterialStateProperty.all<Color>(colorScheme.tertiary),
        ),
      ),
      dialogBackgroundColor: colorScheme.tertiary,
      dialogTheme: DialogTheme(backgroundColor: colorScheme.tertiary),
      useMaterial3: true,
      extensions: [this],
      colorScheme: colorScheme,
      scaffoldBackgroundColor:
          isLight ? colorScheme.tertiary : const Color(0xFF392721),
      textTheme: TextTheme(
        titleLarge: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w700,
        ),
        titleMedium: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w700,
          height: 1,
        ),
        titleSmall: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w700,
        ),
        labelLarge: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
        labelMedium: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
        labelSmall: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
        displayLarge: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: colorScheme.tertiary,
        ),
        displayMedium: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: colorScheme.tertiary,
        ),
        displaySmall: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: colorScheme.tertiary,
        ),
        bodyLarge: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w300,
          wordSpacing: .1,
          letterSpacing: 1,
        ),
        bodyMedium: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          height: 1,
        ),
        bodySmall: const TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w400,
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: const Color(0xFF3A3A3A),
          backgroundColor: const Color(0x2DD0D0D0),
          padding: const EdgeInsets.symmetric(
            horizontal: 4,
            vertical: 1,
          ),
          textStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w300,
          ),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: colorScheme.primaryContainer,
          foregroundColor: colorScheme.tertiary,
          shadowColor: secondaryColor.withOpacity(0.5),
          padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
          textStyle: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w500,
            color: colorScheme.tertiary,
          ),
        ),
      ),
      buttonTheme: ButtonThemeData(
        buttonColor: colorScheme.primaryContainer,
        textTheme: ButtonTextTheme.accent,
      ),
      bottomSheetTheme: const BottomSheetThemeData(
        elevation: 0,
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        modalBackgroundColor: Colors.transparent,
      ),
    );
  }

  @override
  ThemeExtension<MainTheme> copyWith({
    Color? primaryColor,
    Color? tertiaryColor,
    Color? neutralColor,
  }) =>
      MainTheme(
        primaryColor: primaryColor ?? this.primaryColor,
        tertiaryColor: primaryColor ?? this.primaryColor,
        neutralColor: primaryColor ?? this.primaryColor,
      );

  @override
  ThemeExtension<MainTheme> lerp(
    covariant ThemeExtension<MainTheme>? other,
    double t,
  ) {
    if (other is! MainTheme) return this;

    return MainTheme(
      primaryColor: Color.lerp(primaryColor, other.primaryColor, t)!,
      tertiaryColor: Color.lerp(tertiaryColor, other.tertiaryColor, t)!,
      neutralColor: Color.lerp(neutralColor, other.neutralColor, t)!,
    );
  }

  Scheme _scheme() {
    final base = CorePalette.of(primaryColor.value);
    final primary = base.primary;
    final secondary = CorePalette.of(secondaryColor.value).secondary;
    final tertiary = CorePalette.of(tertiaryColor.value).tertiary;
    final neutral = CorePalette.of(neutralColor.value).neutral;
    final error = CorePalette.of(errorColor.value).error;

    return Scheme(
      primary: primary.get(40),
      onPrimary: primary.get(100),
      primaryContainer: primary.get(62),
      onPrimaryContainer: primary.get(10),
      secondary: secondary.get(40),
      onSecondary: secondary.get(85),
      secondaryContainer: secondary.get(95),
      onSecondaryContainer: secondary.get(70),
      tertiary: tertiary.get(100),
      onTertiary: tertiary.get(100),
      tertiaryContainer: tertiary.get(90),
      onTertiaryContainer: tertiary.get(10),
      error: error.get(40),
      onError: error.get(100),
      errorContainer: error.get(90),
      onErrorContainer: error.get(10),
      background: neutral.get(99),
      onBackground: neutral.get(10),
      surface: neutral.get(99),
      onSurface: neutral.get(10),
      outline: base.neutralVariant.get(50),
      outlineVariant: base.neutralVariant.get(80),
      surfaceVariant: neutral.get(90),
      onSurfaceVariant: base.neutralVariant.get(30),
      shadow: neutral.get(0),
      scrim: neutral.get(0),
      inverseSurface: neutral.get(20),
      inverseOnSurface: neutral.get(95),
      inversePrimary: neutral.get(80),
    );
  }
}

extension on Scheme {
  ColorScheme toColorScheme(Brightness brightness) {
    return ColorScheme(
      brightness: brightness,
      primary: Color(primary),
      primaryContainer: Color(primaryContainer),
      tertiary: Color(tertiary),
      onPrimary: Color(onPrimary),
      secondary: Color(secondary),
      onSecondary: Color(onSecondary),
      secondaryContainer: Color(secondaryContainer),
      onSecondaryContainer: Color(onSecondaryContainer),
      error: Color(error),
      onError: Color(onError),
      errorContainer: Color(errorContainer),
      onErrorContainer: Color(onErrorContainer),
      background: Color(background),
      onBackground: Color(onBackground),
      surface: Color(surface),
      onSurface: Color(onSurface),
      surfaceVariant: Color(surfaceVariant),
    );
  }
}

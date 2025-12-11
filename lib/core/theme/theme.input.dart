import 'package:flutter/material.dart';

import '../utils/color_palette.dart';
import 'theme.typography.dart';

InputDecorationTheme inputTheme(String fontPrimary, String fontSecondary) =>
    InputDecorationTheme(
      filled: true,
      fillColor: Colors.white,
      iconColor: ColorPalette.neutral70,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 16,
        // vertical: 16,
      ),
      prefixIconColor: ColorPalette.neutral70,
      suffixIconColor: ColorPalette.neutral70,
      hintStyle: textTheme(fontPrimary, fontSecondary).bodyLarge,
      alignLabelWithHint: true,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(
          color: Color(0xFFD7DAE0)
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(
          color: Color(0xFFD7DAE0)
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(
          color: ColorPalette.primary50
        ),
      ),
    );

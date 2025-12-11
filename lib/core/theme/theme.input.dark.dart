import 'package:flutter/material.dart';

import 'theme.input.dart';

InputDecorationTheme inputThemeDark(String fontPrimary, String fontSecondary) =>
    inputTheme(fontPrimary, fontSecondary).copyWith(
      hintStyle: inputTheme(fontPrimary, fontSecondary)
          .hintStyle
          ?.copyWith(color: Colors.white),
      fillColor: Colors.black,
      filled: true,

    );

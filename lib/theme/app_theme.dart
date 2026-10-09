import 'package:flutter/material.dart';

class AppTheme {
  static final ThemeData light = ThemeData(
    useMaterial3: true,

    // WARNA UTAMA APLIKASI
    colorScheme: ColorScheme.fromSeed(
      seedColor: const Color(0xFF2563EB),
    ),

    // WARNA LATAR BELAKANG
    scaffoldBackgroundColor: const Color(0xFFF8FAFC),
  );
}
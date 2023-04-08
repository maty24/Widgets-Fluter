import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:widgets_app/config/theme/app_theme.dart';

// Listado de colores inmutable
final colorsListProver = StateProvider((ref) => colorList);

final isDarkModeProvider = StateProvider((ref) => false);



//Un simple entero
final selectedColorProvider = StateProvider((ref) => 0);
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:widgets_app/config/theme/app_theme.dart';

// Listado de colores inmutable
//para valores inmutables
final colorsListProver = Provider((ref) => colorList);

//stateprovier una pieza de estado
final isDarkModeProvider = StateProvider((ref) => false);

//Un simple entero
final selectedColorProvider = StateProvider((ref) => 0);

//un objeto de tipo apptheme
//objeto mas eleborado
final themeNotifierProvider = StateNotifierProvider<ThemeNotifier, AppTheme>(
  (ref) => ThemeNotifier(),
);





// Controller o Notifier
class ThemeNotifier extends StateNotifier<AppTheme> {
  // STATE = Estado = new AppTheme();
  //el super copia el estado
  ThemeNotifier() : super(AppTheme());


//una funcion para cambiar el estado
  void toggleDarkmode() {
    //copia el estado y cambia el valor de isdarkmode
    //aca cambia el estado
    state = state.copyWith(isDarkMode: !state.isDarkMode);
  }

  void changeColorIndex(int colorIndex) {
    //copia el estado y cambia el valor de selectedcolor
    state = state.copyWith(selectedColor: colorIndex);
  }
}

import 'package:flutter/material.dart';

class SnackbarScreen extends StatelessWidget {
  static const name = 'snackbar_screen';

  const SnackbarScreen({super.key});

  void showCustomSnackbar(BuildContext context) {
    //limpio los scaffold
    ScaffoldMessenger.of(context).clearSnackBars();
    final snakback = SnackBar(
      content: const Text('Hola mundo'),
      action: SnackBarAction(
        label: 'ok!',
        //para precionar al generar el scaffold
        onPressed: () {},
      ),
      //tiempo que dura el scaffold
      duration: const Duration(seconds: 2),
    );
    ScaffoldMessenger.of(context).showSnackBar(snakback);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Snackbars y Dialogos'),
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: const Text('Mostrar Snackbar'),
        //para mostrar iconos
        icon: const Icon(Icons.remove_red_eye_outlined),
        onPressed: () => showCustomSnackbar(context),
      ),
    );
  }
}

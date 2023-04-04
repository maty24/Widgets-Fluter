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

 //para mostrar dialogos, se usa el context para informacion de la aplicacion
  void openDialog(BuildContext context){
    //para mostrar el dialogo
    showDialog(
      //contexto de la aplicacion
      context: context,
      //builder que se ejucta en tiempo de ejecucion
      builder: (context) => AlertDialog(
        title: const Text('Titulo'),
        content: const Text('Contenido'),
        //acciones del dialogo
        actions: [
          TextButton(
            //nabetori.pop para cerrar el dialogo
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Aceptar'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Snackbars y Dialogos'),
      ),
      body: Center(
        child: Column(
          children: [
            FilledButton.tonal(
                onPressed: () {
                  showAboutDialog(
                      context: context,
                      //contendio del dialog
                      children: [
                        const Text(
                            'Eiusmod consectetur labore proident exercitation.')
                      ]);
                },
                child: const Text('Licencias usadas')),
            FilledButton.tonal(
                onPressed: () {
                  //se le envia el context
                  openDialog(context);
                }, child: const Text('Mostrar dialogo')),
          ],
        ),
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

import 'package:flutter/material.dart';

class ProgressScreen extends StatelessWidget {
  static const name = 'progress_screen';

  const ProgressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Progress Indicators'),
      ),
      body: _ProgressView(),
    );
  }
}

class _ProgressView extends StatelessWidget {
  const _ProgressView();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(children: const [
        SizedBox(height: 30),
        Text('Circular progress indicator'),
        SizedBox(height: 10),
        CircularProgressIndicator(
            strokeWidth: 2, backgroundColor: Colors.black45),
        SizedBox(height: 20),
        Text('Circular indicatir controlado'),
        SizedBox(height: 10),
        _ControlledProgresIndicator()
      ]),
    );
  }
}

class _ControlledProgresIndicator extends StatelessWidget {
  const _ControlledProgresIndicator();

  @override
  Widget build(BuildContext context) {
    //se contruye en tiempo de ejecucion en un aync
    return StreamBuilder(
      stream: Stream.periodic(const Duration(milliseconds: 300), (value) {
        return (value * 2) / 100;
        //toma valores hasta que sea menor que 100
      }).takeWhile((value) => value < 100),
      //lo que consturye al ejecutar
      builder: (context, snapshot) {
        //snapsot es el valor
        final progressValue = snapshot.data ?? 0; //si no hay valor maanda un 0
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          //row no hay limite de ancho del row hay que usar expander
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(
                //value es el valor que carga la data
                value: progressValue,
                strokeWidth: 2,
                backgroundColor: Colors.black12,
              ),
              //toma todo el ancho que da el padre
              Expanded(
                  child: LinearProgressIndicator(
                value: progressValue,
              ))
            ],
          ),
        );
      },
    );
  }
}

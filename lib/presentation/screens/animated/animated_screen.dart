import 'package:flutter/material.dart';
import 'dart:math';

class AnimatedScreen extends StatefulWidget {
  static const name = 'animated_screen';
  const AnimatedScreen({super.key});

  @override
  State<AnimatedScreen> createState() => _AnimatedScreenState();
}

class _AnimatedScreenState extends State<AnimatedScreen> {
  double width = 50;
  double height = 50;
  Color color = Colors.indigo;
  double borderRadium = 10.0;

  void changeShape() {
    final random = Random();
    //el setState es para que se actualice la pantalla
    setState(() {
      //nextInt es para que sea un numero aleatorio
      width = random.nextInt(300) + 120;
      height = random.nextInt(300) + 120;
      color = Color.fromRGBO(
          random.nextInt(256), random.nextInt(256), random.nextInt(256), 1);
      borderRadium = random.nextInt(100).toDouble();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Animated'),
      ),
      body: Center(
          child: AnimatedContainer(
        duration: const Duration(milliseconds: 400),
        //tipo de animacion
        curve: Curves.elasticOut,
        width: width <= 0 ? 0 : width,
        //para que no sea numero negativo
        height: height <= 0 ? 0 : height,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(borderRadium), color: color),
      )),
      floatingActionButton: FloatingActionButton(
        //si tengo los mismos argumentos no pongo el ()=> ()
        onPressed: changeShape,
        child: const Icon(Icons.play_arrow_rounded),
      ),
    );
  }
}

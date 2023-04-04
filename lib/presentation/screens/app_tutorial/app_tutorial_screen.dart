import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SlideInfo {
  final String title;
  final String description;
  final String image;

  SlideInfo(this.title, this.description, this.image);
}

final slider = <SlideInfo>[
  SlideInfo('busca comida', 'caption', 'assets/images/1.png'),
  SlideInfo('Entrega rapida', 'caption', 'assets/images/2.png'),
  SlideInfo('disgruta la comida', 'caption', 'assets/images/3.png'),
];

class AppTutorialScreen extends StatefulWidget {
  static const name = 'tutorial_screen';

  const AppTutorialScreen({super.key});

  @override
  State<AppTutorialScreen> createState() => _AppTutorialScreenState();
}

class _AppTutorialScreenState extends State<AppTutorialScreen> {
  //controlador de la pagina
  final pageviewController = PageController();
  bool endReached = false;

  @override
  void initState() {
    super.initState();
    //no regresa nada solo escucha
    pageviewController.addListener(() {
      //si no hay valor regresa 0
      final page = pageviewController.page ?? 0;
      //le pongo 1.5 para cuando se vea la mitad de la penultima y pagina cambie el state
      if (!endReached && page >= (slider.length - 1.5)) {
        setState(() {
          endReached = true;
        });
      }
    });
  }

//cuando se llama un listener o controller se debe de llamar el dispose para que no se quede en memoria
  @override
  void dispose() {
    pageviewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
              controller: pageviewController,
              physics: const BouncingScrollPhysics(),
              children: slider
                  .map((slideData) => _Slide(
                        title: slideData.title,
                        description: slideData.description,
                        image: slideData.image,
                      ))
                  //esta esperado una lista de widgets
                  .toList()),
          Positioned(
            right: 20,
            top: 50,
            child: TextButton(
              child: const Text('Saltar'),
              onPressed: () => context.pop(),
            ),
          ),
          endReached
              ? Positioned(
                  bottom: 30,
                  right: 30,
                  child: FadeInRight(
                    from: 15,
                    delay: const Duration(seconds: 1),
                    child: FilledButton(
                      onPressed: () => context.pop(),
                      child: const Text('Comenzar'),
                    ),
                  ))
              : const SizedBox(),
        ],
      ),
    );
  }
}

class _Slide extends StatelessWidget {
  final String title;
  final String description;
  final String image;
  const _Slide({
    required this.title,
    required this.description,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    //context es el contexto de la aplicacion la data global
    final titleStyle = Theme.of(context).textTheme.titleLarge;
    final captionStyle = Theme.of(context).textTheme.bodySmall;
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Center(
          child: Column(
            //para centrar los elementos
            mainAxisAlignment: MainAxisAlignment.center,
            //para alinear los elementos
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image(image: AssetImage(image)),
              const SizedBox(height: 20),
              Text(title, style: titleStyle),
              const SizedBox(height: 10),
              Text(description, style: captionStyle),
            ],
          ),
        ));
  }
}

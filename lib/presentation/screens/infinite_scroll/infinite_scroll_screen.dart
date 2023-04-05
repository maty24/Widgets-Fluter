import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class InfiniteScrollScreen extends StatefulWidget {
  static const name = 'infinite_screen';

  const InfiniteScrollScreen({super.key});

  @override
  State<InfiniteScrollScreen> createState() => _InfiniteScrollScreenState();
}

class _InfiniteScrollScreenState extends State<InfiniteScrollScreen> {
  List<int> imagesIds = [1, 2, 3, 4, 5];

  final ScrollController scrollController = ScrollController();

  bool isLoading = false;
  bool isMounted = true;

  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      //verificar si esta en el final de la lista por los pixeles le sumo 500 para que antes de llegar al final de la lista ya empiece a cargar mas imagenes
      //si la posicion de los pixeles es mayor o igual a la posicion maxima de la lista menos 500 voy a hacer un load mas de imagenes
      if ((scrollController.position.pixels + 500) >=
          //esta en el final de la lista
          scrollController.position.maxScrollExtent) {
        loadNextPage();
      }
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    //cuando se desmonte el widget
    isMounted = false;
    super.dispose();
  }

//cargar mas imagenes
  Future loadNextPage() async {
    //si esta cargando no hacer nada y se sale de la funcion para que no haga la peticion de nuevo
    if (isLoading) return;
    isLoading = true;
    setState(() {});

    //esperar 2 segundos
    await Future.delayed(const Duration(seconds: 2));
    //agregar 5 imagenes
    addFiveImages();
    isLoading = false;

    //si no esta montado no hacer nada
    if (!isMounted) return;
    
    //actualizar el estado
    setState(() {});
    //mover el scroll hacia abajo
    moveScrollToBottom();
  }

  //refrescar la lista
  Future<void> onRefresh() async {
    isLoading = true;
    setState(() {});

    //esperar 2 segundos
    await Future.delayed(const Duration(seconds: 2));
    if (!isMounted) return;

    //obtener el ultimo id de la lista
    final lastId = imagesIds.last;
    isLoading = false;
    //limpiar la lista
    imagesIds.clear();
    //agregar el ultimo id
    imagesIds.add(lastId + 1);
    //agregar 5 imagenes
    addFiveImages();

    setState(() {});
  }

  void moveScrollToBottom() {
    //si la posicion de los pixeles es menor o igual a la posicion maxima de la lista menos 150
    //si no esta cerca del final de la lista no hacer nada
    if (scrollController.position.pixels + 100 <=
        scrollController.position.maxScrollExtent) return;

//si esta cerca del final de la lista hacer un scroll hacia abajo
    scrollController.animateTo(
      //posicion actual de los pixeles mas 120
      scrollController.position.pixels + 120,
      duration: const Duration(milliseconds: 300),
      curve: Curves.fastOutSlowIn,
    );
  }

  void addFiveImages() {
    //obtener el ultimo id de la lista
    final lastId = imagesIds.last;
    imagesIds.addAll([1, 2, 3, 4, 5].map((e) => lastId + e));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: MediaQuery.removePadding(
        context: context,
        //me quiero quitar el padding de arriba y de abajo
        removeTop: true,
        removeBottom: true,
        child: RefreshIndicator(
          //es un void future no retorna nada
          onRefresh: onRefresh,
          //bajar la barra de carga 10 pixeles
          edgeOffset: 10,
          // para este mas delgado
          strokeWidth: 2,
          child: ListView.builder(
              controller: scrollController,
              itemCount: imagesIds.length,
              itemBuilder: (context, index) {
                return FadeInImage(
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: 300,
                  placeholder:
                      const AssetImage('assets/images/jar-loading.gif'),
                  image: NetworkImage(
                      'https://picsum.photos/id/${imagesIds[index]}/200/300'),
                );
              }),
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () => context.pop(),
          child: isLoading
              //si esta cargando mostrar el icono de carga
              ? SpinPerfect(
                  infinite: true,
                  child: const Icon(Icons.refresh_rounded),
                )
              //si no esta cargando mostrar el icono de volver
              //fadein es un efecto de animacion
              : FadeIn(child: const Icon(Icons.arrow_back))),
    );
  }
}

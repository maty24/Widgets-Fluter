import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:widgets_app/config/menu/menu_items.dart';

class SideMenu extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;

  const SideMenu({super.key, required this.scaffoldKey});

  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  int navDrawerIndex = 0;

  @override
  Widget build(BuildContext context) {
    //para saber si el dispositivo tiene notch y ver cuanto padding top tiene
    final hasNotch = MediaQuery.of(context).padding.top > 35; //si tiene notch

    return NavigationDrawer(
        //selecionado por defecto , saca referencia en los children
        selectedIndex: navDrawerIndex,
        //el value es el nuevo valor que se va a asignar
        onDestinationSelected: (value) {
          //cambia el estado , la selecion selecionada
          setState(() {
            //se asigna el nuevo valor
            navDrawerIndex = value;
          });
          //me dice cual es el item seleccionado
          final menuItem = appMenuItems[value];
          context.push(menuItem.link);


          //le pongo widget porque es un atributo de la clase y hacer una referencia a la clase 
          //para poder cerrar el drawer 
          widget.scaffoldKey.currentState?.closeDrawer();
        },
        children: [
          Padding(
            //si tiene notch le pone 0 , si no le pone 20
            padding: EdgeInsets.fromLTRB(28, hasNotch ? 0 : 20, 16, 10),
            child: const Text('menu'),
          ),
          //tragigo todos los items de la lista
          ...appMenuItems
              //muestra los 3 primero
              .sublist(0, 3)
              //mapeo cada item
              .map(
                (menuItem) => NavigationDrawerDestination(
                  icon: Icon(menuItem.icon),
                  label: Text(menuItem.title),
                ),
              ),

          const Padding(
            padding: EdgeInsets.fromLTRB(28, 16, 28, 10),
            child: Divider(),
          ),

          const Padding(
            //si tiene notch le pone 0 , si no le pone 20
            padding: EdgeInsets.fromLTRB(28, 10, 16, 10),
            child: Text('More optinos'),
          ),
          //tragigo todos los items de la lista
          ...appMenuItems
              //muestra desde el 3 en adelante
              .sublist(3)
              //mapeo cada item
              .map(
                (menuItem) => NavigationDrawerDestination(
                  icon: Icon(menuItem.icon),
                  label: Text(menuItem.title),
                ),
              ),
        ]);
  }
}

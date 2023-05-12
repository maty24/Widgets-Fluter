import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:widgets_app/config/menu/menu_items.dart';
import 'package:widgets_app/presentation/widgets/side_menu.dart';

class HomeScreen extends StatelessWidget {
  //para no crear instancias de esta
  static const String name = 'home_screen';



  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    //esto es para poder usar el estado del scaffold
    final scaffoldKey = GlobalKey<ScaffoldState>();
    return Scaffold(
      //para poder usar el estado del scaffold y tiene la referencia de todo el scaffold
      key: scaffoldKey,
        appBar: AppBar(
          title: const Text('Flutter + Material 3'),
        ),
        body: const _HomeView(),
        //el drawer es el menu lateral
        drawer:  SideMenu(scaffoldKey: scaffoldKey));
  }
}

class _HomeView extends StatelessWidget {
  const _HomeView();

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: appMenuItems.length,
      itemBuilder: (context, index) {
        final menuItem = appMenuItems[index];
        return _CustomListTite(menuItem: menuItem);
      },
    );
  }
}

class _CustomListTite extends StatelessWidget {
  const _CustomListTite({
    required this.menuItem,
  });

   //este es el array de los items
  final MenuItem menuItem;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return ListTile(
      leading: Icon(menuItem.icon),
      trailing: Icon(
        Icons.arrow_forward_ios_outlined,
        color: colors.primary,
      ),
      title: Text(menuItem.title),
      subtitle: Text(menuItem.subTitle),
      onTap: () {
        //estoy haciendo el push de las rutas o screens
        context.push(menuItem.link);
      },
    );
  }
}

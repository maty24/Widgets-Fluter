import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:widgets_app/presentation/providers/counter_provider.dart';
import 'package:widgets_app/presentation/providers/theme_provider.dart';

//consumer widget es un widget que consume un provider
class CounterScreen extends ConsumerWidget {
  static const name = 'counter_screen';
  const CounterScreen({super.key});

  @override
  //el segundo parametro es el ref que es el provider
  Widget build(BuildContext context, WidgetRef ref) {
    //que este pendiente de los cambios del provider y llamo el provider de cual quiero ver los cambios
    final int clickCounter = ref.watch(counterProvider);
    final bool isDarkMode = ref.watch(isDarkModeProvider);

    return Scaffold(
        appBar: AppBar(
          title: const Text('Counter Screen'),
          actions: [
            IconButton(
              icon: Icon(isDarkMode ? Icons.light_mode : Icons.dark_mode),
              onPressed: () {
                //para que ponga el estado contrario
                ref.read(isDarkModeProvider.notifier).update((state) => !state);
              },
            )
          ],
        ),
        body: Center(
          child: Text('Valor: $clickCounter',
              style: Theme.of(context).textTheme.titleLarge),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            //ref.read es para leer el provider y el .notifier es para notificar los cambios y el .state es para cambiar el estado
            //read para los metodos
            ref.read(counterProvider.notifier).state++;
          },
          child: const Icon(Icons.add),
        ));
  }
}

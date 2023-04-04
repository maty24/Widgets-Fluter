import 'package:flutter/material.dart';

class UiControlsScreen extends StatelessWidget {
  static const name = 'ui_controls_screen';

  const UiControlsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('UI Controls'),
      ),
      body: _UiControlsView(),
    );
  }
}

//stateful widget para el manejo de los estados
class _UiControlsView extends StatefulWidget {
  const _UiControlsView();

  @override
  State<_UiControlsView> createState() => _UiControlsViewState();
}

enum Trasportation { car, bike, walk, bus, train }

class _UiControlsViewState extends State<_UiControlsView> {
  bool isSwitched = true;
  //por defecto dejo el car
  Trasportation selectedTrasportation = Trasportation.car;
  bool wantsBreakfast = false;
  bool wantsLunch = false;
  bool wantsDinner = false;
  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const ClampingScrollPhysics(),
      children: [
        SwitchListTile(
          title: const Text('Switch'),
          subtitle: const Text('Switch subtitle'),
          value: isSwitched,
          //metodo que regresa un valor
          onChanged: (onChanged) {
            //cambio de estado
            setState(() {
              isSwitched = !isSwitched;
            });
          },
        ),
        //expande todo lo que este dentro de el osea el radio list tile
        ExpansionTile(
          title: const Text('Veichulo de transporte'),
          subtitle: const Text('Expansion Tile subtitle'),
          children: [
            RadioListTile(
              title: const Text('Car'),
              subtitle: const Text('Car subtitle'),
              value: Trasportation.car,
              groupValue: selectedTrasportation,
              onChanged: (value) => setState(() {
                selectedTrasportation = Trasportation.car;
              }),
            ),
            RadioListTile(
              title: const Text('Bus'),
              subtitle: const Text('Bus subtitle'),
              value: Trasportation.bike,
              groupValue: selectedTrasportation,
              onChanged: (value) => setState(() {
                selectedTrasportation = Trasportation.bike;
              }),
            ),
            RadioListTile(
              title: const Text('Bike'),
              subtitle: const Text('Bike subtitle'),
              value: Trasportation.walk,
              groupValue: selectedTrasportation,
              onChanged: (value) => setState(() {
                selectedTrasportation = Trasportation.walk;
              }),
            ),
            RadioListTile(
              title: const Text('Train'),
              subtitle: const Text('Train subtitle'),
              value: Trasportation.train,
              groupValue: selectedTrasportation,
              onChanged: (value) => setState(() {
                selectedTrasportation = Trasportation.train;
              }),
            ),
          ],
        ),

        CheckboxListTile(
          title: const Text('Almuerzo?'),
          value: wantsLunch,
          onChanged: (value) => setState(() {
            wantsLunch = !wantsLunch;
          }),
        ),
        CheckboxListTile(
          title: const Text('Desayuno?'),
          value: wantsBreakfast,
          onChanged: (value) => setState(() {
            wantsBreakfast = !wantsBreakfast;
          }),
        ),
        CheckboxListTile(
          title: const Text('Cena?'),
          value: wantsDinner,
          onChanged: (value) => setState(() {
            wantsDinner = !wantsDinner;
          }),
        ),
      ],
    );
  }
}

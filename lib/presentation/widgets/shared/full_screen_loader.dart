import 'package:flutter/material.dart';

class FullScreenLoader extends StatelessWidget {
  const FullScreenLoader({super.key});

  Stream<String> getLoadingMessages() {
    final messages = <String>[
      "Cargando...",
      "Cargando peliculas",
      "Cargando populares",
      "Que tal si ves una serie",
      "Cargando proximos estrenos",
      "Esto esta tardando mas de lo esperado :("
    ];
    return Stream<String>.periodic(const Duration(milliseconds: 1200), (step) {
      return messages[step];
    }).take(messages.length);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      const Text("Espere, por favor"),
      SizedBox(height: 10),
      CircularProgressIndicator(
        strokeWidth: 2,
      ),
      SizedBox(height: 10),
      StreamBuilder(
          stream: getLoadingMessages(),
          builder: (context, snapshot) {
            return Text(snapshot.data ?? "Cargando...");
          })
    ]));
  }
}

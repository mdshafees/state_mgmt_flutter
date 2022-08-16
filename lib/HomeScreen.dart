import 'package:flutter/material.dart';
import 'package:flutter_application_1/provider_state.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${context.watch<ProviderManagement>().number}"),
      ),
      body: Center(
          child: Column(
        children: [Text("${context.watch<ProviderManagement>().lists}")],
      )),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: null,
            onPressed: () => context.read<ProviderManagement>().decrement(),
            child: const Icon(Icons.clear),
          ),
          FloatingActionButton(
            heroTag: null,
            onPressed: () =>
                context.read<ProviderManagement>().removeList("One"),
            child: const Icon(Icons.abc),
          ),
        ],
      ),
    );
  }
}

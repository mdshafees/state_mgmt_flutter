import 'package:flutter/material.dart';
import 'package:flutter_application_1/HomeScreen.dart';
import 'package:flutter_application_1/provider_state.dart';
import 'package:provider/provider.dart';

import 'Calander.dart';

void main() {
  runApp(RestorationScope(
    restorationId: "root",
    child: MultiProvider(
      providers: [
        ChangeNotifierProvider<ProviderManagement>(
            create: (_) => ProviderManagement()),
        ChangeNotifierProvider<EventProvider>(create: (_) => EventProvider()),
      ],
      child: const MyApp(),
    ),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const EventCalander());
  }
}
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: const MyHomePage(title: 'Flutter Demo Home Page'),
//     );
//   }
// }

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                'You have pushed the button this many times:',
              ),
              Text(
                '${context.watch<ProviderManagement>().number}',
                style: Theme.of(context).textTheme.headline4,
              ),
              Text(
                '${context.watch<ProviderManagement>().cartList}',
                style: Theme.of(context).textTheme.headline4,
              ),
            ],
          ),
        ),
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton(
              heroTag: null,
              onPressed: () => context.read<ProviderManagement>().increment(),
              child: const Icon(Icons.add),
            ),
            const SizedBox(
              width: 20,
            ),
            FloatingActionButton(
              heroTag: null,
              onPressed: () => context.read<ProviderManagement>().decrement(),
              child: const Icon(Icons.clear),
            ),
            const SizedBox(
              width: 20,
            ),
            FloatingActionButton(
              heroTag: null,
              onPressed: () =>
                  context.read<ProviderManagement>().addList("One"),
              child: const Icon(Icons.car_crash),
            ),
            const SizedBox(
              width: 20,
            ),
            FloatingActionButton(
              heroTag: null,
              onPressed: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const HomeScreen())),
              child: const Icon(Icons.home),
            ),
          ],
        ));
  }
}

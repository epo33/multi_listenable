import 'package:flutter/material.dart';
import 'package:multi_listenable/multi_listenable.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final alpha = ValueNotifier(255.0);
  final red = ValueNotifier(255.0);
  final green = ValueNotifier(0.0);
  final blue = ValueNotifier(0.0);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MultiListenableBuilder',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text("MultiListenableBuilder demo"),
        ),
        body: Padding(
            padding: EdgeInsets.all(32),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: MultiListenableBuilder(
                    listenables: [alpha, red, green, blue],
                    builder: (context) => Container(
                      color: Color.fromARGB(
                        alpha.value.round(),
                        red.value.round(),
                        green.value.round(),
                        blue.value.round(),
                      ),
                    ),
                  ),
                ),
                _ColorSlider("A", alpha),
                _ColorSlider("R", red),
                _ColorSlider("G", green),
                _ColorSlider("B", blue),
              ],
            )),
      ),
    );
  }
}

class _ColorSlider extends StatelessWidget {
  _ColorSlider(
    this.name,
    this.color,
  );

  final String name;

  final ValueNotifier<double> color;

  @override
  Widget build(BuildContext context) => Row(
        children: [
          SizedBox(width: 10, child: Text(name)),
          Expanded(
            child: ValueListenableBuilder(
              valueListenable: color,
              builder: (context, value, child) => Slider(
                value: color.value,
                min: 0,
                max: 255,
                onChanged: (value) => color.value = value,
              ),
            ),
          ),
        ],
      );
}

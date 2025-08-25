/*
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          //
          // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
          // action in the IDE, or press "p" in the console), to see the
          // wireframe for each widget.
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('You have pushed the button this many times:'),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
*/

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:ir_sensor_plugin/ir_sensor_plugin.dart';

const laskoOnOff =
    '0000 006D 0000 000C 002E 000E 002E 000E 000E 002E 002E 000E 002E 000E 000E 002E 000E 002E 000E 002E 000E 002E 000E 002E 000E 002E 002E 010D';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';
  bool _hasIrEmitter = false;
  String _getCarrierFrequencies = 'Unknown';

  var power = [
    169,
    168,
    21,
    63,
    21,
    63,
    21,
    63,
    21,
    63,
    21,
    63,
    21,
    63,
    21,
    63,
    21,
    1794,
    169,
    168,
    21,
    21,
    21,
    3694
  ];

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    bool hasIrEmitter;
    String getCarrierFrequencies;

    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      platformVersion = await IrSensorPlugin.platformVersion;
      hasIrEmitter = await IrSensorPlugin.hasIrEmitter;
      getCarrierFrequencies = await IrSensorPlugin.getCarrierFrequencies;
    } on PlatformException {
      platformVersion = 'Failed to get data in a platform.';
      hasIrEmitter = false;
      getCarrierFrequencies = 'None';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
      _hasIrEmitter = hasIrEmitter;
      _getCarrierFrequencies = getCarrierFrequencies;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Column(
            children: [
              Container(
                height: 15.0,
              ),
              Text('Running on: $_platformVersion\n'),
              Text('Has Ir Emitter: $_hasIrEmitter\n'),
              Text('IR Carrier Frequencies:$_getCarrierFrequencies'),
              Container(
                height: 15.0,
              ),
              MaterialButton(
                color: Colors.amber,
                onPressed: () async {
                  if (_hasIrEmitter) {
                    final String result =
                        await IrSensorPlugin.transmitListInt(list: power);

                    debugPrint('Emitting  List Int Signal: $result');
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Not has Ir emitter')));
                  }
                },
                child: Text('Transmitt List Int'),
              ),
              Container(
                height: 15.0,
              ),
              FormSpecificCode(hasIrEmitter: _hasIrEmitter),
            ],
          ),
        ),
      ),
    );
  }
}

class FormSpecificCode extends StatelessWidget {
  FormSpecificCode({
    super.key,
    required this.hasIrEmitter,
  });

  final bool hasIrEmitter;
  final _formKey = GlobalKey<FormState>();
  final _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Form(
          key: _formKey,
          child: Column(children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                decoration: InputDecoration(
                  hintText: 'Write specific String code to transmit',
                  suffixIcon: IconButton(
                    onPressed: () => _textController.clear(),
                    icon: Icon(Icons.clear),
                  ),
                ),
                controller: _textController,
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Write the code to transmit';
                  }
                  return null;
                },
              ),
            )
          ])),
      Container(
        height: 15.0,
      ),
      MaterialButton(
        color: Colors.amber,
        onPressed: () async {
          if (hasIrEmitter && (_formKey.currentState?.validate() ?? false)) {
            final String result = await IrSensorPlugin.transmitString(
                pattern: _textController.text);
            if (result.contains('Emitting') && context.mounted) {
              ScaffoldMessenger.of(context)
                ..clearSnackBars()
                ..showSnackBar(
                  SnackBar(
                    content: Text('Broadcasting... ${_textController.text}'),
                  ),
                );
            }
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Not has Ir emitter or invalid code')));
          }
        },
        child: Text('Transmit Specific Code HEX'),
      )
    ]);
  }
}
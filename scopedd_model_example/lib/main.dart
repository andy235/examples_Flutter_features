import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Inherited Demo",
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Iherited Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('scoped_model Widget'),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          ScopedModel<MyModelState>(
            model: MyModelState(),
            child: AppRootWidget(),
          ),
        ],
      ),
    );
  }
}

class AppRootWidget extends StatelessWidget {
  const AppRootWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Column(
        children: [
          Text('(Root Widget)', style: Theme
              .of(context)
              .textTheme
              .headline4,),
          SizedBox(height: 50,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Counter(),
              Counter(),
            ],
          )
        ],
      ),
    );
  }
}

class Counter extends StatelessWidget {
  const Counter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MyModelState>(
      rebuildOnChange: true,
      builder: (context, child, model) =>
          Card(
            margin: EdgeInsets.all(4).copyWith(bottom: 32),
            color: Colors.yellowAccent,
            child: Column(
              children: [
                Text('(Child Widget'),
                Text('${model.counterValue}', style: Theme
                    .of(context)
                    .textTheme
                    .headline4,),
                ButtonBar(
                  children: [
                    IconButton(
                      icon: Icon(Icons.remove),
                      color: Colors.red,
                      onPressed: () =>model._decrementCounter(),
                    ),
                    IconButton(
                      icon: Icon(Icons.add),
                      color: Colors.green,
                      onPressed: () => model._incrementCounter(),
                    )
                  ],
                )
              ],
            ),
          ),
    );
  }
}

class MyModelState extends Model {

  int _counter = 0;

  int get counterValue => _counter;

  void _incrementCounter() {
   _counter++;
   notifyListeners();
  }

  void _decrementCounter() {
   _counter--;
   notifyListeners();
  }}
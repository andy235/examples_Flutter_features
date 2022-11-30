import 'package:flutter/material.dart';
import 'dart:math';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Provider Demo',
      home: MultiProvider(
        providers: [
          ChangeNotifierProvider<ColorProvider>.value(value: ColorProvider()),
        ],
        child: Scaffold(
          body: HomePage(),
        ),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  final double _width = 185;
  final double _height = 185;


  @override
  Widget build(BuildContext context) {
    ColorProvider state = Provider.of<ColorProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Provider Demo', style: TextStyle(color: state.colorValue),),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedContainer(
              width: _width,
              height: _height,
              decoration: BoxDecoration(
                color: state.colorValue,
              ),
              duration: const Duration(seconds: 1),
              curve: Curves.fastOutSlowIn,
            ),
            SizedBox(
              height: 30,
            ),
            FloatingActionButton(
              onPressed: () => state._RandomChangeColor(),
            )
          ],
        ),
      ),
    );
  }
}

class ColorProvider extends ChangeNotifier{
  Color _color = Colors.green;

  Color get colorValue => _color;



  void _RandomChangeColor() {
    _color = Color.fromRGBO(
      Random().nextInt(256),
      Random().nextInt(256),
      Random().nextInt(256),
      1,
    );
    notifyListeners();
  }

}
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_8_0/color_bloc.dart';

void main() {
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bloc with flutter_bloc',
      home: BlocProvider(
          create: (context) => ColorBloc(),
          child: const MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ColorBloc _bloc = BlocProvider.of<ColorBloc>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('BLoC with flutter_bloc'),
        centerTitle: true,
      ),
      body: Center(
        child: BlocBuilder<ColorBloc, Color>(
          builder: (context, currentColor) =>
          AnimatedContainer(
            height: 100,
            width: 100,
            color: currentColor,
            duration: Duration(milliseconds: 500),
          ),
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () {
              _bloc.add(RedColorEvent());
            },
            backgroundColor: Colors.red,
          ),
          const SizedBox(width: 10,),
          FloatingActionButton(
            onPressed: () {
              _bloc.add(GreenColorEvent());
            },
            backgroundColor: Colors.green,
          ),
        ],
      ),
    );
  }
}

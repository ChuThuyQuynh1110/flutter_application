// tăng giảm giá trị
import 'package:flutter/material.dart';

class MyObject {
  int value;
  MyObject({
    required this.value,
  });

  void increase() {
    value++;
  }

  void decrease() {
    value--;
  }

  int get getValue {
    return value;
  }

  set setValue(int newValue) {
    value = newValue;
  }
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final MyObject _myObject = MyObject(value: 10);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          leading: const Icon(Icons.person),
          title: const Text('Ứng dụng Debugging'),
          backgroundColor: Colors.pink[100], // Set a light pink color for AppBar
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Giá trị:'
                '${_myObject.getValue}',
                style: const TextStyle(fontSize: 30),
              ),
              SizedBox(height: 50),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _myObject.increase();
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Color.fromARGB(255, 184, 133, 193),
                      shape: CircleBorder(), // Make the button circular
                      minimumSize: const Size(80, 80),
                    ),
                    child: const Text(
                      'ADD',
                      style: TextStyle(fontSize: 24), // Increase the font size
                    ),
                  ),
                  SizedBox(width: 20), // Add space between buttons
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _myObject.decrease();
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Color.fromARGB(255, 216, 188, 146),
                      shape: CircleBorder(),
                      minimumSize: const Size(80, 80),
                    ),
                    child: const Text(
                      'DIS',
                      style: TextStyle(fontSize: 24),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
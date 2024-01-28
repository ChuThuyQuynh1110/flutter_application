//Calculate
import 'dart:async';

import 'package:flutter/material.dart';

void main() => runApp(Caculator_main());

class Caculator_main extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          leading: const Icon(Icons.person),
          title: const Text('Square Sum'),
          backgroundColor: Colors.pink[100],
        ),
          body: MainPage(),
      ),
      theme: ThemeData(
        primarySwatch: Colors.blue,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.pink[100],
        )
      ),
      );
  }
}

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  final calculator = SumCalculator();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              InputForm(calculator: calculator),
              SizedBox(height: 10), 
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        calculator.addToInput('+');
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Color.fromARGB(255, 184, 133, 193),
                      shape: CircleBorder(), // Make the button circular
                      minimumSize: const Size(80, 80),
                    ),
                    child: Text(
                    '+',
                    style: TextStyle(fontSize: 24),
                  ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        calculator.addToInput('-');
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Color.fromARGB(255, 184, 133, 193),
                      shape: CircleBorder(), // Make the button circular
                      minimumSize: const Size(80, 80),
                    ),
                    child: Text(
                    '-',
                    style: TextStyle(fontSize: 24),
                  ),
                                    
                  ),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        calculator.addToInput('*');
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Color.fromARGB(255, 184, 133, 193),
                      shape: CircleBorder(), // Make the button circular
                      minimumSize: const Size(80, 80),
                    ),
                  child: Text(
                    '*',
                    style: TextStyle(fontSize: 24),
                  ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        calculator.addToInput('/');
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Color.fromARGB(255, 184, 133, 193),
                      shape: CircleBorder(), // Make the button circular
                      minimumSize: const Size(80, 80),
                    ),
                    child: Text(
                    '/',
                    style: TextStyle(fontSize: 24),
                  ),
                    
                  ),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        calculator.addToInput('^2');
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Color.fromARGB(255, 184, 133, 193),
                      shape: CircleBorder(), // Make the button circular
                      minimumSize: const Size(80, 80),
                    ),
                    child: Text(
                    '^2',
                    style: TextStyle(fontSize: 24),
                  ),
                    
                  ),    
                ],
              ),
              ResultText(calculator: calculator),
            ],
          ),
        ),
      ),
    );
  }
}

class SumCalculator {

  final _controller = StreamController<double>.broadcast();
  Stream<double> get sumStream => _controller.stream;

  String _input = '';
  double ket_qua = 0;


  double calculate() {
    // Perform calculation based on the input
    // You can use a library like math_expressions to parse and evaluate the expression.
    // Here, a simple approach is taken for demonstration purposes.
    ket_qua = evalInput();
    _update();
    return ket_qua;
  }

  double evalInput() {
    // Simple evaluation based on split and check
    List<String> elements = _input.split(' ');
    double result = 0;

    if (elements.length == 3) {
      double operand1 = double.tryParse(elements[0]) ?? 0;
      double operand2 = double.tryParse(elements[2]) ?? 0;

      switch (elements[1]) {
        case '+':
          result = operand1 + operand2;
          break;
        case '-':
          result = operand1 - operand2;
          break;
        case '*':
          result = operand1 * operand2;
          break;
        case '/':
          if (operand2 != 0) {
            result = operand1 / operand2;
          } else {
            print('Error: Division by zero');
          }
          break;
        case 'SQS':
          result = (operand1 + operand2) * (operand1 + operand2);
          break;
        default:
          print('Error: Invalid operator');
      }
    }

    return result;
  }

  void addToInput(String value) {
    // Append the operator or SQS to the input
    _input += ' $value ';
    calculate(); // Calculate whenever an operator is added
  }

  set input(String newValue) {
    _input = newValue;
    calculate();
  }

  void _update() {
    _controller.sink.add(ket_qua);
  }

  dispose() {
    _controller.close();
  }
}

class InputForm extends StatelessWidget {

  final SumCalculator calculator;

  const InputForm({
    required this.calculator,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,  
      children: [
        TextFormField(
          keyboardType: TextInputType.text,
          controller: TextEditingController(text: calculator._input),
          onChanged: (value) {
            // Update the input when the user types
            calculator.input = value;
          },
          decoration: InputDecoration(
            labelText: 'Input',
          ),
        ),
        SizedBox(height: 8),
        ElevatedButton(
          onPressed: (){
            calculator.calculate();
          }, 
          child: Text('Calculate'),
        ),
      ],
    );
  }

}

class ResultText extends StatelessWidget {

  final SumCalculator calculator;

  const ResultText({required this.calculator});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: calculator.sumStream,
      builder: (context, snapshot) { 
        if (snapshot.hasData) {
          return Text(
            'Result: ${snapshot.data}',
            style: TextStyle(fontSize: 20),
          );
        } else {
          return SizedBox(); 
        }
      } 
    );
  }
}
import 'package:flutter/material.dart';
import 'package:calculator/modules/buttons.dart';
import 'package:math_expressions/math_expressions.dart';

main() {
  runApp(const Calculator());
}

class Calculator extends StatelessWidget {
  const Calculator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SimpleCalculator(),
    );
  }
}

class SimpleCalculator extends StatefulWidget {
  const SimpleCalculator({Key? key}) : super(key: key);

  @override
  _SimpleCalculatorState createState() => _SimpleCalculatorState();
}

class _SimpleCalculatorState extends State<SimpleCalculator> {
  String userInput = '';
  String userOutput = '';

  final List<String> buttons = [
    'C',
    'DEL',
    '%',
    '/',
    '7',
    '8',
    '9',
    'x',
    '4',
    '5',
    '6',
    '-',
    '1',
    '2',
    '3',
    '+',
    '0',
    '.',
    'ANS',
    '=',
  ];

  bool isOperator(String op) {
    switch (op) {
      case '%':
        return true;
      case '/':
        return true;
      case 'x':
        return true;
      case '-':
        return true;
      case '+':
        return true;
      case '=':
        return true;
      default:
        return false;
    }
  }

  void evaluateFunc() {
    String finalInput = userInput;
    finalInput.replaceAll('x', '*');
    Parser p = Parser();
    Expression exp = p.parse(finalInput);
    ContextModel cm = ContextModel();
    double eval = exp.evaluate(EvaluationType.REAL, cm);
    userOutput = eval.toString();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
     child: Scaffold(
        backgroundColor: Colors.deepPurple[100],
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.all(20),
                    child: Text(
                      userInput,
                      style: TextStyle(fontSize: 30, color: Colors.deepPurple[900]),
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.all(20),
                    child: Text(
                      userOutput,
                      style: const TextStyle(fontSize: 30, color: Colors.purple),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: Center(
                child: GridView.builder(
                  itemCount: buttons.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4),
                  itemBuilder: (BuildContext context, int index) {
                    /// DEL BTN
                    if (index == 0) {
                      return MyButtons(
                          buttonTapped: () {
                            setState(() {
                              userInput = '';
                              userOutput = '';
                            });
                          },
                          buttonColor: Colors.green,
                          textColor: Colors.white,
                          buttonText: buttons[index]);
                    }

                    /// Clear BTN
                    if (index == 1) {
                      return MyButtons(
                          buttonTapped: () {
                            setState(() {
                              userInput =
                                  userInput.substring(0, userInput.length - 1);
                              userOutput = '';
                            });
                          },
                          buttonColor: Colors.red,
                          textColor: Colors.white,
                          buttonText: buttons[index]);
                    }

                    /// Equal BTN
                    if (index == buttons.length - 1) {
                      return MyButtons(
                          buttonTapped: () {
                            setState(() {
                              evaluateFunc();
                            });
                          },
                          buttonColor: Colors.purple,
                          textColor: Colors.white,
                          buttonText: buttons[index]);
                    } else {
                      return MyButtons(
                          buttonTapped: () {
                            setState(() {
                              userInput += buttons[index];
                            });
                          },
                          buttonColor: isOperator(buttons[index])
                              ? Colors.purple
                              : Colors.deepPurple[50],
                          textColor: isOperator(buttons[index])
                              ? Colors.white
                              : Colors.deepPurple,
                          buttonText: buttons[index]);
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}

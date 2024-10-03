import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
import 'buttons.dart';

class Calculator extends StatefulWidget {
  const Calculator({super.key});

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  var userInput = '';
  var answer = '';

// Array of button
  final List<String> buttons = [
    '+',
    '7',
    '8',
    '9',
    '/',
    '4',
    '5',
    '6',
    'x',
    '1',
    '2',
    '3',
    '-',
    'C',
    '0',
    '=',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Calculator"),
      ), //AppBar
      backgroundColor: const Color.fromARGB(97, 0, 0, 0),
      body: Column(
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Container(
                padding: const EdgeInsets.all(20),
                alignment: Alignment.centerRight,
                height: 220,
                child: Text(
                  answer,
                  style: const TextStyle(fontSize: 70, color: Colors.pink),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(15),
                alignment: Alignment.centerRight,
                child: Text(
                  userInput,
                  style: const TextStyle(
                      fontSize: 50,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              )
            ],
          ),
          Expanded(
            // flex: 2,
            child: Container(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: GridView.builder(
                    itemCount: buttons.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 4),
                    itemBuilder: (BuildContext context, int index) {
                      // Clear Button
                      if (index == 13) {
                        return MyButton(
                          buttontapped: () {
                            setState(() {
                              userInput = '';
                              answer = '0';
                            });
                          },
                          buttonText: buttons[index],
                          color: Color.fromARGB(255, 255, 255, 255),
                          textColor: Colors.black,
                        );
                      }
                      // Equal_to Button
                      else if (index == 15) {
                        return MyButton(
                          buttontapped: () {
                            setState(() {
                              equalPressed();
                            });
                          },
                          buttonText: buttons[index],
                          color: Colors.purple[700],
                          textColor: Colors.white,
                        );
                      }

                      // other buttons
                      else {
                        return MyButton(
                          buttontapped: () {
                            setState(() {
                              userInput += buttons[index];
                            });
                          },
                          buttonText: buttons[index],
                          color: isOperator(buttons[index])
                              ? Color.fromARGB(255, 69, 32, 0)
                              : Color.fromARGB(255, 159, 156, 156),
                          textColor: isOperator(buttons[index])
                              ? const Color.fromARGB(255, 7, 253, 146)
                              : const Color.fromARGB(255, 241, 96, 6),
                        );
                      }
                    }),
              ), // GridView.builder
            ),
          ),
        ],
      ),
    );
  }

  bool isOperator(String x) {
    if (x == '/' || x == 'x' || x == '-' || x == '+' || x == '=') {
      return true;
    }
    return false;
  }

  // function to calculate the input operation
  void equalPressed() {
    String finaluserinput = userInput;
    finaluserinput = userInput.replaceAll('x', '*');

    Parser p = Parser();
    Expression exp = p.parse(finaluserinput);
    ContextModel cm = ContextModel();
    double eval = exp.evaluate(EvaluationType.REAL, cm);
    answer = eval.toString();
  }
}

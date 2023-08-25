import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:math_expressions/math_expressions.dart';

class Calculator extends StatefulWidget {
  const Calculator({super.key});

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String userinput = "";
  String result = "0";
  List<String> buttonList = [
    'AC',
    '(',
    ')',
    '/',
    '7',
    '8',
    '9',
    '*',
    '4',
    '5',
    '6',
    '+',
    '1',
    '2',
    '3',
    '-',
    'C',
    '0',
    '.',
    '=',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 51, 51, 51),
      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height / 3,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  padding: EdgeInsets.all(20),
                  alignment: Alignment.centerRight,
                  child: Text(
                    userinput,
                    style: const TextStyle(
                      fontSize: 32,
                      color: Colors.white,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(20),
                  alignment: Alignment.centerRight,
                  child: Text(
                    result,
                    style: TextStyle(
                        fontSize: 48,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
          ),
          Divider(color: Colors.white),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(20),
              child: GridView.builder(
                itemCount: buttonList.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    crossAxisSpacing: 21,
                    mainAxisSpacing: 12),
                itemBuilder: (BuildContext context, int index) {
                  return Custombutton(buttonList[index]);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget Custombutton(String text) {
    return InkWell(
      splashColor: const Color.fromARGB(255, 39, 37, 37),
      onTap: () {
        setState(() {
          handlebuttons(text);
        });
      },
      child: Ink(
        decoration: BoxDecoration(
          color: getbgcolor(text),
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.white.withOpacity(0.1),
              blurRadius: 4,
              spreadRadius: 0.5,
              offset: Offset(-3, -3),
            )
          ],
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
                color: getcolor(text),
                fontSize: 30,
                fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  getcolor(String text) {
    if (text == "/" ||
        text == "-" ||
        text == "(" ||
        text == ")" ||
        text == "+" ||
        text == "*" ||
        text == "C") {
      return Color.fromARGB(255, 252, 100, 100);
    }
    return Colors.white;
  }

  getbgcolor(String text) {
    if (text == "AC") {
      return Color.fromARGB(255, 252, 100, 100);
    }
    if (text == "=") {
      return Color.fromARGB(255, 104, 204, 159);
    }
    return const Color.fromARGB(255, 49, 49, 49);
  }

  handlebuttons(String text) {
    if (text == "AC") {
      userinput = "";
      result = "0";
      return;
    }
    if (text == "C") {
      if (userinput.isNotEmpty) {
        userinput = userinput.substring(0, userinput.length - 1);
        return;
      } else {
        return null;
      }
    }
    if (text == "=") {
      result = calculate();
      //userinput = result;
      // if (userinput.endsWith("=")) {
      //   userinput = userinput.substring(0, userinput.length - 1);
      // }

      if (userinput.endsWith(".0")) {
        userinput = userinput.replaceAll(".0", "");
      }

      if (result.endsWith(".0")) {
        result = result.replaceAll(".0", "");
        // return;
      }
      userinput =
          userinput.replaceAll("=", ""); // Remove "=" sign from userinput
    } else {
      userinput = userinput + text;
    }
    // }
    // userinput = userinput + text;
  }

  String calculate() {
    try {
      var exp = Parser().parse(userinput);
      var evaluation = exp.evaluate(EvaluationType.REAL, ContextModel());
      return evaluation.toString();
    } catch (e) {
      return "Error";
    }
  }
}

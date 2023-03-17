import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:provider/provider.dart';

class Calculator extends StatefulWidget {
  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String equation = "0";
  String result = "0";
  String expression = "";
  double equationFontSize = 38.0;
  double resultFontSize = 48.0;

  buttonPressed(String buttonText) {
    setState(() {
      if (buttonText == "C") {
        equation = "0";
        result = "0";
        equationFontSize = 38.0;
        resultFontSize = 48.0;
      } else if (buttonText == "⌫") {
        equationFontSize = 48.0;
        resultFontSize = 38.0;
        equation = equation.substring(0, equation.length - 1);
        if (equation == "") {
          equation = "0";
        }
      } else if (buttonText == "=") {
        equationFontSize = 38.0;
        resultFontSize = 48.0;

        expression = equation;
        expression = expression.replaceAll('×', '*');
        expression = expression.replaceAll('÷', '/');

        try {
          Parser p = Parser();
          Expression exp = p.parse(expression);

          ContextModel cm = ContextModel();
          result = '${exp.evaluate(EvaluationType.REAL, cm)}';
        } catch (e) {
          result = "Error";
        }
      } else {
        equationFontSize = 48.0;
        resultFontSize = 38.0;
        if (equation == "0") {
          equation = buttonText;
        } else {
          equation = equation + buttonText;
        }
      }
    });
  }

  Widget buildButton(
      String buttonText, double buttonHeight, Color buttonColor) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.133 * buttonHeight,
      color: _SwitchValue ? buttonColor : Color.fromARGB(255, 10, 57, 83),
      child: MaterialButton(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(0.0),
              side: BorderSide(
                  color: Colors.white, width: 1, style: BorderStyle.solid)),
          padding: EdgeInsets.all(16.0),
          onPressed: () => buttonPressed(buttonText),
          child: Text(
            buttonText,
            style: TextStyle(
              fontSize: 30.0,
              fontWeight: FontWeight.normal,
              color: _SwitchValue ? Colors.black : Colors.white,
            ),
          )),
    );
  }

  bool _SwitchValue = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          _SwitchValue ? Colors.white : Color.fromARGB(255, 10, 57, 83),
      appBar: AppBar(
        backgroundColor:
            _SwitchValue ? Colors.white : Color.fromARGB(255, 10, 57, 83),
        elevation: 0,
        title: Text(
          'Calculator',
          style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: _SwitchValue ? Colors.black : Colors.white),
        ),
        leading: Icon(
          Icons.menu,
          color: _SwitchValue ? Colors.black : Colors.white,
        ),
        actions: <Widget>[
          Switch(
              activeColor: Color.fromARGB(255, 4, 50, 73),
              value: _SwitchValue,
              onChanged: (newValue) {
                setState(() {
                  _SwitchValue = newValue;
                });
              })
        ],
      ),
      body: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
            child: Text(
              equation,
              style: TextStyle(
                fontSize: equationFontSize,
                color: _SwitchValue ? Colors.black : Colors.white,
              ),
            ),
          ),
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.fromLTRB(10, 30, 10, 0),
            child: Text(
              result,
              style: TextStyle(
                fontSize: resultFontSize,
                color: _SwitchValue ? Colors.black : Colors.white,
              ),
            ),
          ),
          Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width * .75,
                child: Table(
                  children: [
                    TableRow(children: [
                      buildButton("C", 1, Colors.red),
                      buildButton("⌫", 1, Colors.teal),
                      buildButton("÷", 1, Colors.teal),
                    ]),
                    TableRow(children: [
                      buildButton("7", 1, Colors.black54),
                      buildButton("8", 1, Colors.black54),
                      buildButton("9", 1, Colors.black54),
                    ]),
                    TableRow(children: [
                      buildButton("4", 1, Colors.black54),
                      buildButton("5", 1, Colors.black54),
                      buildButton("6", 1, Colors.black54),
                    ]),
                    TableRow(children: [
                      buildButton("1", 1, Colors.black54),
                      buildButton("2", 1, Colors.black54),
                      buildButton("3", 1, Colors.black54),
                    ]),
                    TableRow(children: [
                      buildButton(".", 1, Colors.black54),
                      buildButton("0", 1, Colors.black54),
                      buildButton("00", 1, Colors.black54),
                    ]),
                  ],
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.25,
                child: Table(
                  children: [
                    TableRow(children: [
                      buildButton("×", 1, Colors.teal),
                    ]),
                    TableRow(children: [
                      buildButton("-", 1, Colors.teal),
                    ]),
                    TableRow(children: [
                      buildButton("+", 1, Colors.teal),
                    ]),
                    TableRow(children: [
                      buildButton("=", 2, Colors.red),
                    ]),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}

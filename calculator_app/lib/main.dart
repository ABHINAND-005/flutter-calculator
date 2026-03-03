import 'package:flutter/material.dart';

void main() {
  runApp(const CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  const CalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calculator',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const CalculatorScreen(),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String _output = "0";
  String _currentInput = "";
  double _num1 = 0;
  double _num2 = 0;
  String _operand = "";

  void _buttonPressed(String buttonText) {
    if (buttonText == "C") {
      _currentInput = "";
      _num1 = 0;
      _num2 = 0;
      _operand = "";
      _output = "0";
    } else if (buttonText == "+" || buttonText == "-" || buttonText == "/" || buttonText == "X") {
      _num1 = double.tryParse(_output) ?? 0.0;
      _operand = buttonText;
      _currentInput = "";
    } else if (buttonText == "=") {
      _num2 = double.tryParse(_output) ?? 0.0;

      if (_operand == "+") {
        _output = (_num1 + _num2).toString();
      } else if (_operand == "-") {
        _output = (_num1 - _num2).toString();
      } else if (_operand == "X") {
        _output = (_num1 * _num2).toString();
      } else if (_operand == "/") {
        if (_num2 != 0) {
          _output = (_num1 / _num2).toString();
        } else {
          _output = "Error";
        }
      }

      _num1 = 0;
      _num2 = 0;
      _operand = "";
      _currentInput = _output == "Error" ? "" : _output;
    } else {
      if (_currentInput == "0" && buttonText != ".") {
        _currentInput = buttonText;
      } else {
        _currentInput += buttonText;
      }
      _output = _currentInput;
    }

    setState(() {
      // Formatting to remove decimal if it's a whole number
      if (_output.endsWith(".0")) {
        _output = _output.substring(0, _output.length - 2);
      }
    });
  }

  Widget _buildButton(String buttonText, {Color? color, Color? textColor}) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.all(24.0),
            backgroundColor: color ?? Colors.grey[200],
            foregroundColor: textColor ?? Colors.black,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0),
            ),
          ),
          onPressed: () => _buttonPressed(buttonText),
          child: Text(
            buttonText,
            style: const TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Calculator'),
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              alignment: Alignment.bottomRight,
              padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 24.0),
              child: Text(
                _output,
                style: const TextStyle(fontSize: 64.0, fontWeight: FontWeight.bold),
                maxLines: 1,
              ),
            ),
          ),
          const Divider(height: 1),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  children: [
                    _buildButton("7"),
                    _buildButton("8"),
                    _buildButton("9"),
                    _buildButton("/", color: Colors.blueAccent, textColor: Colors.white),
                  ],
                ),
                Row(
                  children: [
                    _buildButton("4"),
                    _buildButton("5"),
                    _buildButton("6"),
                    _buildButton("X", color: Colors.blueAccent, textColor: Colors.white),
                  ],
                ),
                Row(
                  children: [
                    _buildButton("1"),
                    _buildButton("2"),
                    _buildButton("3"),
                    _buildButton("-", color: Colors.blueAccent, textColor: Colors.white),
                  ],
                ),
                Row(
                  children: [
                    _buildButton("."),
                    _buildButton("0"),
                    _buildButton("C", color: Colors.redAccent, textColor: Colors.white),
                    _buildButton("+", color: Colors.blueAccent, textColor: Colors.white),
                  ],
                ),
                Row(
                  children: [
                    _buildButton("=", color: Colors.green, textColor: Colors.white),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

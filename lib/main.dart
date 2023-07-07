import 'package:flutter/material.dart';

void main() {
  runApp(CalculadoraApp());
}

class CalculadoraApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calculadora',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Calculadora(),
    );
  }
}

class Calculadora extends StatefulWidget {
  @override
  _CalculadoraState createState() => _CalculadoraState();
}

class _CalculadoraState extends State<Calculadora> {
  String _output = '0';
  double _num1 = 0;
  double _num2 = 0;
  String _operator = '';
  bool _isOperatorClicked = false;

  void _onNumberClick(String number) {
    setState(() {
      if (_isOperatorClicked) {
        _output = number;
        _isOperatorClicked = false;
      } else {
        _output = _output != '0' ? _output + number : number;
      }
    });
  }

  void _onOperatorClick(String operator) {
    setState(() {
      if (operator == '=') {
        _calculateResult();
      } else {
        _num1 = double.parse(_output);
        _operator = operator;
        _output = '0';
        _isOperatorClicked = true;
      }
    });
  }

  void _calculateResult() {
    setState(() {
      _num2 = double.parse(_output);
      switch (_operator) {
        case '+':
          _output = (_num1 + _num2).toString();
          break;
        case '-':
          _output = (_num1 - _num2).toString();
          break;
        case '*':
          _output = (_num1 * _num2).toString();
          break;
        case '/':
          _output = (_num1 / _num2).toString();
          break;
      }
      _num1 = 0;
      _num2 = 0;
      _operator = '';
    });
  }

  void _clearOutput() {
    setState(() {
      _output = '0';
      _num1 = 0;
      _num2 = 0;
      _operator = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculadora'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              padding: EdgeInsets.all(16.0),
              alignment: Alignment.bottomRight,
              child: Text(
                _output,
                style: TextStyle(fontSize: 48.0),
              ),
            ),
          ),
          Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              _buildButton('7'),
              _buildButton('8'),
              _buildButton('9'),
              _buildOperatorButton('/'),
            ],
          ),
          SizedBox(height: 8.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              _buildButton('4'),
              _buildButton('5'),
              _buildButton('6'),
              _buildOperatorButton('*'),
            ],
          ),
          SizedBox(height: 8.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              _buildButton('1'),
              _buildButton('2'),
              _buildButton('3'),
              _buildOperatorButton('-'),
            ],
          ),
          SizedBox(height: 8.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              _buildButton('0'),
              _buildButton('.'),
              _buildOperatorButton('='),
              _buildOperatorButton('+'),
            ],
          ),
          SizedBox(height: 16.0),
          ElevatedButton(
            child: Text('Limpar'),
            onPressed: _clearOutput,
          ),
          SizedBox(height: 10,)
        ],
      ),
    );
  }

  Widget _buildButton(String text) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.all(4.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: Colors.white,
            onPrimary: Colors.blue,
            padding: EdgeInsets.all(16.0),
            textStyle: TextStyle(fontSize: 24.0),
          ),
          child: Text(text),
          onPressed: () {
            if (text == '.' && _output.contains('.')) {
              return;
            }
            if (text == '0' && _output == '0') {
              return;
            }
            if (text == '0' && _output == '0.0') {
              return;
            }
            if (text == '0' && _output == '-0.0') {
              return;
            }
            if (text == '=' && (_output == '0' || _output == '0.0')) {
              return;
            }
            if (text == '=' && _operator.isEmpty) {
              return;
            }
            if (text == '=' && _isOperatorClicked) {
              return;
            }
            if (text == '0' && _output == '-') {
              return;
            }
            if (text == '0' && _output == '-.') {
              return;
            }
            if (text == '+' ||
                text == '-' ||
                text == '*' ||
                text == '/' ||
                text == '=') {
              _onOperatorClick(text);
            } else {
              _onNumberClick(text);
            }
          },
        ),
      ),
    );
  }

  Widget _buildOperatorButton(String text) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.all(4.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: Colors.blue,
            onPrimary: Colors.white,
            padding: EdgeInsets.all(14.0),
            textStyle: TextStyle(fontSize: 24.0),
          ),
          child: Text(text),
          onPressed: () {
            if (_output.endsWith('.') || _output.endsWith('-')) {
              return;
            }
            _onOperatorClick(text);
          },
        ),
      ),
    );
  }
}

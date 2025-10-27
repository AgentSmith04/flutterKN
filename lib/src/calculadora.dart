import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class CalculadoraPage extends StatefulWidget {
  const CalculadoraPage({super.key});

  @override
  State<CalculadoraPage> createState() => _CalculadoraPageState();
}

class _CalculadoraPageState extends State<CalculadoraPage> {
  String _input = '';
  String _result = '';

  void _append(String value) {
    setState(() => _input += value);
  }

  void _clear() {
    setState(() {
      _input = '';
      _result = '';
    });
  }

  void _calculate() {
    if (_input.isEmpty) return;
    try {
      final expr = _input.replaceAll('×', '*').replaceAll('÷', '/');
      Parser p = Parser();
      Expression exp = p.parse(expr);
      double res = exp.evaluate(EvaluationType.REAL, ContextModel());
      setState(() => _result = res.toString());
    } catch (e) {
      setState(() => _result = 'Error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Calculadora"),
        backgroundColor: const Color(0xFF002C72),
      ),
      body: Center(
        child: Container(
          width: 350,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(25),
            boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 10, spreadRadius: 5)],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                alignment: Alignment.centerRight,
                decoration: BoxDecoration(color: const Color(0xFFEFEFEF), borderRadius: BorderRadius.circular(15)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(_input, style: const TextStyle(fontSize: 24, color: Colors.black54)),
                    const SizedBox(height: 10),
                    Text(_result, style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              _buildButtonRow(['7', '8', '9', '÷']),
              _buildButtonRow(['4', '5', '6', '×']),
              _buildButtonRow(['1', '2', '3', '-']),
              _buildButtonRow(['C', '0', '=', '+']),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildButtonRow(List<String> buttons) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: buttons.map((btn) {
          return ElevatedButton(
            onPressed: () {
              if (btn == 'C') {
                _clear();
              } else if (btn == '=') {
                _calculate();
              } else {
                _append(btn);
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: btn == 'C'
                  ? Colors.redAccent
                  : btn == '='
                      ? const Color(0xFF002C72)
                      : Colors.grey[200],
              foregroundColor: btn == '=' || btn == 'C' ? Colors.white : Colors.black,
              minimumSize: const Size(65, 60),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            ),
            child: Text(btn, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          );
        }).toList(),
      ),
    );
  }
}

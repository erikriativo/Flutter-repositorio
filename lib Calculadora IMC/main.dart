import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    home: Home(),
    debugShowCheckedModeBanner: false,
    
  ));
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Calculadora IMC'),
          centerTitle: true,
          backgroundColor: Colors.green,
          actions: [
            IconButton(
              onPressed: _resetFields,
              icon: const Icon(Icons.refresh),
            )
          ],
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(10.0),
          child: Form(
            key: _formkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Icon(
                  Icons.person_outlined,
                  size: 120,
                  color: Colors.green,
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Peso (kg)',
                    labelStyle: TextStyle(color: Colors.green),
                  ),
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.green),
                  controller: weightController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Insira seu peso';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Altura (cm)',
                    labelStyle: TextStyle(color: Colors.green),
                  ),
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.green),
                  controller: heightController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Insira sua altura';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 50.0,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0, bottom: 15.0),
                  child: TextButton(
                    onPressed: () {
                      if (_formkey.currentState!.validate()) {
                        calculate();
                      }
                    },
                    child: const Text(
                      'Calcular',
                      style: TextStyle(
                        color: Colors.green,
                        fontSize: 24,
                      ),
                    ),
                  ),
                ),
                Text(infoText,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.greenAccent,
                      fontSize: 20,
                    ))
              ],
            ),
          ),
        ));
  }

  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  String infoText = "Informe seus dados!";

  void _resetFields() {
    weightController.text = "";
    heightController.text = "";
    infoText = "";
    _formkey = GlobalKey<FormState>();
  }

  void calculate() {
    setState(() {
      double weight = double.parse(weightController.text);
      double height = double.parse(heightController.text) / 100;
      double imc = weight / (height * height);
      if (imc < 18.6) {
        infoText = "Abaixo do peso (${imc.toStringAsPrecision(3)})";
      } else if (imc >= 18.6 && imc < 24.9) {
        infoText = 'Peso ideal (${imc.toStringAsPrecision(3)})';
      } else if (imc >= 24.9 && imc < 29.9) {
        infoText = 'Sobrepeso (${imc.toStringAsPrecision(3)})';
      } else if (imc >= 29.9 && imc < 34.9) {
        infoText = 'Obesidade grau I (${imc.toStringAsPrecision(3)})';
      } else if (imc >= 34.9 && imc < 39.9) {
        infoText = 'Obesidade grau II (${imc.toStringAsPrecision(3)})';
      } else if (imc >= 40) {
        infoText = 'Obesidade grau III (${imc.toStringAsPrecision(3)})';
      }
    });
  }
}

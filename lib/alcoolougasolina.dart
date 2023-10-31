
import 'package:flutter/material.dart';

class AlcoolOuGasolina extends StatefulWidget {
  const AlcoolOuGasolina({super.key});

  @override
  State<AlcoolOuGasolina> createState() => _AlcoolOuGasolinaState();
}

class _AlcoolOuGasolinaState extends State<AlcoolOuGasolina> {
  final TextEditingController _alcoolController = TextEditingController();
  final TextEditingController _gasolinaController = TextEditingController();
  String _menssagem = "Resultado";

  calcular() {
    double precoAlcool = double.parse(_alcoolController.text);
    double precoGasolina = double.parse(_gasolinaController.text);
    // ignore: unnecessary_null_comparison
    if (precoAlcool == null || precoGasolina == null) {
      _menssagem = "Verifique se está utilizado '.' e não ',' ou insira dados válidos";
    } else if (precoAlcool / precoGasolina >= 0.7) {
      setState(() {
        _menssagem = "Melhor opção é Gasolina";
      });
    } else {
      _menssagem = "Melhor opção é Alcool";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Alcool Ou Gasolina"),
        backgroundColor: const Color.fromARGB(255, 20, 4, 158),
        foregroundColor: Colors.white,
      ),
      body: Center(
          child: SingleChildScrollView(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.asset(
              "images/alcoolougasolina/logo.png",
            ),
            const Padding(
              padding: EdgeInsets.only(top: 20, bottom: 10),
              child: Text(
                "Saiba qual a melhor opção para o abastecimento do seu veículo",
                style: TextStyle(
                    fontSize: 24,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.bold,
                    color: Colors.black54),
              ),
            ),
            TextField(
              controller: _alcoolController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Preço do Álcool.:Ex 3.30",
              ),
            ),
            TextField(
              controller: _gasolinaController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Preço da Gasolian.:Ex 4.20",
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20, bottom: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      calcular();
                    },
                    style: ButtonStyle(
                        shape: const MaterialStatePropertyAll(
                            RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(6)))),
                        overlayColor:
                            MaterialStateProperty.resolveWith((states) {
                          if (states.contains(MaterialState.focused)) {
                            return Colors.green;
                          }
                          if (states.contains(MaterialState.hovered)) {
                            return Colors.green;
                          }
                          return null;
                        }),
                        backgroundColor: MaterialStateColor.resolveWith(
                            (states) => Colors.blueGrey.shade200)),
                    child: const Text("Calcular",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        )),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  _menssagem,
                  style: const TextStyle(
                      fontSize: 19, fontWeight: FontWeight.bold),
                )
              ],
            )
          ],
        ),
      )),
    );
  }
}

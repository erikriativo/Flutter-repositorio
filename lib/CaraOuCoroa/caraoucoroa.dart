import 'dart:math';

import 'package:epraja/CaraOuCoroa/resultado.dart';
import 'package:flutter/material.dart';

class CaraOuCoroa extends StatefulWidget {
  const CaraOuCoroa({super.key});

  @override
  State<CaraOuCoroa> createState() => _CaraOuCoroaState();
}

class _CaraOuCoroaState extends State<CaraOuCoroa> {
  String? imageLance;
  int numeroRandom = 0;
  List<String> lances = ["cara", "coroa"];

  imageJogar() {
    numeroRandom = Random().nextInt(2);
    var resultado = lances[numeroRandom];

    Navigator.push(
        context,
        MaterialPageRoute(
            builder: ((context) => Resultado(resultado))));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff61bd86),
      appBar: AppBar(
        backgroundColor: const Color(0xff61bd86),
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Image.asset("assets/images/caraOucoroa/logo.png"),
              GestureDetector(
                child: Image.asset("assets/images/caraOucoroa/botao_jogar.png"),
                onTap: () {
                  imageJogar();
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

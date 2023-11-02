import 'dart:math';

import 'package:epraja/CaraOuCoroa/resultado.dart';
import 'package:flutter/material.dart';

class CaraOuCoroa extends StatefulWidget {
  const CaraOuCoroa({super.key});

  @override
  State<CaraOuCoroa> createState() => _CaraOuCoroaState();
}

class _CaraOuCoroaState extends State<CaraOuCoroa> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 67, 224, 161),
      appBar: AppBar(
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
                  var randomInt = Random().nextInt(2);
                  Navigator.push(context,
                      MaterialPageRoute(builder: ((context) => Resultado(valor: randomInt,))));
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

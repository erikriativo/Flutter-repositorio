import 'package:epraja/CaraOuCoroa/caraoucoroa.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Resultado extends StatefulWidget {
  Resultado({required this.valor, super.key});
  int valor;

  @override
  State<Resultado> createState() => _ResultadoState();
}

class _ResultadoState extends State<Resultado> {
  String _imageSet = "assets/images/caraOucoroa/moeda_cara.png";
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      backgroundColor: Color.fromARGB(156, 102, 255, 135),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Image.asset(_imageSet),
              GestureDetector(
                child: Image.asset("assets/images/caraOucoroa/botao_voltar.png"),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: ((context) => const CaraOuCoroa())));
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

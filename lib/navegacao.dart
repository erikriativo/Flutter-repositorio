import 'package:epraja/Navegacao%20Praticas/sala1.dart';
import 'package:flutter/material.dart';

class Navegacao extends StatefulWidget {
  const Navegacao({super.key});

  @override
  State<Navegacao> createState() => _NavegacaoState();
}

class _NavegacaoState extends State<Navegacao> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Saguão"),
        backgroundColor: Colors.amber,
      ),
      backgroundColor: Colors.amber.shade400,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset("assets/images/building-8320842_1280.png",fit: BoxFit.fitWidth,height: 500),
            const SizedBox(
              height: 50,
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) =>  Sala01(10)));
                },
                child: const Text("Ir para Sala 01")),
             ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, "/");
                },
                child: const Text("Voltar à tela Inicial"))
          ],
        ),
      ),
    );
  }
}

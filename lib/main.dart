import 'dart:math';

import 'package:epraja/alcoolougasolina.dart';
import 'package:epraja/jokenpo.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
      title: "Frases do dia",
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/' : (context) => const HomeStateful(),
        '/jokenpo' : (context) => const JokenPoPage(),
        '/alcoolougasolina' : (context) => const AlcoolOuGasolina()
        },
      ));
}

class HomeStateful extends StatefulWidget {
  const HomeStateful({super.key});

  @override
  State<HomeStateful> createState() => _HomeStatefulState();
}

class _HomeStatefulState extends State<HomeStateful> {
  List listaFrases = [
    "O presente deverá sempre ser o seu guia",
    "O futuro apenas precede o passado presente",
    "A vida e a morte são a mesma coisa, a morte contempla vida e a vida contempla a morte",
    "Tudo que está em cima é exatamente como oque está em baixo e o que está em baixo é exatamente oque está em cima",
  ];
  var fraseGerada = "Clique aqui para gerar uma frase motivacional";
  int randomNumeroLista = 0;
  void gerarFrase() {
    var numeroRandom = Random().nextInt(listaFrases.length);
    setState(() {
      fraseGerada = listaFrases[numeroRandom];
    });
  }

  @override
  Widget build(BuildContext context) {
    print(listaFrases[0]);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Frases do Dia"),
        backgroundColor: Colors.amber,
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(15),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                "images/logo.png",
                fit: BoxFit.scaleDown,
              ),
              Text(
                fraseGerada,
                style:
                    const TextStyle(fontStyle: FontStyle.italic, fontSize: 18),
              ),
              ElevatedButton(
                  onPressed: gerarFrase,
                  child: const Text(
                    "Nova Frase",
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  )),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, "/jokenpo");
                      },
                      child: const Text("Ir para Joken Pô")),
                    
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, "/alcoolougasolina");
                      },
                      child: const Text("Ir para Entrada de dados")),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Frases do Dia"),
        backgroundColor: Colors.blueAccent,
      ),
      body: const Padding(
        padding: EdgeInsets.all(16),
        child: Text("Área de Conteúdo"),
      ),
      bottomNavigationBar: const BottomAppBar(
        color: Colors.blueGrey,
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Row(children: [Text("Rodapé")]),
        ),
      ),
    );
  }
}

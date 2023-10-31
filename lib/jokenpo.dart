import 'package:flutter/material.dart';
import 'dart:math';

class JokenPoPage extends StatefulWidget {
  const JokenPoPage({super.key});

  @override
  State<JokenPoPage> createState() => _JokenPoPageState();
}

class _JokenPoPageState extends State<JokenPoPage> {
  var _imageAsset = const AssetImage("images/jokenpo/padrao.png");
  String _menssagem = "Aguardando Rodada, Faça sua escolha!";
  int wins = 0;
  int lose = 0;
  int empate = 0;

  opcaoSelecionada(String escolhaDoUsuario) {
    var opcoes = ["pedra", "papel", "tesoura"];
    var numeroAleatoria = Random().nextInt(3);
    var escolhaDoApp = opcoes[numeroAleatoria];

    print("Escolha do Usuarioa $escolhaDoUsuario");
    print("Escolha do app: $escolhaDoApp");

    if ((escolhaDoUsuario == "pedra" && escolhaDoApp == "tesoura")||
    (escolhaDoUsuario == "papel" && escolhaDoApp == "pedra")||
    (escolhaDoUsuario == "tesoura" && escolhaDoApp == "papel")) 
       {
      setState(() {
        _menssagem = "Você ganhou!";
        wins++;
      });
    } else if (escolhaDoUsuario == escolhaDoApp) {
      setState(() {
        _menssagem = "Empatou!";
        empate++;
      });
    } else {
      setState(() {
        _menssagem = "Você Perdeu!";
        lose++;
      });
    }

    switch (escolhaDoApp) {
      case "pedra":
        setState(() {
          _imageAsset = const AssetImage("images/jokenpo/pedra.png");
        });
        break;
      case "papel":
        setState(() {
          _imageAsset = const AssetImage("images/jokenpo/papel.png");
        });
        break;
      case "tesoura":
        setState(() {
          _imageAsset = const AssetImage("images/jokenpo/tesoura.png");
        });
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Joken Pô"),
        backgroundColor: Colors.blueAccent,
      ),
      body: Center(
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(16),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            const Padding(
              padding: EdgeInsets.all(12.0),
              child: Text("Escolha do app:",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 19)),
            ),
            Image(image: _imageAsset),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Text(_menssagem),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () {
                    opcaoSelecionada("pedra");
                  },
                  child: Image.asset("images/jokenpo/pedra.png"),
                ),
                GestureDetector(
                  onTap: () {
                    opcaoSelecionada("papel");
                  },
                  child: Image.asset("images/jokenpo/papel.png"),
                ),
                GestureDetector(
                  onTap: () {
                    opcaoSelecionada("tesoura");
                  },
                  child: Image.asset("images/jokenpo/tesoura.png"),
                ),
                /*
                Image.asset(
                  "images/jokenpo/papel.png",
                  height: 100,
                ),
                Image.asset(
                  "images/jokenpo/pedra.png",
                  height: 100,
                ),
                Image.asset(
                  "images/jokenpo/tesoura.png",
                  height: 100,
                ),
                */
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 32,bottom: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Text("Ganhou",
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: Colors.greenAccent
                      ),),
                      Text("$wins",
                      style: const TextStyle(
                        fontSize: 34,
                        fontWeight: FontWeight.bold,
                        color: Colors.greenAccent
                      ),)
                    ],
                  ),
                  Column(
                    children: [
                      const Text("Empate",
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: Colors.amber
                      ),),
                      Text("$empate",
                      style: const TextStyle(
                        fontSize: 34,
                        fontWeight: FontWeight.bold,
                        color: Colors.amber
                      ),)
                    ],
                  ),Column(
                    children: [
                      const Text("Perdeu",
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: Colors.red
                      ),),
                      Text("$lose",
                      style: const TextStyle(
                        fontSize: 34,
                        fontWeight: FontWeight.bold,
                        color: Colors.redAccent
                      ),)
                    ],
                  )
                ],
              ),
            )
          ]),
        ),
      ),
    );
  }
}

import 'dart:math';

import 'package:epraja/ATMConsultoria/HomeATM.dart';
import 'package:epraja/CaraOuCoroa/caraoucoroa.dart';
import 'package:epraja/alcoolougasolina.dart';
import 'package:epraja/checkbox.dart';
import 'package:epraja/jokenpo.dart';
import 'package:epraja/navegacao.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    title: "Frases do dia",
    debugShowCheckedModeBanner: false,
    initialRoute: '/',
    routes: {
      '/': (context) => const HomeStateful(),
      '/jokenpo': (context) => const JokenPoPage(),
      '/alcoolougasolina': (context) => const AlcoolOuGasolina(),
      '/checkbox': (context) => const CheckBox(),
      '/navegacao': (context) => const Navegacao(),
      '/ATMconsultoria': (context) => const HomepageATM(),
      '/caraoucoroa': (context) => const CaraOuCoroa()
    },
  ));
}
//Tela inicial "Frases do dia", nesta tela poderá navegar para outras páginas com exemplos de uso de
//diversos widgets e classes, gerenciamento de estado, navegação, botões, e muito mais.

class HomeStateful extends StatefulWidget {
  const HomeStateful({super.key});

  @override
  State<HomeStateful> createState() => _HomeStatefulState();
}

class _HomeStatefulState extends State<HomeStateful> {
  List listaFrases = [
    "'Um home sábio, ao reconhecer que o mundo não é nada além de ilusão, não age como se ele fosse real, e por isso escapa do sofrimento.    Buda(563-483 a.C).'",
    "'Existe um sentido nas árvores que permite que elas sintam o seu amor e reajam a ele. Mas elas não reagem ou demonstram o prazer que sentem da nossa maneira, nem de nehuma maneira que possamos entender agora  - Preutice Mulfere(1834-1891).'",
    "'Há um poder supremo, uma força dominante que permeia e rege todo o Universo ilimitado. Você É parte desse poder  - Preutice Mulfere(1834-1891).'",
    "'Tome cuidado com suas emoções e sentimentos porque exite uma forte conexão entre os seus sentimentos e o mundo físico - Neville Goddard(1905-1972).'",
    "'Se você quer descobrir o segredo do Universo, pense em termos de energia, frequência e vibração - Neville Goddard(1905-1972).'",
    "'Não é o que acontece com você que importa, mas a maneira como você reage ao que acontece com você - Epiteto(55-135).'",
  ];
  var fraseGerada = "Clique em 'Nova Frase' para o seu dia";
  int randomNumeroLista = 0;
  void gerarFrase() {
    var numeroRandom = Random().nextInt(listaFrases.length);
    setState(() {
      fraseGerada = listaFrases[numeroRandom];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Frases do Dia"),
        backgroundColor: Colors.green.shade300,
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
                "assets/images/logo.png",
                fit: BoxFit.scaleDown,
              ),
              Text(
                fraseGerada,
                style:
                    const TextStyle(fontStyle: FontStyle.italic, fontSize: 18),
              ),
              ElevatedButton(
                  onPressed: gerarFrase,
                  style: ButtonStyle(
                      shape: const MaterialStatePropertyAll(
                          RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(6)))),
                      backgroundColor: MaterialStateProperty.resolveWith(
                          (states) => Colors.green.shade300),
                      overlayColor: MaterialStateProperty.resolveWith((state) {
                        if (state.contains(MaterialState.hovered)) {
                          return Colors.green;
                        }
                        if (state.contains(MaterialState.focused)) {
                          return Colors.green;
                        }
                        return null;
                      })),
                  child: const Text(
                    "Nova Frase",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  )),
              Container(
                padding: const EdgeInsets.all(12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, "/jokenpo");
                        },
                        child: const Text("Joken Pô")),
                    Padding(
                      padding: const EdgeInsets.only(left: 16, right: 16),
                      child: ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(context, "/caraoucoroa");
                          },
                          child: const Text("Cara ou Coroa")),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, "/checkbox");
                      },
                      child: const Text("Checkbox"))
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16, right: 16),
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, "/alcoolougasolina");
                    },
                    child: const Text("Entrada de dados")),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, "/navegacao");
                      },
                      child: const Text("Exemplos de Navegação")),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, "/ATMconsultoria");
                      },
                      child: const Text("ATM Consultoria"))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

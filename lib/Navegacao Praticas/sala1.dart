import 'package:epraja/Navegacao%20Praticas/sala2.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Sala01 extends StatefulWidget {
  int valor = 0;
  Sala01(this.valor, {super.key});

  @override
  State<Sala01> createState() => _Sala01State();
}

class _Sala01State extends State<Sala01> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sala 02"),
      ),
      backgroundColor: Colors.amber,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset("assets/images/bannermock.png",
                fit: BoxFit.fitWidth, height: 500),
            const SizedBox(
              height: 50,
            ),
            Text("Valor passado entre telas : ${widget.valor}"),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Sala02(name: "Erik",
                      )));
                },
                child: const Text("Ir para Sala 02"))
          ],
        ),
      ),
    );
  }
}

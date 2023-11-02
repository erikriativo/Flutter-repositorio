import 'package:epraja/navegacao.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Sala02 extends StatelessWidget {
  int? valor ;
  String? name;
  Sala02({super.key, this.valor, this.name});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sala 02"),
        backgroundColor: Colors.amber,
      ),
      backgroundColor: Colors.amber.shade400,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
             Image.asset("assets/images/550.jpg",fit: BoxFit.fitWidth,height: 500),
            const SizedBox(
              height: 50,
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const Navegacao()));
                },
                child: const Text("Voltar ao Saguão"))
          ],
        ),
      ),
    );
  }
}

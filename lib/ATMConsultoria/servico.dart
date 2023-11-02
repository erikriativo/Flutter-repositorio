import 'package:flutter/material.dart';

class Servico extends StatelessWidget {
  const Servico({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Serviços"),
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset("assets/images/atmconsultoria/detalhe_servico.png"),
                  const SizedBox(
                    width: 15,
                  ),
                  const Text("Nossos Serviços")
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              const Text("Consultoria"),
              const Padding(padding: EdgeInsets.only(top: 15),
              child: Text("Calculos de preços"),),
              const Padding(padding: EdgeInsets.only(top: 10),
              child: Text("Acompanhamento de projetos"),)
            ]),
        ),
      ),
    );
  }
}
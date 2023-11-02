import 'package:flutter/material.dart';

class Contato extends StatelessWidget {
  const Contato({super.key});

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
                  Image.asset("assets/images/atmconsultoria/detalhe_contato.png"),
                  const SizedBox(
                    width: 15,
                  ),
                  const Text("Entre em contato conosco")
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              const Text("atendimento@atmconsultoria.com.br"),
              const Padding(padding: EdgeInsets.only(top: 15),
              child: Text("Telefone: (21)9999-9999"),),
              const Padding(padding: EdgeInsets.only(top: 10),
              child: Text("Celular: (21 99999-9999)"),)
            ]),
        ),
      ),
    );
  }
}
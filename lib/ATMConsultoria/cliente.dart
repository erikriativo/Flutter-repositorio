import 'package:flutter/material.dart';

class Cliente extends StatelessWidget {
  const Cliente({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cliente"),
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset("assets/images/atmconsultoria/detalhe_cliente.png"),
                  const SizedBox(
                    width: 15,
                  ),
                  const Text("Nossos Cliente")
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      Image.asset("assets/images/atmconsultoria/cliente1.png"),
                      const Padding(
                        padding:  EdgeInsets.all(8.0),
                        child: Text("Empresa de Software",
                        style: TextStyle(
                          fontStyle: FontStyle.italic
                        ),),
                      )
                    ],
                  ),
                  Padding(padding: const EdgeInsets.only(left: 15),
                  child: Column(
                    children: [
                      Image.asset("assets/images/atmconsultoria/cliente2.png"),
                      const Padding(
                        padding:  EdgeInsets.all(8.0),
                        child: Text("Empresa de Consultoria",
                        style: TextStyle(
                          fontStyle: FontStyle.italic
                        ),
                        ),)
                    ],
                  ),)
                ],
              )
            ]),
        ),
      ),
    );
  }
}
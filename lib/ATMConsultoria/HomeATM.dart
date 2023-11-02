import 'package:epraja/ATMConsultoria/ATMempresas.dart';
import 'package:epraja/ATMConsultoria/cliente.dart';
import 'package:epraja/ATMConsultoria/contato.dart';
import 'package:epraja/ATMConsultoria/servico.dart';
import 'package:flutter/material.dart';

class HomepageATM extends StatefulWidget {
  const HomepageATM({super.key});

  @override
  State<HomepageATM> createState() => _HomepageATMState();
}

class _HomepageATMState extends State<HomepageATM> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text("ATM Consultoria"),
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Image.asset("assets/images/atmconsultoria/logo.png"),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    child: Image.asset("assets/images/atmconsultoria/menu_empresa.png"),
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: ((context) => const ATMempresas())));
                    },
                    
                  ),
                  GestureDetector(
                    child: Image.asset("assets/images/atmconsultoria/menu_servico.png"),
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: ((context) => const Servico())));
                    },
                    
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    child: Image.asset("assets/images/atmconsultoria/menu_cliente.png"),
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: ((context) => const Cliente())));
                    },
                    
                  ),
                  GestureDetector(
                    child: Image.asset("assets/images/atmconsultoria/menu_contato.png"),
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: ((context) => const Contato())));
                    },
                    
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
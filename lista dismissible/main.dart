import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(debugShowCheckedModeBanner: false, home: Home()));
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List lista = ["Ola", "Ola mundo"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Lista de Tarefas Dismissible"),
      ),
      body: ListView.builder(
          itemCount: lista.length,
          itemBuilder: (context, index) {
            var item = lista[index];
            return Dismissible(
              background: Container(
                color: Colors.blue,
                padding: const EdgeInsets.only(top: 3,left: 6),
                child: const Row(
                  children: [
                    Column(
                      children: [
                        Icon(Icons.edit,
                        color: Colors.white,),
                        Text("Editar",
                        style: TextStyle(
                          color: Colors.white
                        ),)
                      ],
                    ),
                  ],
                ),
              ),
              secondaryBackground: Container(
                color: Colors.red,
                padding: const EdgeInsets.only(top: 3, right: 6),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Column(
                      children: [
                        Icon(Icons.delete,
                        color: Colors.white,),
                        Text("Deletar",
                        style: TextStyle(
                          color: Colors.white
                        ),)
                      ],
                    ),
                  ],
                ),
              ),
              direction: DismissDirection.horizontal,
              key: Key(item),
              child: ListTile(
                title: Text(lista[index]),
              ),
              onDismissed: (direction) {
                if (direction == DismissDirection.startToEnd) {
                  setState(() {
                    lista.removeAt(index);  
                  });
                  
                } else if (direction == DismissDirection.startToEnd) {
                  setState(() {
                    lista.removeAt(index);  
                  });
                  
                }
                print(direction.toString());
              },
            );
          }),
    );
  }
}

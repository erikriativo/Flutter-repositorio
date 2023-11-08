import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _tarefaController = TextEditingController();
  final _tarefaDescricaoController = TextEditingController();
  Map<String, dynamic> _ultimaTarefaRemovida = {};//Controlador dos últimos itens que foram removidos para serem restaurados a lista caso precise desfazer a deleção de um item da lista
  final _listaTarefas = <Map<String, dynamic>>[]; //Instancia de Lista que recebe Map

  Future<File> _getFile() async { //Instancia de uso do path_provider recuperando o caminho caminho de onde serão armazenado os dados das tarefas em si.
    final appDocumentsDir = await getApplicationDocumentsDirectory();
    return File("${appDocumentsDir.path}/dataTarefa.json");
  }

  _salvarTarefa() {// Essa função cria um Map tarefa para ser inserido _listaTarefa
    Map<String, dynamic> tarefa = {
      "titulo": _tarefaController.text,
      "descricao": _tarefaDescricaoController.text,
      "realizada": false,
    };

    _listaTarefas.add(tarefa);//Adiciona a tarefa em Map para a lista que recebe um Map _listaTarefas[]
    _salvarArquivo();
  }

  _salvarArquivo() async {//Salva os dados na Instancia _getFile armazenando no Arquivo "dadosTarefa.json"
    var arquivo = await _getFile();
    final dados = json.encode(_listaTarefas);
    await arquivo.writeAsString(dados);

    _carregarArquivo(); // Atualiza a lista após a adição da tarefa.
    _tarefaController.clear();
    _tarefaDescricaoController.clear();
  }

  _carregarArquivo() async {
    // final appDocumentsDir = await getApplicationDocumentsDirectory();
    // final arquivo = File("${appDocumentsDir.path}/dados.json");
    final arquivo = await _getFile();
    if (arquivo.existsSync()) {
      final dados = await arquivo.readAsString();
      final lista = json.decode(dados);

      setState(() {
        _listaTarefas.clear();
        _listaTarefas.addAll(List<Map<String, dynamic>>.from(lista));
      });
    }
  }

  Widget _criarLista(context, index) {
    final tarefa = _listaTarefas[index];
    return Dismissible(
      direction: DismissDirection.endToStart,
      key: Key(tarefa["titulo"]),
      onDismissed: (direction) {
        _ultimaTarefaRemovida = tarefa;
        _listaTarefas.removeAt(index);
        final snackbar = SnackBar(
          backgroundColor: Colors.blueAccent,
          content: Text("${tarefa["titulo"]} removido"),
          action: SnackBarAction(
              label: "Desfazer",
              onPressed: () {
                setState(() {
                  _listaTarefas.insert(index, _ultimaTarefaRemovida);  
                });
                _salvarArquivo();
              }),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackbar);
        _salvarArquivo();
      },
      background: Container(
        padding: const EdgeInsets.all(16),
        color: Colors.red,
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Icon(
              Icons.delete,
              color: Colors.white,
            )
          ],
        ),
      ),
      child: CheckboxListTile(
        title: Text(tarefa["titulo"].toString()),
        value: tarefa["realizada"],
        onChanged: (value) {
          setState(() {
            tarefa["realizada"] = value;
            _salvarArquivo();
          });
        },
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _carregarArquivo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Lista de Tarefas"),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _listaTarefas.length,
              itemBuilder: (context, index) {
                return _criarLista(context, index);
              },
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                contentPadding: const EdgeInsets.all(16),
                title: const Text("Adicionar uma Tarefa"),
                content: Column(
                  children: [
                    TextField(
                      controller: _tarefaController,
                      decoration: const InputDecoration(
                        labelText: "Título da Tarefa",
                      ),
                    ),
                    TextField(
                      controller: _tarefaDescricaoController,
                      decoration: const InputDecoration(
                        labelText: "Descreva sua tarefa",
                      ),
                      minLines: 3,
                      maxLines: 5,
                      maxLength: 120,
                    )
                  ],
                ),
                actions: [
                  ElevatedButton(
                    style: ButtonStyle(
                      overlayColor: MaterialStateColor.resolveWith(
                          (states) => Colors.red),
                      foregroundColor: MaterialStateColor.resolveWith(
                          (states) => Colors.white),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(3),
                        ),
                      ),
                      backgroundColor: MaterialStateColor.resolveWith(
                          (states) => Colors.blue),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("Cancelar"),
                  ),
                  ElevatedButton(
                    style: ButtonStyle(
                      foregroundColor: MaterialStateColor.resolveWith(
                          (states) => Colors.white),
                      overlayColor: MaterialStateColor.resolveWith(
                          (states) => Colors.green),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(3),
                        ),
                      ),
                      backgroundColor: MaterialStateColor.resolveWith(
                          (states) => Colors.blue),
                    ),
                    onPressed: () {
                      _salvarTarefa();
                      Navigator.pop(context);
                    },
                    child: const Text("Salvar"),
                  )
                ],
              );
            },
          );
        },
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white,
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.account_circle_rounded),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.library_add_check),
            ),
          ],
        ),
      ),
    );
  }
}

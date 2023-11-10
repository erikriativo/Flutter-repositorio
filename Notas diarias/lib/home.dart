import 'package:intl/date_symbol_data_local.dart';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:notas_diarias/helper/helper.dart';
import 'package:notas_diarias/model/anotacaomodelo.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final AnotacaoHelper _db = AnotacaoHelper();
  //Configurando os controladores de entrada de textos
  final TextEditingController _tituloController = TextEditingController();
  final TextEditingController _descricaoController = TextEditingController();

  //Gerar uma instancia de uma Lista que recebe a classe Anotacao retornando uma lista de anotacoes
  List<Anotacao> _anotacoes = <Anotacao>[];

  //**Metodos**/

  _salvarAnotacoes({Anotacao? anotacaoSelecionada}) async {
    String titulo = _tituloController.text;
    String descricao = _descricaoController.text;

    //Se a anotacao[index] que foi selecionada nao existir, no caso de simplesmente apertar o floatting button
    //Ira salvar uma nova anotacao
    //Caso exista ira atualizar, nesse caso poderia ser feito uma funcao [alterarAnotacao()].

    if (anotacaoSelecionada == null) {
      //Armazenar Map Anotacao em anotacao para capturar a estrutura map em que sera criada uma nova anotacao
      Anotacao anotacao =
          Anotacao(titulo, descricao, DateTime.now().toString());
      //neste metodo salvarAnotacao importada do nosso helper, ele instancia o banco de dados
      //e aciona .insert() que retorna um Future<int> possibilitando capturar a quantidade de itens
      //que foram salvos no banco de dados atraves deste metodo que sera armazenado em [resultado]
      //int resultado = await _db.salvarAnotacao(anotacao);
      await _db.salvarAnotacao(anotacao);
    } else {
      anotacaoSelecionada.titulo = titulo;
      anotacaoSelecionada.descricao = descricao;
      anotacaoSelecionada.data = DateTime.now().toString();
      //int resultado = await _db.atualizarAnotacao(anotacaoSelecionada);
      await _db.atualizarAnotacao(anotacaoSelecionada);
    }

    _tituloController.clear();
    _descricaoController.clear();
    _recuperarAnotacoes();
  }

  _recuperarAnotacoes() async {
    //[recuperarAnotacoesTabela] recupera a lista de itens salvos no banco de dados com [rawQuery()]
    //retornando uma lista de [anotacoes]
    List anotacoes = await _db.recuperarAnotacoesTabela();

    //instaciar uma lista temporaria para receber as anotacoes do banco de dados
    List<Anotacao> listaTemporaria = <Anotacao>[];

    //Para cada anotacao iremos armazenar em [listaTemporaria] para possibilitar
    //a exibicao da lista pelo [ListView.builder]
    for (var item in anotacoes) {
      Anotacao anotacao = Anotacao.fromMap(item);
      listaTemporaria.add(anotacao);
    }
    setState(() {
      //Atualizando nossa lista de anotacoes com os valores de nossa [listaTemporaria]
      _anotacoes = listaTemporaria;
    });
  }

  //Funcao para criar um widget AlertDialog ao clicar em floatingButton
  _telaCadastro({Anotacao? anotacao}) {
    String tituloVar = "";
    String botaoSalvarAtualizar = "";
    if (anotacao == null) {
      //iremos salvar uma anotacao
      _tituloController.text = "";
      _descricaoController.text = "";
      tituloVar = "Adicionar anotação";
      botaoSalvarAtualizar = "Salvar";
    } else {
      //iremos atualizar uma anotacao
      _tituloController.text = anotacao.titulo;
      _descricaoController.text = anotacao.descricao;
      tituloVar = "Alterar anotação";
      botaoSalvarAtualizar = "Alterar";
    }
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(tituloVar),
            contentPadding: const EdgeInsets.all(32),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  maxLength: 75,
                  controller: _tituloController,
                  autofocus: true,
                  decoration: const InputDecoration(
                      label: Text("Adicione um título"),
                      hintText: "Digite o título"),
                ),
                TextField(
                  controller: _descricaoController,
                  autofocus: true,
                  decoration: const InputDecoration(
                      label: Text("Descrição"), hintText: "Digite a descrição"),
                  minLines: 2,
                  maxLines: 5,
                  maxLength: 225,
                )
              ],
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    _tituloController.clear();
                    _descricaoController.clear();
                    Navigator.pop(context);
                  },
                  child: const Text("Cancelar")),
              TextButton(
                  onPressed: () {
                    _salvarAnotacoes(anotacaoSelecionada: anotacao);
                    Navigator.pop(context);
                  },
                  child: Text(botaoSalvarAtualizar))
            ],
          );
        });
  }

  //Formatar data pela regiao do usuario, abaixo esta pt_BR mas podemos trabalhar
  //com esse valor pela area do usuario com uma variavel [localidade] por exemplo
  _formatarData(String data) {
    initializeDateFormatting('pt_BR');
    var formatador = DateFormat.MMMd("pt_BR").add_jm();
    DateTime dataConvertida = DateTime.parse(data);
    String dataFormatada = formatador.format(dataConvertida);

    return dataFormatada;
  }

  @override
  void initState() {
    super.initState();
    //Recuperar lista do banco de dados para exibicao utilizando [rawQuery()]
    _recuperarAnotacoes();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Minhas anotações"),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Expanded(
              child: ListView.builder(
                  itemCount: _anotacoes.length,
                  itemBuilder: (context, index) {
                    List<Anotacao> anotacoesConcluidas = <Anotacao>[];
                    final anotacao = _anotacoes[index];
                    return Dismissible(
                      key: Key(anotacao.id.toString()),
                      direction: DismissDirection.horizontal,
                      onDismissed: (direction) {
                        final removedItem = _anotacoes[index];
                        if (direction == DismissDirection.endToStart) {
                          setState(() {
                            // Remover o item da lista diretamente no onDismissed
                            _anotacoes.removeAt(index);
                            //Remover o item no banco de dados
                            _db.removerAnotacao(anotacao.id);
                          });
                          final snackbar = SnackBar(
                            backgroundColor: Colors.blueAccent,
                            content: Text("${anotacao.titulo} removido"),
                            action: SnackBarAction(
                                label: "Desfazer",
                                onPressed: () {
                                  setState(() {
                                    _anotacoes.insert(index, removedItem);
                                    _db.salvarAnotacao(removedItem);
                                  });
                                }),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackbar);
                        } else if (direction == DismissDirection.startToEnd) {
                          setState(() {
                            anotacoesConcluidas.add(_anotacoes[index]);
                            _anotacoes.removeAt(index);
                          });
                        }
                      },
                      background: Container(
                        color: Colors.green,
                        padding: const EdgeInsets.only(left: 10),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.check_sharp,
                                  color: Colors.white,
                                ),
                                Text(
                                  "Concluir",
                                  style: TextStyle(color: Colors.white),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                      secondaryBackground: Container(
                        color: Colors.red,
                        padding: const EdgeInsets.only(right: 10),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.delete,
                                  color: Colors.white,
                                ),
                                Text(
                                  "Deletar",
                                  style: TextStyle(color: Colors.white),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                      child: Card(
                        child: ListTile(
                          title: Text(anotacao.titulo),
                          subtitle: Text(
                              "${anotacao.descricao} - ${_formatarData(anotacao.data)}"),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  _telaCadastro(anotacao: anotacao);
                                },
                                child: const Padding(
                                  padding: EdgeInsets.only(right: 16),
                                  child: Icon(
                                    Icons.edit,
                                    color: Colors.blue,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  }))
        ],
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.green,
          foregroundColor: Colors.white,
          child: const Icon(Icons.add),
          onPressed: () {
            _telaCadastro();
          }),
    );
  }
}

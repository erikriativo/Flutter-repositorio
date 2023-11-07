import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late Future<SharedPreferences> _prefs;
  String? _campoText;
  late Future<String> _campoTextInitialLoad;
  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _prefs = SharedPreferences.getInstance();
    _campoTextInitialLoad = _prefs.then((SharedPreferences prefs) {
      return prefs.getString('nome') ??
          ""; //Iniciando o campo com o ultimo valor salvo pelo usuario
    });
  }

  Future<void> _salvar() async {
    String valorDigitado = controller.text;
    final SharedPreferences preferences =
        await _prefs; //instanciando SharedPreference

    await preferences.setString("nome",
        valorDigitado); //Salvando dados com (Key("nome_chave"), value("valor_a_ser_salvo_enviado_pelo_controller"))
    print("Salvo: $valorDigitado");
  }

  _recuperar() async {
    final prefs = await _prefs;
    setState(() {
      _campoText = prefs.getString("nome") ??
          "Valor Vazio"; //Recuperando os dados e atualizando o state para exibicao
    });
    print(_campoText);
  }

  _remover() async {
    final prefs = await _prefs;
    prefs.remove("nome");
    setState(() {
      _campoText = prefs.getString(
          "nome"); //Para remover uma preferencia salva, basta passar o (Key("nome_chave"))
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Manipulação de dados",
          style: TextStyle(
            fontSize: 24,
          ),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(24),
        child: FutureBuilder(
          future: _campoTextInitialLoad,
          builder: ((context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
              case ConnectionState.waiting:
                return const CircularProgressIndicator();
              case ConnectionState.active:
              case ConnectionState.done:
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  return Column(
                    children: [
                      Text(_campoText ?? snapshot.data!),
                      TextField(
                        keyboardType: TextInputType.text,
                        controller: controller,
                        decoration:
                            const InputDecoration(labelText: "Digite algo"),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            style: ButtonStyle(
                                shape: MaterialStatePropertyAll(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(3))),
                                backgroundColor: MaterialStateColor.resolveWith(
                                    (states) => Colors.blue),
                                foregroundColor: MaterialStateColor.resolveWith(
                                    (states) => Colors.white)),
                            onPressed: _salvar,
                            child: const Text(
                              "Salvar",
                              style: TextStyle(
                                fontSize: 24,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 30,
                          ),
                          ElevatedButton(
                            style: ButtonStyle(
                                shape: MaterialStatePropertyAll(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(3))),
                                backgroundColor: MaterialStateColor.resolveWith(
                                    (states) => Colors.blue),
                                foregroundColor: MaterialStateColor.resolveWith(
                                    (states) => Colors.white)),
                            onPressed: _recuperar,
                            child: const Text(
                              "Ler",
                              style: TextStyle(
                                fontSize: 24,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 30,
                          ),
                          ElevatedButton(
                            style: ButtonStyle(
                                shape: MaterialStatePropertyAll(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(3))),
                                backgroundColor: MaterialStateColor.resolveWith(
                                    (states) => Colors.blue),
                                foregroundColor: MaterialStateColor.resolveWith(
                                    (states) => Colors.white)),
                            onPressed: _remover,
                            child: const Text(
                              "Remover",
                              style: TextStyle(
                                fontSize: 24,
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  );
                }
            }
          }),
        ),
      ),
    );
  }
}

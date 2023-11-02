import 'package:flutter/material.dart';

class CheckBox extends StatefulWidget {
  const CheckBox({super.key});

  @override
  State<CheckBox> createState() => _CheckBoxState();
}

class _CheckBoxState extends State<CheckBox> {
  bool _notificacao = false;
  bool _carregarImagensAutomaticamente = false;
  String? _genero;
  bool? _estadoCheckBox2 = false;
  double _sliderLike = 4;
  String _labelSlider = "Bom!";
  Color _labelSliderColor = Colors.blue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("CheckBox Example"),
        backgroundColor: Colors.blue.shade300,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                CheckboxListTile(
                    title: const Text("Preferência do Usuário"),
                    subtitle: const Text("Todos podem ver seu perfil"),
                    value: _estadoCheckBox2,
                    onChanged: (valor) {
                      setState(() {
                        _estadoCheckBox2 = valor;
                      });
                    }),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Escola seu Gênero",
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Masculino"),
                          Padding(
                            padding: const EdgeInsets.only(left: 8, right: 8),
                            child: Radio(
                              groupValue: _genero,
                              value: "Masculino",
                              onChanged: (valor) {
                                setState(() {
                                  _genero = valor;
                                });
                              },
                            ),
                          ),
                          const Text("Feminino"),
                          Radio(
                            groupValue: _genero,
                            value: "Feminino",
                            onChanged: (valor) {
                              setState(() {
                                _genero = valor;
                              });
                            },
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                SwitchListTile(
                    title: const Text("Receber notificações"),
                    value: _notificacao,
                    onChanged: (valor) {
                      setState(() {
                        _notificacao = valor;
                      });
                    }),
                SwitchListTile(
                  title: const Text("Carregar imagens automaticamente"),
                  value: _carregarImagensAutomaticamente,
                  onChanged: (value) {
                    setState(() {
                      _carregarImagensAutomaticamente = value;
                    });
                  },
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  child: Text(
                    "Oque achou dessa seção?",
                    style: TextStyle(
                      fontSize: 34,
                      color: Colors.black54,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Text(
                    _labelSlider,
                    style: TextStyle(
                      fontSize: 24,
                      color: _labelSliderColor,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Slider(
                      value: _sliderLike,
                      min: 0,
                      max: 10,
                      activeColor: Colors.blue.shade500,
                      inactiveColor: Colors.black26,
                      label: _labelSlider,
                      divisions: 5,
                      onChanged: (double valor) {
                        setState(() {
                          _sliderLike = valor;
                          if (_sliderLike == 0.0) {
                            _labelSlider = "Não Gostei!!";
                            _labelSliderColor = Colors.red;
                          } else if (_sliderLike == 2) {
                            _labelSlider = "Legal!";
                            _labelSliderColor = Colors.orange;
                          } else if (_sliderLike == 4) {
                            _labelSlider = "Bom!";
                            _labelSliderColor = Colors.blue;
                          } else if (_sliderLike == 6) {
                            _labelSlider = "Muito bom!";
                            _labelSliderColor = Colors.blue;
                          } else if (_sliderLike == 8) {
                            _labelSlider = "Excelente!!";
                            _labelSliderColor = Colors.green.shade900;
                          } else if (_sliderLike == 10) {
                            _labelSlider = "Incrível!!";
                            _labelSliderColor = Colors.green.shade600;
                          }
                          
                        });
                        print("Satisfação : ${_sliderLike.toString()}");
                      }),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      ElevatedButton(
                          onPressed: () {
                            print(
                                "Usuario definiu: Preferencia do usuario $_estadoCheckBox2");
                            print("Usuario definiu o gênero: $_genero");
                            print(
                                "Usuario definiu Receber notificações $_notificacao");
                            print(
                                "Usuario definiu Salvar imagens automaticamente $_carregarImagensAutomaticamente");
                            print(
                                "Usuario avaliou sua página com $_sliderLike");
                          },
                          style: ButtonStyle(
                              shape: const MaterialStatePropertyAll(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(6)))),
                              backgroundColor:
                                  MaterialStateProperty.resolveWith(
                                      (states) => Colors.blue.shade300),
                              overlayColor:
                                  MaterialStateProperty.resolveWith((state) {
                                if (state.contains(MaterialState.hovered)) {
                                  return Colors.green;
                                }
                                if (state.contains(MaterialState.focused)) {
                                  return Colors.green;
                                }
                                return null;
                              })),
                          child: const Text(
                            "Salvar",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                          )),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

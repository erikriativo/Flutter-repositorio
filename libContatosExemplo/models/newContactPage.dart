import 'package:flutter/material.dart';
import 'contact.dart';


class AddContactScreen extends StatefulWidget {
  const AddContactScreen({super.key});

  @override
  _AddContactScreenState createState() => _AddContactScreenState();
}

class _AddContactScreenState extends State<AddContactScreen> {
  // Declare as variáveis necessárias para armazenar as informações do novo contato
  List<Contact> contactList = [];
  String _name = '';
  String _email = '';
  String _phone = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Adicionar Contato'),
        centerTitle: true,
        
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextField(
              decoration: const InputDecoration(
                labelText: 'Nome',
              ),
              onChanged: (value) {
                setState(() {
                  _name = value;
                });
              },
            ),
            TextField(
              decoration: const InputDecoration(
                labelText: 'Email',
              ),
              onChanged: (value) {
                setState(() {
                  _email = value;
                });
              },
            ),
            TextField(
              decoration: const InputDecoration(
                labelText: 'Telefone',
              ),
              onChanged: (value) {
                setState(() {
                  _phone = value;
                });
              },
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              child: const Text('Salvar'),
              onPressed: () {
                // Criar um novo contato com as informações inseridas pelo usuário
                Contact newContact = Contact(
                  id: contactList.length + 1,
                  name: _name,
                  email: _email,
                  phone: _phone,
                  img: null,
                );

                // Adicionar o novo contato à lista de contatos
                setState(() {
                  contactList.add(newContact);
                });

                // Fechar a tela atual e retornar para a tela anterior
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:contatos/provider/providerdb.dart';
import 'package:flutter/material.dart';
import 'package:contatos/models/contact.dart';
import 'newContactPage.dart';

class ContactListScreen extends StatefulWidget {
  const ContactListScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ContactListScreenState createState() => _ContactListScreenState();
}

class _ContactListScreenState extends State<ContactListScreen> {
  DatabaseProvider databaseProvider = DatabaseProvider();
  List<Contact> _contactList = [];

  @override
  void initState() {
    super.initState();
    _loadContacts();
    // databaseProvider.getAllContacts().then((list) {
    //   _contactList = list;
    // });
  }

  void _loadContacts() async {
    // aqui é onde você pode abrir seu banco de dados e carregar a lista de contatos
    // no exemplo abaixo, estou carregando uma lista de contatos pré-definida

    List<Contact> contacts = [
      Contact(
        id: 1,
        name: 'João da Silva',
        email: 'joao.silva@gmail.com',
        phone: '+55 11 99999-9999',
        img: 'https://picsum.photos/id/237/200/300',
      ),
      Contact(
        id: 2,
        name: 'Maria Oliveira',
        email: 'maria.oliveira@hotmail.com',
        phone: '+55 21 88888-8888',
        img: 'https://picsum.photos/id/238/200/300',
      ),
      Contact(
        id: 3,
        name: 'Pedro Santos',
        email: 'pedro.santos@yahoo.com',
        phone: '+55 31 77777-7777',
        img: 'https://picsum.photos/id/239/200/300',
      ),
    ];

    setState(() {
      DatabaseProvider.database;
      _contactList = contacts;
    });
  }

  void _addContact() {
    // Abrir a tela para adicionar um novo contato
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AddContactScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contatos'),
        backgroundColor: Colors.red,
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(10.0),
        itemCount: _contactList.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(_contactList[index].img ?? ""),
            ),
            title: Text(
              _contactList[index].name ?? "",
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(_contactList[index].phone ?? ""),
            trailing: const Icon(Icons.arrow_forward),
            onTap: () {
              // aqui é onde você pode criar uma nova tela para exibir os detalhes de um contato específico
              print('Clicou no contato ${_contactList[index].id}');
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addContact,
        child: const Icon(Icons.add),
        backgroundColor: Colors.red,
      ),
    );
  }
}

//Neste exemplo, estou usando uma lista de contatos pré-definida para carregar na tela de lista. Você pode substituir isso pelo seu próprio código para carregar a lista do seu banco de dados. A função _addContact adiciona um novo contato à lista quando o botão de adicionar é pressionado. Note que a função _addContact atualiza o estado da tela usando o método setState, o que faz com que o widget seja reconstruído com a nova lista de contatos.

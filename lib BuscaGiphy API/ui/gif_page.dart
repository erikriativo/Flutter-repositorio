import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

class GifPage extends StatelessWidget {
//Construtor
  const GifPage(this.gifData, {super.key});
//recebimento da imagem
  final Map gifData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(gifData['title']),
        backgroundColor: Colors.black,
        actions: [
          IconButton(
              onPressed: () async {
                await Share.share(gifData["images"]["fixed_height"]["url"]);
              },
              icon: const Icon(Icons.share))
        ],
      ),
      backgroundColor: Colors.black,
      body: Center(
          child: Image.network(gifData["images"]["fixed_height"]["url"])),
    );
  }
}

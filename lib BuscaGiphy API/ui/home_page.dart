import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

import 'gif_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _search = "";
  int _offSet = 0;

  Future<Map> getGifs() async {
    http.Response response;

    if (_search.isEmpty) {
      response = await http.get(Uri.parse(
          'https://api.giphy.com/v1/gifs/trending?api_key=3Ic7pSVQ6F5nj6rkfBpN8rwCpAFvGtrk&limit=25&rating=g'));
    } else {
      response = await http.get(Uri.parse(
          'https://api.giphy.com/v1/gifs/search?api_key=3Ic7pSVQ6F5nj6rkfBpN8rwCpAFvGtrk&q=$_search&limit=19&offset=$_offSet&rating=g&lang=en'));
    }

    return json.decode(response.body);
  }

  @override
  void initState() {
    super.initState();
    getGifs().then((map) {});
  }

  int getCount(List data) {
    if (_search.isEmpty) {
      return data.length;
    } else {
      return data.length + 1;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Image.network(
            "https://developers.giphy.com/branch/master/static/header-logo-0fec0225d189bc0eae27dac3e3770582.gif"),
        centerTitle: true,
      ),
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              decoration: const InputDecoration(
                  labelText: 'Pesquise aqui',
                  labelStyle: TextStyle(color: Colors.white),
                  border: OutlineInputBorder()),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
              ),
              textAlign: TextAlign.center,
              onSubmitted: (text) {
                setState(() {
                  _search = text;
                });
              },
            ),
          ),
          Expanded(
              child: FutureBuilder(
            future: getGifs(),
            builder: ((context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                case ConnectionState.none:
                  return Container(
                      width: 150,
                      height: 150,
                      alignment: Alignment.center,
                      child: const CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                        strokeWidth: 5.0,
                      ));
                default:
                  if (snapshot.hasError) {
                    return Container();
                  } else {
                    return _createGiftable(context, snapshot);
                  }
              }
            }),
          ))
        ],
      ),
    );
  }

  Widget _createGiftable(BuildContext context, AsyncSnapshot snapshot) {
    return GridView.builder(
        padding: const EdgeInsets.all(10.0),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, crossAxisSpacing: 10.0, mainAxisSpacing: 10.0),
        itemCount: getCount(snapshot.data["data"]),
        itemBuilder: (context, index) {
          if (_search.isEmpty || index < snapshot.data["data"].length) {
            return GestureDetector(
                child: FadeInImage.memoryNetwork(
                  placeholder: kTransparentImage,
                  image: snapshot.data["data"][index]["images"]["fixed_height"]
                      ["url"],
                  height: 300.0,
                  fit: BoxFit.cover,
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              GifPage(snapshot.data["data"][index])));
                });
          } else {
            return GestureDetector(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.add, color: Colors.white, size: 60.0),
                    Text(
                      "Carregar mais...",
                      style: TextStyle(color: Colors.white, fontSize: 22.0),
                    )
                  ]),
              onTap: () {
                setState(() {
                  _offSet += 19;
                });
              },
            );
          }
        });
  }
}

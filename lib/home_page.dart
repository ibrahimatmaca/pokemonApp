import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pokeapp/model/pokemon_model.dart';
import 'package:pokeapp/pokemon_detail.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var url =
      "https://raw.githubusercontent.com/Biuni/PokemonGO-Pokedex/master/pokedex.json";

  PokeHub? _pokeHub;

  @override
  void initState() {
    super.initState();
    fetcData();
  }

  Future fetcData() async {
    var resource = await http.get(Uri.parse(url));
    var decodedJson = jsonDecode(resource.body);

    setState(() {
      _pokeHub = PokeHub.fromJson(decodedJson);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Poke App"),
        backgroundColor: Colors.cyan,
      ),
      body: _pokeHub == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : gridViewCount,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.refresh),
        backgroundColor: Colors.cyan,
        onPressed: () {},
      ),
    );
  }

  Widget get gridViewCount {
    return GridView.count(
      crossAxisCount: 2,
      children: _pokeHub!.pokemon!.map((poke) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: pokemonCard(poke),
        );
      }).toList(),
    );
  }

  Widget pokemonCard(Pokemon poke) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => PokemonDetail(pokemon: poke)));
      },
      child: Hero(
        tag: poke.img!,
        child: Card(
          elevation: 3,
          child: pokemonCardInsideColumn(poke),
        ),
      ),
    );
  }

  Widget pokemonCardInsideColumn(Pokemon poke) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        columnInsidePicture(poke),
        columnInsidePokeName(poke),
      ],
    );
  }

  Widget columnInsidePokeName(Pokemon poke) {
    return Text(
      poke.name!,
      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
    );
  }

  Widget columnInsidePicture(Pokemon poke) {
    return Container(
      height: 100,
      width: 100,
      decoration:
          BoxDecoration(image: DecorationImage(image: NetworkImage(poke.img!))),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:pokeapp/model/pokemon_model.dart';

class PokemonDetail extends StatelessWidget {
  PokemonDetail({Key? key, required this.pokemon}) : super(key: key);

  final Pokemon? pokemon;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.blueAccent,
        title: Text(pokemon!.name!),
      ),
      body: pokemon == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : bodyWidget(context),
    );
  }

  Widget bodyWidget(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          height: MediaQuery.of(context).size.height * 0.75,
          width: MediaQuery.of(context).size.width - 20,
          left: 10.0,
          top: MediaQuery.of(context).size.height * 0.12,
          child: cardParentForColumnPokemon,
        ),
        _pokemonPictureAlign(),
      ],
    );
  }

  Widget get cardParentForColumnPokemon {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 5,
      child: columnPokemonDetail,
    );
  }

  Widget get columnPokemonDetail {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        SizedBox(height: 75),
        Text(
          pokemon!.name!,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        Text("Height: ${pokemon!.height!}"),
        Text("Weight: ${pokemon!.weight!}"),
        Text("Types",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
        pokemonTypeFilterChipRow,
        Text("Weaknesses",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
        pokemonWeaknessesFilterChipRow,
        Text("Next Evulations",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
        pokemonNextEvolutionFilterChipRow,
      ],
    );
  }

  Widget get pokemonTypeFilterChipRow {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: pokemon!.type!
          .map((e) => FilterChip(
              backgroundColor: Colors.red,
              label: Text(
                e,
                style: TextStyle(color: Colors.white),
              ),
              onSelected: (b) {}))
          .toList(),
    );
  }

  Widget get pokemonWeaknessesFilterChipRow {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: pokemon!.weaknesses!
          .map((e) => FilterChip(
              backgroundColor: Colors.cyan,
              label: Text(
                e,
                style: TextStyle(color: Colors.white),
              ),
              onSelected: (b) {}))
          .toList(),
    );
  }

  Widget get pokemonNextEvolutionFilterChipRow {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: pokemon!.nextEvolution!
          .map((e) => FilterChip(
              backgroundColor: Colors.blueAccent,
              label: Text(
                e.name!,
                style: TextStyle(color: Colors.white),
              ),
              onSelected: (b) {}))
          .toList(),
    );
  }

  Align _pokemonPictureAlign() {
    return Align(
      alignment: Alignment.topCenter,
      child: Hero(
        tag: pokemon!.img!,
        child: Container(
          width: 200,
          height: 200,
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: NetworkImage(pokemon!.img!, scale: 2),
            ),
          ),
        ),
      ),
    );
  }
}

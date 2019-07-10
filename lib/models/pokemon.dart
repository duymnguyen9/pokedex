class Pokemon {
  //https://assets.pokemon.com/assets/cms2/img/pokedex/full/003.png
  final List<PokemonType> types;
  final List<PokemonStat> stats;
  final List<PokemonMove> moves;
  final List<PokemonAbility> abilities;
  final PokemonSprite sprites;
  final int id;
  final String name;
  final String imgUrl;

  final String description;
  final String evolutionUrl;
  final int genderRate;
  final List<String> eggGroup;
  final int hatchCycle;
  final String habitat;
  final String generation;
  final int captureRate;

  // String imgUrlBuild(int id){
  // //https://www.serebii.net/art/th/300.png
  // String baseImgUrl2 = 'https://www.serebii.net/art/th/';

  // //https://assets.pokemon.com/assets/cms2/img/pokedex/full/300.png
  // String baseImgUrl ='https://assets.pokemon.com/assets/cms2/img/pokedex/full/';
  // String idString = id.toString().padLeft(3, '0');
  //   String completeUrl = baseImgUrl + idString + '.png';
  //   return completeUrl;
  // }

  Pokemon(
      {this.id,
      this.name,
      this.description,
      this.evolutionUrl,
      this.genderRate,
      this.eggGroup,
      this.hatchCycle,
      this.habitat,
      this.generation,
      this.captureRate,
      this.types,
      this.stats,
      this.moves,
      this.abilities,
      this.sprites,
      this.imgUrl});

  factory Pokemon.fromJson(
      {Map<String, dynamic> pokemonJson, Map<String, dynamic> speciesJson}) {
    var typesFromJson = pokemonJson['types'] as List;
    List<PokemonType> pokemonTypes =
        typesFromJson.map((i) => PokemonType.fromJson(i)).toList();
    var statsFromJson = pokemonJson['stats'] as List;
    List<PokemonStat> pokemonStats =
        statsFromJson.map((i) => PokemonStat.fromJson(i)).toList();
    var movesFromJson = pokemonJson['moves'] as List;
    List<PokemonMove> pokemonMoves =
        movesFromJson.map((i) => PokemonMove.fromJson(i)).toList();
    var abilitiesFromJson = pokemonJson['abilities'] as List;
    List<PokemonAbility> pokemonAbilities =
        abilitiesFromJson.map((i) => PokemonAbility.fromJson(i)).toList();
    var eggGroupFromJson = speciesJson['egg_groups'] as List;
    List<String> pokemonEggGroup = eggGroupFromJson.map((i) => i['name'].toString()).toList();

    String baseImgUrl =
        'https://assets.pokemon.com/assets/cms2/img/pokedex/full/';
    String idString = pokemonJson['id'].toString().padLeft(3, '0');

    return Pokemon(
        name: pokemonJson['name'],
        id: pokemonJson['id'],
        types: pokemonTypes,
        stats: pokemonStats,
        moves: pokemonMoves,
        abilities: pokemonAbilities,
        sprites: PokemonSprite.fromJson(pokemonJson['sprites']),
        description: speciesJson['flavor_text_entries'][1]['flavor_text'],
        evolutionUrl: speciesJson['evolution_chain']['url'],
        genderRate: speciesJson['gender_rate'],
        eggGroup: pokemonEggGroup,
        hatchCycle: speciesJson['hatch_counter'],
        habitat: speciesJson['habitat']['name'],
        captureRate: speciesJson['capture_rate'],
        imgUrl: baseImgUrl + idString + '.png');
  }
}

class PokemonType {
  final String typeName;
  final String typeUrl;
  final int slot;
  PokemonType({this.slot, this.typeName, this.typeUrl});

  factory PokemonType.fromJson(Map<String, dynamic> json) {
    var typefromJson = json['type'];
    return PokemonType(
      typeName: typefromJson['name'],
      typeUrl: typefromJson['url'],
      slot: json['slot'],
    );
  }
}

class PokemonStat {
  final String name;
  final int value;

  PokemonStat({this.name, this.value});

  factory PokemonStat.fromJson(Map<String, dynamic> json) {
    var statName = json['stat'];
    return PokemonStat(name: statName['name'], value: json['base_stat']);
  }
}

class PokemonMove {
  final String levelLearned;
  final String name;

  PokemonMove({this.levelLearned, this.name});

  factory PokemonMove.fromJson(Map<String, dynamic> json) {
    var versionGroupList = json['version_group_details'][0];
    return PokemonMove(
        levelLearned: versionGroupList['level_learned_at'].toString(),
        name: json['move']['name']);
  }
}

class PokemonAbility {
  final String name;
  final bool isHidden;

  PokemonAbility({this.name, this.isHidden});

  factory PokemonAbility.fromJson(Map<String, dynamic> json) {
    return PokemonAbility(
        name: json['ability']['name'], isHidden: json['is_hidden']);
  }
}

class PokemonSprite {
  final String frontUrl;
  final String shinyUrl;

  PokemonSprite({this.frontUrl, this.shinyUrl});

  factory PokemonSprite.fromJson(Map<String, dynamic> json) {
    return PokemonSprite(
        frontUrl: json['front_default'], shinyUrl: json['front_shiny']);
  }
}

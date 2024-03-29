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
  final List<Map<String, String>> evolutionList;
  final int genderRate;
  final List<String> eggGroup;
  final int hatchCycle;
  final String habitat;
  final String generation;
  final int captureRate;
  final int height;

  Pokemon(
      {this.id,
      this.name,
      this.description,
      this.evolutionList,
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
      this.imgUrl,
      this.height});

  factory Pokemon.fromJson(
      {Map<String, dynamic> pokemonJson,
      Map<String, dynamic> speciesJson,
      Map<String, String> abilitiesFlavor,
      List<Map<String, String>> evolution}) {
    var typesFromJson = pokemonJson['types'] as List;
    List<PokemonType> pokemonTypes =
        typesFromJson.map((i) => PokemonType.fromJson(i)).toList();
        pokemonTypes.sort((a, b) => a.slot.compareTo(b.slot));
    var statsFromJson = pokemonJson['stats'] as List;
    List<PokemonStat> pokemonStats =
        statsFromJson.map((i) => PokemonStat.fromJson(i)).toList();
    var movesFromJson = pokemonJson['moves'] as List;
    List<PokemonMove> pokemonMoves =
        movesFromJson.map((i) => PokemonMove.fromJson(i)).toList();
    var abilitiesFromJson = pokemonJson['abilities'] as List;

    List<PokemonAbility> pokemonAbilities = [];
    for (var ability in abilitiesFromJson) {
      pokemonAbilities.add(PokemonAbility.fromJson(
          ability, abilitiesFlavor[ability['ability']['name']]));
    }
    // List<PokemonAbility> pokemonAbilities =
    //     abilitiesFromJson.map((i) => PokemonAbility.fromJson(i)).toList();
    var eggGroupFromJson = speciesJson['egg_groups'] as List;

    int convertEggGroupUrlToInt(String inputUrl) {
      return int.parse(inputUrl
          .replaceAll('https://pokeapi.co/api/v2/egg-group/', '')
          .replaceAll('/', ''));
    }

    List<Map> pokemonEggGroupMapList = eggGroupFromJson
        .map((i) => {
              'eggGroup': i['name'].toString(),
              'index': convertEggGroupUrlToInt(i['url'])
            })
        .toList();
    pokemonEggGroupMapList.sort((a, b) => a['index'].compareTo(b['index']));
    List<String> pokemonEggGroup() {
      List<String> outputList = [];
      for (var element in pokemonEggGroupMapList) {
        outputList.add(element['eggGroup']);
      }
      return outputList;
    }

    String baseImgUrl =
        'https://assets.pokemon.com/assets/cms2/img/pokedex/full/';
    String idString = pokemonJson['id'].toString().padLeft(3, '0');

    var pokemonFlavor = speciesJson['flavor_text_entries']
        .firstWhere((flavorEntry) => (flavorEntry["language"]["name"]=="en"), orElse: () => null);
    return Pokemon(
        name: pokemonJson['name'],
        id: pokemonJson['id'],
        types: pokemonTypes,
        stats: pokemonStats,
        moves: pokemonMoves,
        abilities: pokemonAbilities,
        sprites: PokemonSprite.fromJson(pokemonJson['sprites']),
        description: pokemonFlavor['flavor_text'],
        evolutionList: evolution,
        genderRate: speciesJson['gender_rate'],
        eggGroup: pokemonEggGroup(),
        hatchCycle: speciesJson['hatch_counter'],
        habitat: speciesJson['habitat']['name'],
        captureRate: speciesJson['capture_rate'],
        imgUrl: baseImgUrl + idString + '.png',
        height: pokemonJson['height'],
        generation: 'Generation ' +
            speciesJson['generation']['url']
                .replaceAll('https://pokeapi.co/api/v2/generation/', '')
                .replaceAll('/', ''));
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
  final String url;

  PokemonMove({this.levelLearned, this.name, this.url});

  factory PokemonMove.fromJson(Map<String, dynamic> json) {
    var versionGroupList = json['version_group_details'][0];
    return PokemonMove(
        levelLearned: versionGroupList['level_learned_at'].toString(),
        name: json['move']['name'],
        url: json['move']['url']);
  }
}

class PokemonAbility {
  final String name;
  final bool isHidden;
  final int slot;
  final String description;

  PokemonAbility({this.slot, this.description, this.name, this.isHidden});

  factory PokemonAbility.fromJson(Map<String, dynamic> json, String flavor) {
    return PokemonAbility(
        name: json['ability']['name'],
        slot: json['slot'],
        isHidden: json['is_hidden'],
        description: flavor);
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


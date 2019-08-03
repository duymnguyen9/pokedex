class PokemonMoveDetail {
  final int id;
  final String name;
  final String type;
  final String description;
  final int basePower;
  final int accuracy;
  final int pp;

  PokemonMoveDetail(
      {this.id,
      this.name,
      this.type,
      this.description,
      this.basePower,
      this.accuracy,
      this.pp});
      
      factory PokemonMoveDetail.fromJson({Map<String, dynamic> json}){
        var descriptionText = json['flavor_text_entries']
        .firstWhere((flavorEntry) => (flavorEntry["language"]["name"]=="en"), orElse: () => null)["flavor_text"];


        return PokemonMoveDetail(
          id: json["id"],
          name: json["name"],
          description: descriptionText,
          type: json["type"]["name"],
          basePower: json["power"],
          accuracy:  json["accuracy"],
          pp: json["pp"]
        );
      }

}

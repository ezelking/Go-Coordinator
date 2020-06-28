class Player {
  String name;
  int playerStrength;

  Player(this.name, this.playerStrength);

  Map<String, dynamic> toJson() => {
        'name': name,
        'playerStrength': playerStrength,
      };
}

class Player {
  String name;
  int playerStrength;

  Player(this.name, this.playerStrength);

  Player.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        playerStrength = json['playerStrength'];

  Map<String, dynamic> toJson() => {
        'name': name,
        'playerStrength': playerStrength,
      };
}

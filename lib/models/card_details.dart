class CardDetails {
  String cardId;
  String dbfId;
  String name;
  String cardSet;
  int cost;
  String type;
  String faction;
  String rarity;
  int attack;
  int health;
  String text;
  String race;
  String playerClass;
  String img;
  String imgGold;
  bool collectible;
  bool elite;
  String artist;
  String flavor;
  String locale;
  List<Mechanics> mechanics;

  CardDetails(
      {this.cardId,
      this.dbfId,
      this.collectible,
      this.name,
      this.elite,
      this.artist,
      this.cardSet,
      this.type,
      this.cost,
      this.faction,
      this.rarity,
      this.attack,
      this.health,
      this.text,
      this.race,
      this.playerClass,
      this.img,
      this.imgGold,
      this.locale,
      this.flavor,
      this.mechanics});

  CardDetails.fromJson(Map<String, dynamic> json) {
    cardId = json['cardId'];
    dbfId = json['dbfId'];
    elite = json['elite'];
    collectible = json['collectible'];
    name = json['name'];
    artist = json['artist'];
    flavor = json['flavor'];
    cardSet = json['cardSet'];
    type = json['type'];
    faction = json['faction'];
    rarity = json['rarity'];
    attack = json['attack'];
    cost = json['cost'];
    health = json['health'];
    text = json['text'];
    race = json['race'];
    playerClass = json['playerClass'];
    img = json['img'];
    imgGold = json['imgGold'];
    locale = json['locale'];
    if (json['mechanics'] != null) {
      mechanics = new List<Mechanics>();
      json['mechanics'].forEach((v) {
        mechanics.add(new Mechanics.fromJson(v));
      });
    }
  }
}

class Mechanics {
  String name;

  Mechanics({this.name});

  Mechanics.fromJson(Map<String, dynamic> json) {
    name = json['name'];
  }
}

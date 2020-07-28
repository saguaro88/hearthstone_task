class AllCards {
  List<SingleCard> allCards = new List();

  AllCards();

  AllCards.fromJson(Map<String, dynamic> json, List<String> cardSets) {
    for (String cardSet in cardSets) {
      if (json['$cardSet'] != null) {
        json['$cardSet'].forEach((v) {
          if (SingleCard
              .fromJson(v)
              .type == 'Minion' ||
              SingleCard
                  .fromJson(v)
                  .type == 'Spell') {
            SingleCard card = SingleCard.fromJson(v);
            if (SingleCard
                .fromJson(v)
                .rarity == "Free") card.rarityValue = 0;
            if (SingleCard
                .fromJson(v)
                .rarity == "Common") card.rarityValue = 1;
            if (SingleCard
                .fromJson(v)
                .rarity == "Rare") card.rarityValue = 2;
            if (SingleCard
                .fromJson(v)
                .rarity == "Epic") card.rarityValue = 3;
            if (SingleCard
                .fromJson(v)
                .rarity == "Legendary")
              card.rarityValue = 4;
            allCards.add(card);
          }
        });
      }
    }
  }
}

class SingleCard {
  String name;
  String img;
  String type;
  String cardId;
  String playerClass;
  String cardSet;
  int attack;
  int manaCost;
  int health;
  String rarity;
  int rarityValue;

  SingleCard({this.name,
    this.img,
    this.type,
    this.cardId,
    this.playerClass,
    this.cardSet,
    this.attack,
    this.health,
    this.manaCost,
    this.rarity});

  SingleCard.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    img = json['img'];
    type = json['type'];
    cardId = json['cardId'];
    playerClass = json['playerClass'];
    cardSet = json['cardSet'];
    attack = json['attack'];
    health = json['health'];
    manaCost = json['cost'];
    rarity = json['rarity'];
  }
}

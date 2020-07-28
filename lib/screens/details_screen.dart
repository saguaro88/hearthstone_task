import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:heartstone_task/models/card_details.dart';
import '../models/card_details.dart';
import '../services/init.dart';

class CardDetailsScreen extends StatelessWidget {
  String cardId;
  CardDetailsScreen(String cardId) {
    this.cardId = cardId;
  }
  Future<CardDetails> _getData() async {
    var c = new InitService.from(cardId);
    await c.initializationDone2;
    return c.cardDetails;
  }

  Widget buildInfo(String text1, String text2) {
    return Column(
      children: [
        Text(text1,
            style: TextStyle(
                foreground: Paint()..shader = linearGradient1,
                fontWeight: FontWeight.bold,
                fontSize: 20,
                fontFamily: 'MyFonts')),
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Text(text2,
              style: TextStyle(
                  foreground: Paint()..shader = linearGradient1,
                  fontFamily: 'MyFonts')),
        ),
      ],
    );
  }

  final Shader linearGradient1 = LinearGradient(
    colors: <Color>[Color(0xffffffff), Color(0xff8c4502)],
  ).createShader(Rect.fromLTWH(0.0, 0.0, 350.0, 10.0));

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/background2.png"), fit: BoxFit.fill)),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: FutureBuilder<CardDetails>(
              future: _getData(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: <Widget>[
                          Padding(
                              padding: EdgeInsets.only(top: 60),
                              child: Text(snapshot.data.name,
                                  style: TextStyle(
                                      fontSize: 42,
                                      fontFamily: 'MyFonts',
                                      color: Colors.lightBlue[50]),
                                  textAlign: TextAlign.center)),
                          FadeInImage.assetNetwork(
                              placeholder: 'assets/no_image.png',
                              image: snapshot.data.imgGold,
                              fit: BoxFit.contain),
                        ],
                      ),
                      new Expanded(
                          child: GridView.count(
                        crossAxisCount: 3,
                        padding: EdgeInsets.all(2),
                        children: <Widget>[
                          if (snapshot.data.attack != null) ...[
                            buildInfo("Attack:", "${snapshot.data.attack}")
                          ],
                          if (snapshot.data.health != null) ...[
                            buildInfo("Health:", "${snapshot.data.health}")
                          ],
                          if (snapshot.data.cardSet != null) ...[
                            buildInfo("Card Set:", "${snapshot.data.cardSet}")
                          ],
                          if (snapshot.data.type != null) ...[
                            buildInfo("Type:", "${snapshot.data.type}")
                          ],
                          if (snapshot.data.cost != null) ...[
                            buildInfo("Cost:", "${snapshot.data.cost}")
                          ],
                          if (snapshot.data.faction != null) ...[
                            buildInfo("Faction:", "${snapshot.data.faction}")
                          ],
                          if (snapshot.data.playerClass != null) ...[
                            buildInfo(
                                "Player class:", "${snapshot.data.playerClass}")
                          ],
                          if (snapshot.data.rarity != null) ...[
                            buildInfo("Rarity:", "${snapshot.data.rarity}")
                          ],
                          if (snapshot.data.race != null) ...[
                            buildInfo("Race:", "${snapshot.data.race}")
                          ],
                          if (snapshot.data.artist != null) ...[
                            buildInfo("Artist:", "${snapshot.data.artist}")
                          ],
                          if (snapshot.data.cardId != null) ...[
                            buildInfo("Card ID:", "${snapshot.data.cardId}")
                          ],
                          if (snapshot.data.flavor != null) ...[
                            buildInfo("Flavor:", "${snapshot.data.flavor}")
                          ],
                          if (snapshot.data.collectible != null) ...[
                            buildInfo(
                                "Collectible:", "${snapshot.data.collectible}")
                          ],
                          if (snapshot.data.elite != null) ...[
                            buildInfo("Elite:", "${snapshot.data.elite}")
                          ],
                        ],
                      ))
                    ],
                  );
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              }),
        ),
      ),
    ));
  }
}

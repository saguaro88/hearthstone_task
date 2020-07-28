import 'dart:convert';
import 'package:heartstone_task/models/card.dart';
import 'package:heartstone_task/models/card_details.dart';
import 'package:heartstone_task/models/info.dart';
import 'package:http/http.dart';
import '../models/card_details.dart';

class APIService {
  final String infoURL = "https://omgvamp-hearthstone-v1.p.rapidapi.com/info";
  final String cardsURL = "https://omgvamp-hearthstone-v1.p.rapidapi.com/cards";
  final String cardDetailsURL =
      "https://omgvamp-hearthstone-v1.p.rapidapi.com/cards/";
  Info info;
  Map<String, String> headers = {
    "x-rapidapi-host": "omgvamp-hearthstone-v1.p.rapidapi.com",
    "x-rapidapi-key": "11842f6726mshe11ef422caf16bap1fdc34jsn29ec2ab36f6c"
  };

  Future<Info> getInfo() async {
    Response res = await get(infoURL, headers: headers);
    if (res.statusCode == 200) {
      return Info.fromJson(json.decode(res.body));
    } else {
      throw Exception('Failed to load info');
    }
  }

  Future<AllCards> getAllCards(List<String> cardSets) async {
    Response res = await get(cardsURL, headers: headers);
    if (res.statusCode == 200) {
      return AllCards.fromJson(json.decode(res.body), cardSets);
    } else {
      throw Exception('Failed to load cards');
    }
  }

  Future<CardDetails> getCardDetails(String cardId) async {
    Response res = await get(cardDetailsURL + cardId, headers: headers);
    if (res.statusCode == 200) {
      return CardDetails.fromJson(json.decode(res.body)[0]);
    } else {
      throw Exception('Failed to load details');
    }
  }
}

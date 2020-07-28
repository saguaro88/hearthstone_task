import 'package:heartstone_task/models/card.dart';
import 'package:heartstone_task/models/info.dart';
import 'package:heartstone_task/services/api_service.dart';
import 'package:lombok/lombok.dart';
import '../models/card_details.dart';

@getter
class InitService {
  Future _doneFuture;
  Future _doneFuture2;
  Info info = new Info();
  CardDetails cardDetails = new CardDetails();
  APIService apiService = new APIService();
  AllCards allCards = new AllCards();
  InitService() {
    _doneFuture = _init();
  }
  InitService.from(String cardId) {
    _doneFuture2 = _getDetails(cardId);
  }

  Future _init() async {
    info = await apiService.getInfo();
    allCards = await apiService.getAllCards(info.sets);
  }

  Future _getDetails(String cardId) async {
    cardDetails = await apiService.getCardDetails(cardId);
  }

  Future get initializationDone => _doneFuture;
  Future get initializationDone2 => _doneFuture2;
}

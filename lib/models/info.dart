import 'package:lombok/lombok.dart';

@getter
@setter
class Info {
  String patch;
  List<String> classes;
  List<String> sets;
  List<String> standard;
  List<String> wild;
  List<String> types;
  List<String> factions;
  List<String> qualities;
  List<String> races;
  List<String> locales;

  Info(
      {this.patch,
      this.classes,
      this.sets,
      this.standard,
      this.wild,
      this.types,
      this.factions,
      this.qualities,
      this.races,
      this.locales});

  Info.fromJson(Map<String, dynamic> json) {
    patch = json['patch'];
    classes = json['classes'].cast<String>();
    sets = json['sets'].cast<String>();
    standard = json['standard'].cast<String>();
    wild = json['wild'].cast<String>();
    types = json['types'].cast<String>();
    factions = json['factions'].cast<String>();
    qualities = json['qualities'].cast<String>();
    races = json['races'].cast<String>();
    locales = json['locales'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['patch'] = this.patch;
    data['classes'] = this.classes;
    data['sets'] = this.sets;
    data['standard'] = this.standard;
    data['wild'] = this.wild;
    data['types'] = this.types;
    data['factions'] = this.factions;
    data['qualities'] = this.qualities;
    data['races'] = this.races;
    data['locales'] = this.locales;
    return data;
  }
}

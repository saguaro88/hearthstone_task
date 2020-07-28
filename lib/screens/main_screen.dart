import 'package:flutter/material.dart';
import 'package:heartstone_task/models/card.dart';
import 'package:heartstone_task/models/info.dart';
import 'package:heartstone_task/services/init.dart';
import 'details_screen.dart';

class MainScreen extends StatefulWidget {
  MainScreen({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  Future _future;
  List<String> _filters = ['None', 'Class', 'Set'];
  List<String> _sortOptions = ['Mana cost', 'Rarity', 'Attack', 'Health'];
  List<String> _sortMode = ['Low-High', 'High-Low'];
  List<String> _classes = new List();
  List<String> _sets = new List();
  List<SingleCard> cardsForDisplay = new List();
  List<SingleCard> beforeSort = new List();
  String _selectedFilter;
  String _selectedFilter2;

  PageController pageController =
  PageController(initialPage: 1, viewportFraction: 0.6);
  List<SingleCard> allCards = new List();
  Info info = new Info();

  Future<List<SingleCard>> getData() async {
    var c = new InitService();
    await c.initializationDone;
    _classes = c.info.classes;
    _sets = c.info.sets;
    allCards = c.allCards.allCards;
    cardsForDisplay = c.allCards.allCards;
    return c.allCards.allCards;
  }

  @override
  void initState() {
    super.initState();
    _future = getData();
  }

  void filterBy(String category, String value) {
    cardsForDisplay = allCards;
    setState(() {
      List<SingleCard> tempList = new List();
      switch (category) {
        case "None":
          cardsForDisplay = allCards;
          break;
        case "Class":
          for (SingleCard card in allCards)
            if (card.playerClass == value) tempList.add(card);
          cardsForDisplay = tempList;
          break;
        case "Set":
          for (SingleCard card in allCards)
            if (card.cardSet == value) tempList.add(card);
          cardsForDisplay = tempList;
          break;
      }
      beforeSort = cardsForDisplay;
      _selectedFilter = null;
      _selectedFilter2 = null;
    });
  }

  void sortBy(String sortBy, String sortMode) {
    setState(() {
      if (beforeSort.isNotEmpty) cardsForDisplay = beforeSort;
      switch (sortBy) {
        case "Mana cost":
          sortMode == "Low-High"
              ? {
                  cardsForDisplay.sort((a, b) {
                    if (a.manaCost == null && b.manaCost == null) return 0;
                    if (a.manaCost == null && b.manaCost != null) return -1;
                    if (a.manaCost != null && b.manaCost == null) return 1;
                    return a.manaCost.compareTo(b.manaCost);
                  })
                }
              : {
                  cardsForDisplay.sort((a, b) {
                    if (a.manaCost == null && b.manaCost == null) return 0;
                    if (a.manaCost == null && b.manaCost != null) return 1;
                    if (a.manaCost != null && b.manaCost == null) return -1;
                    return b.manaCost.compareTo(a.manaCost);
                  })
                };
          cardsForDisplay = cardsForDisplay
              .where((element) => element.manaCost != null)
              .toList();
          break;
        case "Rarity":
          sortMode == "Low-High"
              ? {
                  cardsForDisplay.sort((a, b) {
                    if (a.rarityValue == null && b.rarityValue == null)
                      return 0;
                    if (a.rarityValue == null && b.rarityValue != null)
                      return -1;
                    if (a.rarityValue != null && b.rarityValue == null)
                      return 1;
                    return a.rarityValue.compareTo(b.rarityValue);
                  })
                }
              : {
                  cardsForDisplay.sort((a, b) {
                    if (a.rarityValue == null && b.rarityValue == null)
                      return 0;
                    if (a.rarityValue == null && b.rarityValue != null)
                      return 1;
                    if (a.rarityValue != null && b.rarityValue == null)
                      return -1;
                    return b.rarityValue.compareTo(a.rarityValue);
                  })
                };
          cardsForDisplay = cardsForDisplay
              .where((element) => element.rarityValue != null)
              .toList();
          break;
        case "Attack":
          sortMode == "Low-High"
              ? {
                  cardsForDisplay.sort((a, b) {
                    if (a.attack == null && b.attack == null) return 0;
                    if (a.attack == null && b.attack != null) return -1;
                    if (a.attack != null && b.attack == null) return 1;
                    return a.attack.compareTo(b.attack);
                  })
                }
              : {
                  cardsForDisplay.sort((a, b) {
                    if (a.attack == null && b.attack == null) return 0;
                    if (a.attack == null && b.attack != null) return 1;
                    if (a.attack != null && b.attack == null) return -1;
                    return b.attack.compareTo(a.attack);
                  })
                };
          cardsForDisplay = cardsForDisplay
              .where((element) => element.attack != null)
              .toList();
          break;
        case "Health":
          sortMode == "Low-High"
              ? {
                  cardsForDisplay.sort((a, b) {
                    if (a.health == null && b.health == null) return 0;
                    if (a.health == null && b.health != null) return -1;
                    if (a.health != null && b.health == null) return 1;
                    return a.health.compareTo(b.health);
                  })
                }
              : {
                  cardsForDisplay.sort((a, b) {
                    if (a.health == null && b.health == null) return 0;
                    if (a.health == null && b.health != null) return 1;
                    if (a.health != null && b.health == null) return -1;
                    return b.health.compareTo(a.health);
                  })
                };
          cardsForDisplay = cardsForDisplay
              .where((element) => element.health != null)
              .toList();
          break;
      }
      _selectedFilter = null;
      _selectedFilter2 = null;
    });
  }

  void sortList() {
    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        builder: (context) {
          return AlertDialog(
            title: new Text("Sort by"),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)),
            actions: [
              FlatButton(
                child: Text("Ok"),
                onPressed: () {
                  sortBy(_selectedFilter, _selectedFilter2);
                  Navigator.of(context).pop();
                },
              ),
            ],
            content: StatefulBuilder(
                builder: (BuildContext context, StateSetter setState) {
              return Container(
                child: new SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: new Column(
                    children: <Widget>[
                      DropdownButtonFormField<String>(
                        value: _selectedFilter,
                        style: TextStyle(color: Colors.black87),
                        items: _sortOptions
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (String newValue) {
                          setState(() {
                            _selectedFilter = newValue;
                          });
                        },
                      ),
                      DropdownButtonFormField<String>(
                        value: _selectedFilter2,
                        style: TextStyle(color: Colors.black87),
                        items: _sortMode
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (String newValue) {
                          setState(() {
                            _selectedFilter2 = newValue;
                          });
                        },
                      )
                    ],
                  ),
                ),
              );
            }),
          );
        });
  }

  void filterList() {
    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        builder: (context) {
          return AlertDialog(
            title: new Text("Filter by"),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)),
            actions: [
              FlatButton(
                child: Text("Ok"),
                onPressed: () {
                  filterBy(_selectedFilter, _selectedFilter2);
                  Navigator.of(context).pop();
                },
              ),
            ],
            content: StatefulBuilder(
                builder: (BuildContext context, StateSetter setState) {
              return Container(
                child: new SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: new Column(
                    children: <Widget>[
                      DropdownButtonFormField<String>(
                        value: _selectedFilter,
                        style: TextStyle(color: Colors.black87),
                        items: _filters
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (String newValue) {
                          setState(() {
                            _selectedFilter = newValue;
                          });
                        },
                      ),
                      if (_selectedFilter == 'Class') ...[
                        DropdownButtonFormField<String>(
                          value: _selectedFilter2,
                          style: TextStyle(color: Colors.black87),
                          items: _classes
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (String newValue) {
                            setState(() {
                              _selectedFilter2 = newValue;
                            });
                          },
                        )
                      ],
                      if (_selectedFilter == 'Set') ...[
                        DropdownButtonFormField<String>(
                          value: _selectedFilter2,
                          style: TextStyle(color: Colors.black87),
                          items: _sets
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (String newValue) {
                            setState(() {
                              _selectedFilter2 = newValue;
                            });
                          },
                        )
                      ]
                    ],
                  ),
                ),
              );
            }),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: FutureBuilder<List<SingleCard>>(
            future: _future,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Stack(
                  children: <Widget>[
                    PageView.builder(
                      controller: pageController,
                      itemCount: cardsForDisplay.length,
                      itemBuilder: (context, position) {
                        return AnimatedBuilder(
                          animation: pageController,
                          builder: (context, widget) {
                            double value = 1;
                            if (pageController.position.haveDimensions) {
                              value = pageController.page - position;
                              value = (1 - (value.abs() * 0.4)).clamp(0.0, 1.0);
                            }
                            return Center(
                                child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => CardDetailsScreen(
                                            cardsForDisplay[position].cardId)));
                              },
                              child: SizedBox(
                                height: Curves.easeInOut.transform(value) * 600,
                                width: Curves.easeInOut.transform(value) * 307,
                                child: widget,
                              ),
                            ));
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.all(10.0),
                                child: FadeInImage.assetNetwork(
                                    placeholder: 'assets/no_image.png',
                                    image: cardsForDisplay[position].img,
                                    fit: BoxFit.contain),
                              ),
                              Text(
                                cardsForDisplay[position].name,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 32,
                                  fontFamily: "MyFonts",
                                  color: Colors.lightBlue[50],
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        padding: EdgeInsets.all(16),
                        color: Colors.transparent,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              height: 60,
                              width: 150,
                              margin: EdgeInsets.all(16),
                              child: FlatButton(
                                child: Text('Filter'),
                                color: Colors.blueAccent,
                                textColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30.0),
                                    side: BorderSide(color: Colors.blueAccent)),
                                onPressed: () {
                                  setState(() {
                                    filterList();
                                  });
                                },
                              ),
                            ),
                            Container(
                              height: 60,
                              width: 150,
                              margin: EdgeInsets.all(20),
                              child: FlatButton(
                                child: Text(
                                  'Sort',
                                  style: TextStyle(),
                                ),
                                color: Colors.blueAccent,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30.0),
                                    side: BorderSide(color: Colors.blueAccent)),
                                textColor: Colors.white,
                                onPressed: () => {sortList()},
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              } else
                return Center(child: CircularProgressIndicator());
            },
          ),
        ));
  }
}

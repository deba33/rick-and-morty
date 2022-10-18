import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:rick_n_morty/medium_text.dart';
import 'package:rick_n_morty/option_container.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool visibility = true;
  int randomNumber = 1;
  double score = 0;
  Color option1Color = Colors.white;
  Color option2Color = Colors.white;
  Color option3Color = Colors.white;

  // initial Data
  Map<String, dynamic> extractedChData = {
    "id": 1,
    "name": "Rick Sanchez",
    "status": "Alive",
    "species": "Human",
    "type": "",
    "gender": "Male",
    "origin": {
      "name": "Earth (C-137)",
      "url": "https://rickandmortyapi.com/api/location/1"
    },
    "location": {
      "name": "Citadel of Ricks",
      "url": "https://rickandmortyapi.com/api/location/3"
    },
    "image": "https://rickandmortyapi.com/api/character/avatar/1.jpeg",
    "url": "https://rickandmortyapi.com/api/character/1",
    "created": "2017-11-04T18:48:46.250Z"
  };
  // function to get random characters with generated random character id from api
  randomazier() async {
    setState(() {
      randomNumber = Random().nextInt(826);
    });
    final url =
        Uri.parse('https://rickandmortyapi.com/api/character/$randomNumber');
    final response = await http.get(url);
    final extractedData = json.decode(response.body) as Map<String, dynamic>;
    setState(() {
      extractedChData = extractedData;
    });
  }

// delay the visibility
  delayedVisible() {
    Future.delayed(
        const Duration(
          seconds: 1,
        ), () {
      setState(() {
        visibility = false;
      });
    });
  }

  //score increment
  addScore() {
    setState(() {
      score = score + 1;
    });
  }

  //score decrement
  subtractScore() {
    setState(() {
      score = score - 0.5;
    });
  }

  @override
  void initState() {
    randomazier();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Score : $score'),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 9,
            child: Center(
              child: Container(
                padding: const EdgeInsets.only(
                  top: 5,
                  bottom: 20,
                ),
                height: MediaQuery.of(context).size.height * 0.9,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      //Character Image
                      FadeInImage(
                        height: 275,
                        fit: BoxFit.contain,
                        width: 300,
                        placeholder: const AssetImage('assets/images/189.jpeg'),
                        image: NetworkImage(extractedChData['image']),
                      ),
                      // Character Name
                      Container(
                        margin: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Theme.of(context).primaryColor,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.all(5),
                        height: 50,
                        width: 300,
                        child: Center(
                          child: Text(
                            '${extractedChData['name']}',
                            textScaleFactor: 1.2,
                            overflow: TextOverflow.fade,
                            style: const TextStyle(
                              // color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),

                      Stack(
                        children: [
                          // Character Information
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 300,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        CircleAvatar(
                                          radius: 7,
                                          backgroundColor:
                                              extractedChData['status'] ==
                                                      'Dead'
                                                  ? Colors.red
                                                  : extractedChData['status'] ==
                                                          'Alive'
                                                      ? Colors.green
                                                      : Colors.grey,
                                        ),
                                        MediumText(
                                            text:
                                                ' ${extractedChData['status']}')
                                      ],
                                    ),
                                    MediumText(
                                        text: '${extractedChData['species']}'),
                                    Row(
                                      children: [
                                        MediumText(
                                            text:
                                                '${extractedChData['gender']} '),
                                        Icon(
                                          extractedChData['gender'] == 'Male'
                                              ? Icons.male
                                              : extractedChData['gender'] ==
                                                      'Female'
                                                  ? Icons.female
                                                  : null,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Text(
                                  "Origin : ${extractedChData['origin']['name']}"),
                              const SizedBox(
                                height: 20,
                              ),
                              Text(
                                  "Location : ${extractedChData['location']['name']}"),
                              const SizedBox(
                                height: 20,
                              ),
                              Text(
                                  'Created On : ${extractedChData['created']}'),
                            ],
                          ),
                          // Alive or Dead Quiz
                          Visibility(
                            visible: visibility,
                            child: Container(
                              color: Colors.white,
                              width: MediaQuery.of(context).size.width * 0.85,
                              padding: const EdgeInsets.all(10),
                              child: Column(
                                children: [
                                  const Text(
                                    "Alive or Dead ?",
                                    textScaleFactor: 1.5,
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  // Alive Button
                                  GestureDetector(
                                    onTap: () {
                                      if (option2Color != Colors.white ||
                                          option3Color != Colors.white) {
                                        return;
                                      } else {
                                        if (extractedChData['status'] ==
                                            'Alive') {
                                          setState(() {
                                            option1Color =
                                                Colors.green.shade100;
                                          });
                                          addScore();
                                        } else {
                                          setState(() {
                                            option1Color = Colors.red.shade100;
                                          });
                                          subtractScore();
                                        }
                                        delayedVisible();
                                      }
                                    },
                                    child: OptionContainer(
                                      optionColor: option1Color,
                                      optionText: 'Alive',
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  // Dead Button
                                  GestureDetector(
                                    onTap: () {
                                      if (option1Color != Colors.white ||
                                          option3Color != Colors.white) {
                                        return;
                                      } else {
                                        if (extractedChData['status'] ==
                                            'Dead') {
                                          setState(() {
                                            option2Color =
                                                Colors.green.shade100;
                                          });
                                          addScore();
                                        } else {
                                          setState(() {
                                            option2Color = Colors.red.shade100;
                                          });
                                          subtractScore();
                                        }
                                        delayedVisible();
                                      }
                                    },
                                    child: OptionContainer(
                                      optionColor: option2Color,
                                      optionText: 'Dead',
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  // unknown button
                                  GestureDetector(
                                    onTap: () {
                                      if (option1Color != Colors.white ||
                                          option2Color != Colors.white) {
                                        return;
                                      } else {
                                        if (extractedChData['status'] ==
                                            'unknown') {
                                          setState(() {
                                            option3Color =
                                                Colors.green.shade100;
                                          });
                                          addScore();
                                        } else {
                                          setState(() {
                                            option3Color = Colors.red.shade100;
                                          });
                                          subtractScore();
                                        }
                                        delayedVisible();
                                      }
                                    },
                                    child: OptionContainer(
                                      optionColor: option3Color,
                                      optionText: 'Unknown',
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          // FAN Ad
          const Expanded(
            flex: 1,
            child: Placeholder(),
          )
        ],
      ),
      // randomazie button
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(
          bottom: 55,
        ),
        child: FloatingActionButton(
          onPressed: () {
            randomazier();
            setState(() {
              visibility = true;
              option1Color = Colors.white;
              option2Color = Colors.white;
              option3Color = Colors.white;
            });
          },
          child: const Icon(
            Icons.navigate_next,
          ),
        ),
      ),
    );
  }
}

import 'dart:ui';

import 'package:avatar_glow/avatar_glow.dart';
import 'package:coronavirus/intro_screens.dart';
import 'package:coronavirus/loading.dart';
import 'package:url_launcher/url_launcher.dart';
import 'ambulance.dart';
import 'package:coronavirus/speechtotext.dart';
import 'package:coronavirus/texttospeech.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:speech_to_text/speech_to_text.dart';

class Home extends StatefulWidget {
  String country1;
  Home();
  Home.constructor1(this.country1);

  @override
  _MyHomeState createState() => _MyHomeState();
}

class _MyHomeState extends State<Home> with TickerProviderStateMixin {
  List<String> asia = [
    'Afghanistan',
    'Armenia',
    'Azerbaijan',
    'Bahrain',
    'Bangladesh',
    'Bhutan',
    'Brunei',
    'Cambodia',
    'China',
    'Cyprus',
    'Georgia',
    'India',
    'Indonesia',
    'Iran',
    'Iraq',
    'Israel',
    'Japan',
    'Jordan',
    'Kazakhstan',
    'Kuwait',
    'Kyrgyzstan',
    'Laos',
    'Lebanon',
    'Malaysia',
    'Maldives',
    'Mongolia',
    'Myanmar',
    '(Burma)',
    'Nepal',
    'Oman',
    'Pakistan',
    'Palestine',
    'Philippines',
    'Qatar',
    'Russia',
    'Saudi Arabia',
    'Singapore',
    'South Korea',
    'Sri Lanka',
    'Syria',
    'Taiwan',
    'Tajikistan',
    'Thailand',
    'Timor-Leste',
    'Turkey',
    'Turkmenistan',
    'United Arab Emirates',
    'Uzbekistan',
    'Vietnam',
    'Yemen',
  ];

  List<String> europe = [
    'Albania',
    'Andorra',
    'Armenia',
    'Austria',
    'Azerbaijan',
    'Belarus',
    'Belgium',
    'Bosnia and Herzegovina',
    'Bulgaria',
    'Croatia',
    'Cyprus',
    'Czechia',
    'Denmark',
    'Estonia',
    'Finland',
    'France',
    'Georgia',
    'Germany',
    'Greece',
    'Hungary',
    'Iceland',
    'Ireland',
    'Italy',
    'Kosovo',
    'Latvia',
    'Liechtenstein',
    'Lithuania',
    'Luxembourg',
    'Malta',
    'Moldova',
    'Monaco',
    'Montenegro',
    'Netherlands',
    'North Macedonia',
    'Norway',
    'Poland',
    'Portugal',
    'Romania',
    'Russia',
    'San Marino',
    'Serbia',
    'Slovakia',
    'Slovenia',
    'Spain',
    'Sweden'
        'Switzerland',
    'Turkey',
    'Ukraine',
    'United Kingdom',
    'Vatican City',
  ];

  List<String> northAmerica = [
    'Antigua and Barbuda',
    'Bahamas',
    'Barbados',
    'Belize',
    'Canada',
    'Costa Rica',
    'Cuba',
    'Dominica',
    'Dominican Republic',
    'El Salvador',
    'Grenada',
    'Guatemala',
    'Haiti',
    'Honduras',
    'Jamaica',
    'Mexico',
    'Nicaragua',
    'Panama',
    'Saint Kitts and Nevis',
    'Saint Lucia',
    'Saint Vincent and the Grenadines',
    'Trinidad and Tobago',
    'USA',
  ];

  List<String> southAmerica = [
    'Argentina',
    'Bolivia',
    'Brazil',
    'Chile',
    'Colombia',
    'Ecuador',
    'Guyana',
    'Paraguay',
    'Peru',
    'Suriname',
    'Uruguay',
    'Venezuela',
  ];
  List<String> oceania = [
    'Australia',
    'Fiji',
    'Kiribati',
    'Marshall Islands',
    'Micronesia',
    'Nauru',
    'New Zealand',
    'Palau',
    'Papua New Guinea',
    'Samoa',
    'Solomon Islands',
    'Tonga',
    'Tuvalu',
    'Vanuatu',
  ];

  List<String> africa = [
    'Algeria',
    'Angola',
    'Benin',
    'Botswana',
    'Burkina Faso',
    'Burundi',
    'Cabo Verde',
    'Cameroon',
    'Central African Republic',
    'Chad',
    'Comoros',
    'Democratic Republic of the Congo',
    'Republic of the Congo',
    'Djibouti',
    'Egypt',
    'Equatorial Guinea',
    'Ethiopia',
    'Gabon',
    'Gambia',
    'Ghana',
    'Guinea-Bissau',
    'Ivory Coast',
    'Kenya',
    'Lesotho',
    'Liberia',
    'Libya',
    'Madagascar',
    'Malawi',
    'Mali',
    'Mauritania',
    'Mauritius',
    'Morocco',
    'Mozambique',
    'Namibia',
    'Niger',
    'Nigeria',
    'Rwanda',
    'Sao Tome and Principe',
    'Senegal',
    'Seychelles',
    'Sierra Leone',
    'Somalia',
    'South Africa',
    'South Sudan',
    'Sudan',
    'Tanzania',
    'Togo',
    'Tunisia',
    'Uganda',
    'Zambia',
    'Zimbabwe',
  ];

  String dropdownValue;
  String newCase = "Null", newDeath = "Null", activeCase = "Null";
  final double width = 180.0;
  Map data = {};
  bool _isListening = false;
  String result = '';
  bool notFound = false;
  String savedCountry;
  String number;

  final SpeechToText speech = SpeechToText();
  final FlutterTts outVoice = FlutterTts();
  AnimationController _animationcontroller;
  void updateCase(Map data, String dropdownValue) {
    for (int i = 0; i < 222; i++) {
      if (data['data'][i]['Country_text'] == dropdownValue) {
        newCase = data['data'][i]['New Cases_text'] != ''
            ? data['data'][i]['New Cases_text']
            : '+0';
        newDeath = data['data'][i]['New Deaths_text'] != ''
            ? data['data'][i]['New Deaths_text']
            : '+0';
        activeCase = data['data'][i]['Active Cases_text'];
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _animationcontroller = AnimationController(
      duration: Duration(milliseconds: 1200),
      vsync: this,
    );
    _animationcontroller.forward();
  }

  @override
  void dispose() {
    super.dispose();
    _animationcontroller.dispose();
  }

  //function updateCase

  //function expantile
  Widget expansion(List<String> country, String title, Map continent) {
    return ExpansionTile(
      title: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
      children: [
        ListView.builder(
            shrinkWrap: true,
            itemCount: country.length,
            itemBuilder: (context, index) {
              return Card(
                child: ListTile(
                    title: Text(
                      country[index],
                    ),
                    onTap: () {
                      setState(() {
                        dropdownValue = country[index];
                        number = continent[country[index]];
                        updateCase(data, dropdownValue);
                        Navigator.of(context).pop();
                      });
                    }),
              );
            }),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    data = ModalRoute.of(context).settings.arguments;
    return MaterialApp(
      home: Scaffold(
        endDrawerEnableOpenDragGesture: false,
        backgroundColor: Colors.grey[100],
        appBar: AppBar(
          centerTitle: true,
          titleSpacing: 0.5,
          title: Text(
            'Coronavirus Report',
            style: TextStyle(
                color: Colors.black, fontFamily: 'CreteRound', fontSize: 20),
          ),
          backgroundColor: Colors.grey[100],
          elevation: 0,
          leading: Builder(
            builder: (context) => IconButton(
                icon: SvgPicture.asset('images/menu.svg'),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                }),
          ),
        ),
        drawer: Drawer(
            child: SingleChildScrollView(
          child: Column(
            children: [
              DrawerHeader(
                child: Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.fitWidth,
                          image: AssetImage('images/map.jpg')),
                      borderRadius: BorderRadius.circular(10)),
                ),
              ),
              expansion(europe, 'Europe', mapEurope),
              expansion(asia, 'Asia', mapAsia),
              expansion(africa, 'Africa', mapAfrica),
              expansion(northAmerica, 'North America', mapNorthAmerica),
              expansion(southAmerica, 'South America', mapSouthAmerica),
              expansion(oceania, 'Oceania', mapOceania)
            ],
          ),
        )),
        floatingActionButton: AvatarGlow(
          animate: _isListening,
          endRadius: 60,
          repeat: true,
          glowColor: Colors.green[200],
          child: FloatingActionButton(
            backgroundColor: Colors.green,
            child: Icon(_isListening ? Icons.mic : Icons.mic_none),
            onPressed: () async {
              if (!_isListening) {
                bool available = await speech.initialize();
                if (available) {
                  setState(() {
                    _isListening = true;
                  });

                  speech.listen(
                    listenFor: Duration(seconds: 5),
                    pauseFor: Duration(seconds: 5),
                    partialResults: false,
                    localeId: 'en-US',
                    cancelOnError: true,
                    listenMode: ListenMode.confirmation,
                    onResult: (val) => setState(() {
                      result = val.recognizedWords;
                      showVoiceText(context);

                      _isListening = false;
                      for (int i = 0; i < 222; i++) {
                        if (data['data'][i]['Country_text'] == result) {
                          newCase = data['data'][i]['New Cases_text'] != ''
                              ? data['data'][i]['New Cases_text']
                              : '0';
                          newDeath = data['data'][i]['New Deaths_text'] != ''
                              ? data['data'][i]['New Deaths_text']
                              : '0';
                          activeCase = data['data'][i]['Active Cases_text'];
                          TexttoSpeech speak = TexttoSpeech(result);
                          speak.speakOut(newCase, newDeath, activeCase, result);
                          break;
                        } else if (i == 221 &&
                            data['data'][i]['Country_text'] != result) {
                          outVoice.speak('I cannot find please try again');
                        }
                      }

                      print(result);
                    }),
                  );
                }
              } else
                setState(() {
                  _isListening = false;
                  speech.stop();
                });
            },
            // onPressed: () async {

            // },
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 350,
                width: double.infinity,
                child: Wrap(
                  children: [
                    // First Box
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: SlideTransition(
                        position: Tween<Offset>(
                                begin: Offset(1, 0), end: Offset(0, 0))
                            .animate(_animationcontroller),
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 1,
                                  blurRadius: 2,
                                  offset: Offset(4, 5),
                                )
                              ],
                              gradient: LinearGradient(colors: [
                                Colors.amber[900],
                                Colors.amber[300],
                              ]),
                              borderRadius: BorderRadius.circular(10)),
                          child: Stack(
                            children: [
                              Positioned(
                                bottom: 30,
                                right: 30,
                                child: Container(
                                  height: 50,
                                  width: 50,
                                  decoration: BoxDecoration(
                                    color: Colors.amber[900].withOpacity(0.3),
                                    shape: BoxShape.circle,
                                  ),
                                  child:
                                      SvgPicture.asset('images/pandemic.svg'),
                                ),
                              ),
                              Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Row(
                                      children: [
                                        Text(
                                          "Confirmed Case",
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              fontFamily: 'CreteRound',
                                              fontSize: 18,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Column(
                                          children: [
                                            RichText(
                                              text: TextSpan(
                                                text: newCase == "Null"
                                                    ? data['world_data'][0]
                                                    : newCase,
                                                style: TextStyle(
                                                    color: Colors.amber[200],
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 20),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 5.0,
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    // Second Box
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: SlideTransition(
                        position: Tween<Offset>(
                                begin: Offset(1, 0), end: Offset(0, 0))
                            .animate(_animationcontroller),
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 1,
                                  blurRadius: 2,
                                  offset: Offset(4, 5),
                                )
                              ],
                              gradient: LinearGradient(colors: [
                                Colors.pink[800],
                                Colors.pink[300],
                              ]),
                              borderRadius: BorderRadius.circular(10)),
                          child: Stack(
                            children: [
                              Positioned(
                                bottom: 30,
                                right: 30,
                                child: Container(
                                  height: 50,
                                  width: 50,
                                  decoration: BoxDecoration(
                                    color: Colors.pink[900].withOpacity(0.3),
                                    shape: BoxShape.circle,
                                  ),
                                  child: SvgPicture.asset('images/death.svg'),
                                ),
                              ),
                              Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Row(
                                      children: [
                                        Text(
                                          "Death Case",
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              fontFamily: 'CreteRound',
                                              fontSize: 18,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Column(
                                          children: [
                                            RichText(
                                              text: TextSpan(
                                                text: newDeath == "Null"
                                                    ? data['world_data'][1]
                                                    : newDeath,
                                                style: TextStyle(
                                                    color: Colors.pink[200],
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 20),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 5.0,
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    //third box
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: SlideTransition(
                        position: Tween<Offset>(
                                begin: Offset(1, 0), end: Offset(0, 0))
                            .animate(_animationcontroller),
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 1,
                                  blurRadius: 2,
                                  offset: Offset(4, 5),
                                )
                              ],
                              gradient: LinearGradient(colors: [
                                Colors.green[800],
                                Colors.green[300],
                              ]),
                              borderRadius: BorderRadius.circular(10)),
                          child: Stack(
                            children: [
                              Positioned(
                                bottom: 30,
                                right: 30,
                                child: Container(
                                  height: 50,
                                  width: 50,
                                  decoration: BoxDecoration(
                                    color: Colors.green[900].withOpacity(0.3),
                                    shape: BoxShape.circle,
                                  ),
                                  child: SvgPicture.asset('images/virus.svg'),
                                ),
                              ),
                              Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Row(
                                      children: [
                                        Text(
                                          "Active Case",
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              fontFamily: 'CreteRound',
                                              fontSize: 18,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Column(
                                          children: [
                                            RichText(
                                              text: TextSpan(
                                                text: activeCase == "Null"
                                                    ? data['world_data'][2]
                                                    : activeCase,
                                                style: TextStyle(
                                                    color: Colors.green[200],
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 20),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 5.0,
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              //Preventions
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Preventions',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10.0),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  height: 100,
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          SvgPicture.asset('images/handwash.svg'),
                          SizedBox(
                            height: 10.0,
                          ),
                          Text('Wash Hands',
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontFamily: 'CreteRound')),
                        ],
                      ),
                      Column(
                        children: [
                          SvgPicture.asset(
                            'images/protection.svg',
                            height: 70.0,
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Text('Wear Mask',
                              style: TextStyle(
                                  color: Colors.blue, fontFamily: 'CreteRound'))
                        ],
                      ),
                      Column(
                        children: [
                          SvgPicture.asset(
                            'images/social-distancing.svg',
                            height: 70.0,
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Text('Social-distancing',
                              style: TextStyle(
                                  color: Colors.blue, fontFamily: 'CreteRound'))
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  height: 150,
                  width: double.infinity,
                  child: Stack(
                    children: [
                      Container(
                        height: 150,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 2,
                                blurRadius: 2,
                                offset: Offset(4, 5),
                              )
                            ],
                            gradient: LinearGradient(colors: [
                              Colors.green,
                              Colors.green[900],
                            ]),
                            borderRadius: BorderRadius.circular(5.0)),
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(150.0, 20, 0, 0),
                          child: RichText(
                            text: TextSpan(children: [
                              TextSpan(
                                  text: "Stay Protected",
                                  style: TextStyle(
                                      fontFamily: 'Righteous',
                                      fontSize: 28,
                                      color: Colors.white)),
                              TextSpan(
                                  text: number == null
                                      ? ''
                                      : "\nCall $number for ambulance",
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline6
                                      .copyWith(color: Colors.white))
                            ]),
                          ),
                        ),
                      ),
                      SvgPicture.asset(
                        "images/Doctor.svg",
                        height: 300,
                      ),
                      number == null
                          ? Material()
                          : Positioned(
                              left: 200,
                              bottom: 20,
                              child: ButtonTheme(
                                minWidth: 100,
                                height: 50,
                                child: RaisedButton(
                                  color: Colors.green,
                                  child: Icon(Icons.call_outlined,
                                      color: Colors.white),
                                  onPressed: () {
                                    launch('tel: $number');
                                  },
                                  shape: CircleBorder(),
                                ),
                              ))
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
    );
  }

  showVoiceText(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(
            builder: (context, setState) {
              return AlertDialog(
                title: Text('Name of the country you have spoken'),
                content: Container(
                  child: Text(result),
                ),
                actions: [
                  FlatButton(
                      onPressed: () => {
                            Navigator.pop(context),
                            setState(() {
                              _isListening = false;
                              result = '';
                            })
                          },
                      child: Text('Okay'))
                ],
              );
            },
          );
        });
  }
}

//all functions

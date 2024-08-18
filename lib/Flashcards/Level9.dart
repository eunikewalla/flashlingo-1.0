import 'package:flashlingo1_0/page/LevelPage.dart';
import 'package:flashlingo1_0/quiz/quiz1.dart';
import 'package:flashlingo1_0/settings/ColorScheme.dart';
import 'package:flashlingo1_0/Flashcards/flashSettings/flashcards_view.dart';
import 'package:flutter/material.dart';
import 'package:flip_card/flip_card.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

class Level9 extends StatefulWidget {
  const Level9({Key? key}) : super(key: key);

  @override
  State<Level9> createState() => _Level9();
}

class _Level9 extends State<Level9> {
  List<Map<String, String>> _flashcards = [
    {'question': 'Rumah', 'answer': 'House', 'img': 'house'},
    {'question': 'Sekolah', 'answer': 'School', 'img': 'school'},
    {'question': 'Rumah Sakit', 'answer': 'Hospital', 'img': 'hospital'},
    {'question': 'Taman', 'answer': 'Park', 'img': 'park'},
    {'question': 'Restoran', 'answer': 'Restaurant', 'img': 'restaurant'},
    {'question': 'Kantor Polisi', 'answer': 'Police Station', 'img': 'police'},
    {'question': 'Bandara', 'answer': 'Airport', 'img': 'airport'},
    {'question': 'Pasar', 'answer': 'Market', 'img': 'market'},
    {'question': 'Bioskop', 'answer': 'Cinema', 'img': 'cinema'},
    {'question': 'Pantai', 'answer': 'Beach', 'img': 'beach'},
  ];

  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: lightBlue,
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "PLACES",
            style: TextStyle(fontWeight: FontWeight.w700),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
              size: 30,
            ),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => LevelPage()));
            },
          ),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 350,
                height: 500,
                child: FlipCard(
                  front: Flashcardview(
                    text: _flashcards[_currentIndex]['question']!,
                    img: _flashcards[_currentIndex]['img']!,
                  ),
                  back: Flashcardview(
                    text: _flashcards[_currentIndex]['answer']!,
                    img: _flashcards[_currentIndex]['img']!,
                  ),
                ),
              ),
              SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  OutlinedButton.icon(
                    onPressed: _currentIndex == 0 ? null : showPreviousCard,
                    icon: Icon(Icons.chevron_left),
                    label: Text('Prev'),
                  ),
                  OutlinedButton.icon(
                    onPressed: _currentIndex == _flashcards.length - 1
                        ? showSuccessDialog
                        : showNextCard,
                    icon: Icon(Icons.chevron_right),
                    label: Text('Next'),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  void showNextCard() {
    setState(() {
      _currentIndex = (_currentIndex + 1) % _flashcards.length;
    });
  }

  void showPreviousCard() {
    setState(() {
      _currentIndex =
          (_currentIndex - 1 + _flashcards.length) % _flashcards.length;
    });
  }

  void showSuccessDialog() {
    AwesomeDialog(
      context: context,
      animType: AnimType.leftSlide,
      headerAnimationLoop: false,
      dialogType: DialogType.success,
      showCloseIcon: true,
      title: 'Hore!',
      desc: 'Apakah Kamu Siap uji coba pengetahuanmu dengan kuis seru?',
      buttonsTextStyle: const TextStyle(color: Colors.black),
      btnCancelText: 'Tidak',
      btnOkText: 'Ya',
      btnCancelOnPress: () {},
      btnOkOnPress: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Quiz(level: 9)),
        );
      },
    ).show();
  }
}

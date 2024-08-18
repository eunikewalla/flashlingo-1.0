import 'package:flutter/material.dart';

class Flashcardview extends StatelessWidget {
  final String text;
  final String img;

  Flashcardview({Key? key, required this.text, required this.img})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/$img.png',
            fit: BoxFit.contain,
          ),
          SizedBox(height: 20),
          Center(
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: Colors.blueGrey,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

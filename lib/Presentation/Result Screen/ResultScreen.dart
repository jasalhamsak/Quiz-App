import 'package:flutter/material.dart';
import 'package:confetti/confetti.dart';
import 'package:quizapp/Presentation/Landing%20Page/LandingPage.dart';

class ResultScreen extends StatefulWidget {
  final int score;
  ResultScreen({required this.score});

  @override
  _ResultScreenState createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  late ConfettiController _confettiController;

  @override
  void initState() {
    super.initState();
    _confettiController = ConfettiController(duration: Duration(seconds: 3));
    _confettiController.play();
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        alignment: Alignment.center,
        children: [
          // Confetti Animation
          ConfettiWidget(
            confettiController: _confettiController,
            blastDirectionality: BlastDirectionality.explosive,
            colors: [Colors.red, Colors.blue, Colors.green, Colors.yellow],
          ),

          Padding(
            padding: const EdgeInsets.only(left: 90),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/trophy.png', height: 100), // Trophy Image
                SizedBox(height: 20),
                Text(
                  'Your Score: ${widget.score}',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white),
                ),
                SizedBox(height: 10),
                Text(
                  widget.score >= 2
                      ? "Amazing! You're a pro! 🎉"
                      : widget.score >= 1
                      ? "Great Job! Keep Improving! 💪"
                      : "Nice Try! Try Again! 😃",
                  style: TextStyle(fontSize: 18, color: Colors.white70),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => Landing_page()),
                    );
                  },
                  child: Text('Play Again'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

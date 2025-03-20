import 'package:flutter/material.dart';
import 'dart:async';
import 'package:quizapp/Presentation/Result%20Screen/ResultScreen.dart';
import 'package:quizapp/Presentation/Quiz%20Page/Components/questions_data.dart';

class QuizScreen extends StatefulWidget {
  final String category;

  QuizScreen({required this.category});

  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int currentQuestionIndex = 0;
  int score = 0;
  int timer = 15;
  late Timer questionTimer;
  bool answered = false;
  String? selectedAnswer;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    questionTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (this.timer == 0) {
        nextQuestion();
      } else {
        setState(() {
          this.timer--;
        });
      }
    });
  }

  void nextQuestion() {
    if (currentQuestionIndex < questions[widget.category]!.length - 1) {
      questionTimer.cancel();
      setState(() {
        currentQuestionIndex++;
        timer = 15;
        answered = false;
        selectedAnswer = null;
      });
      startTimer();
    } else {
      questionTimer.cancel();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => ResultScreen(score: score),
        ),
      );
    }
  }

  void checkAnswer(String option) {
    if (!answered) {
      setState(() {
        answered = true;
        selectedAnswer = option;
        if (option == questions[widget.category]![currentQuestionIndex]['answer']) {
          score++;
        }
      });
      questionTimer.cancel();
      Future.delayed(Duration(seconds: 2), () => nextQuestion());
    }
  }

  @override
  Widget build(BuildContext context) {
    var questionData = questions[widget.category]![currentQuestionIndex];
    String correctAnswer = questionData['answer'];

    return Scaffold(
      backgroundColor: Color(0xff202020),
      appBar: AppBar(
        title: Text(widget.category + ' Quiz'),
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Question ${currentQuestionIndex + 1}",
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.white, fontSize: 24),
              ),
            ),
            Container(
              padding: EdgeInsets.all(5),
              width: 340,
              height: 170,
              decoration: BoxDecoration(
                  color: Color(0xffD9D9D9), borderRadius: BorderRadius.circular(30)),
              child: Center(
                child: Text(
                  questionData['question'],
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            SizedBox(height: 50),
            Container(
              width: 400,
              height: 450,
              decoration: BoxDecoration(
                  color: Color(0xffD9D9D9), borderRadius: BorderRadius.circular(30)),
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.all(20),
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.green, width: 4)),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        SizedBox(
                          width: 60,
                          height: 60,
                          child: CircularProgressIndicator(
                            value: timer / 15,
                            strokeWidth: 4,
                            backgroundColor: Colors.grey,
                            valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
                          ),
                        ),
                        Text(
                          "$timer",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                  ...questionData['options'].map<Widget>((option) {
                    bool isCorrect = option == correctAnswer;
                    bool isSelected = option == selectedAnswer;

                    return SizedBox(
                      width: 270,
                      height: 56,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: answered
                                ? (isCorrect
                                ? Colors.green // ✅ Correct answer is always green
                                : (isSelected ? Colors.red : Color(0xff877BFB))) // ❌ Wrong selected = Red, Others = Default
                                : Color(0xff877BFB), // Default color before selection
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onPressed: answered
                              ? null
                              : () {
                            checkAnswer(option);
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              if (answered && (isCorrect || isSelected)) ...[
                                Icon(
                                  isCorrect ? Icons.check_circle : Icons.cancel,
                                  color: isCorrect ? Colors.green : Colors.red, // ✅ Green for correct, ❌ Red for wrong selected
                                ),
                                SizedBox(width: 10), // Space between icon and text
                              ],
                              Text(
                                option,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }).toList(),

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    questionTimer.cancel();
    super.dispose();
  }
}

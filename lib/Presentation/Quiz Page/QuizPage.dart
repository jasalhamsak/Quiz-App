import 'package:flutter/material.dart';
import 'dart:async';
import 'package:quizapp/Presentation/Result%20Screen/ResultScreen.dart';
import 'package:quizapp/Presentation/Quiz Page/Components/questions_data.dart';





class QuizScreen extends StatefulWidget {
  final String category;

  QuizScreen({required this.category});

  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {


  int currentQuestionIndex = 0;
  int score = 0;
  int timer = 1000;
  late Timer questionTimer;
  bool answered = false;

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
        timer = timer;
        answered = false;
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

  void checkAnswer(String selectedAnswer) {
    if (!answered) {
      setState(() {
        answered = true;
        if (selectedAnswer == questions[widget.category]![currentQuestionIndex]['answer']) {
          score++;
        }
      });
      questionTimer.cancel();
      Future.delayed(Duration(seconds: 1), () => nextQuestion());
    }
  }

  @override
  Widget build(BuildContext context) {
    var questionData = questions[widget.category]![currentQuestionIndex];

    return Scaffold(
      backgroundColor: Color(0xff202020),
      appBar: AppBar(title: Text(widget.category + ' Quiz')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Question",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white,fontSize: 24),),
            ),
            Container(
              padding: EdgeInsets.all(5),
              width: 340,
              height: 170,
              decoration: BoxDecoration(
                color: Color(0xffD9D9D9),
                borderRadius: BorderRadius.circular(30)
              ),
              child: Center(
                child: Text(
                  questionData['question'],
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            SizedBox(height: 50,),
            Container(
              width: 400,
              height: 450,
              decoration: BoxDecoration(
                color:Color(0xffD9D9D9),
                borderRadius: BorderRadius.circular(30)
              ),
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.all(20),
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.green,width: 4)
                    ),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        SizedBox(
                          width: 60,
                          height: 60,
                          child: CircularProgressIndicator(
                            value: timer / 15, // Adjust based on your total countdown duration
                            strokeWidth: 4,
                            backgroundColor: Colors.grey, // Faded progress background
                            valueColor: AlwaysStoppedAnimation<Color>(Colors.green), // Green border
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
                  ...questionData['options'].map((option) {
                    return SizedBox(
                      width: 270, // Makes the button expand fully
                      height: 56, // Fixed height for all buttons
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xff877BFB), // Button color
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10), // Optional: Rounded corners
                            ),
                          ),
                          onPressed: () => checkAnswer(option),
                          child: Text(
                            option,
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,color: Colors.white),
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

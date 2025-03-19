import 'package:flutter/material.dart';
import 'package:quizapp/Presentation/Landing%20Page/Components/Components.dart';

class Landing_page extends StatelessWidget {
  const Landing_page({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff4E42C1),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 150.0),
              child: Center(
                  child: Text("Quiz App",style: TextStyle(fontSize: 48,fontWeight: FontWeight.w900,color: Colors.white),)),
            ),
            SizedBox(height: 120),
            Text("Choose Category",style: TextStyle(fontSize: 28,fontWeight: FontWeight.w900,color: Colors.white)),
            CategoryContainer(),
            // SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}

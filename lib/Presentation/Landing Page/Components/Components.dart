import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quizapp/Presentation/Quiz%20Page/QuizPage.dart';

class CategoryContainer extends StatelessWidget {
   CategoryContainer({super.key});

  final List<String> categories=['Cars','Bikes','Sports'];

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView(
        children: categories.map((category){
          return  InkWell(
            onTap: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => QuizScreen(category: category),));
            },
            child: Container(
              margin: EdgeInsets.all(10),
              width: 315,
              height: 60,
              decoration: BoxDecoration(
                  color: Color(0xffD9D9D9),
                  borderRadius: BorderRadius.circular(30)
              ),
              child: Center(
                  child: Text(category,style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w900,
                      color: Color(0xff202020)
                  ),
                  )
              ),
            ),
          );
        }).toList()
      ),
    );
  }
}

//
// class ActionButton extends StatelessWidget {
//   const ActionButton({super.key, required this.text});
//
//   final String text;
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: EdgeInsets.all(10),
//       width: 350,
//       height: 77,
//       decoration: BoxDecoration(
//           color: Color(0xff756CCD),
//           borderRadius: BorderRadius.circular(30)
//       ),
//       child: Center(
//           child: Text(text,style: TextStyle(
//               fontSize: 30,
//               fontWeight: FontWeight.w900,
//               color: Colors.white,
//           ),
//           )
//       ),
//     );
//   }
// }

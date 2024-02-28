import 'package:adv_basics/data/questions.dart';
import 'package:adv_basics/questions_summary.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen(this.chosenAnswers, this.onRestart, {super.key});
  final List<String> chosenAnswers;
  final void Function() onRestart;
  List<Map<String, Object>> getSummaryData() {
    final List<Map<String, Object>> map = [];

    for (var i = 0; i < chosenAnswers.length; i++) {
      map.add(
        {
          'question_index': i,
          'question': questions[i].text,
          'correct_answer': questions[i].answers[0],
          'user_answer': chosenAnswers[i]
        },
      );
    }

    return map;
  }

  @override
  Widget build(BuildContext context) {
    final summaryData = getSummaryData();
    final numTolalQuestions = questions.length;
    final numCorrectQuestions = summaryData.where((e) {
      return e['correct_answer'] == e['user_answer'];
    }).length;
    return SizedBox(
        width: double.infinity,
        child: Container(
            margin: const EdgeInsets.all(40),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "You answered $numCorrectQuestions out of $numTolalQuestions questions correctly!",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.lato(color: Colors.white),
                ),
                const SizedBox(
                  height: 30,
                ),
                QuestionsSummary(summaryData),
                const SizedBox(height: 30),
                TextButton.icon(
                    icon: const Icon(Icons.refresh),
                    style: TextButton.styleFrom(foregroundColor: Colors.white),
                    onPressed: onRestart,
                    label: const Text("Restart Quiz!")),
              ],
            )));
  }
}

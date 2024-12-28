import 'package:tut/tut.dart' as question_class;

void main() {
  var questionI = question_class.Question();
  questionI.promptNumberOfQuestion();

  List<Map<String, dynamic>> subQuestionList = questionI.getRandomQuestions();

  // Question ask
  for (var questionItem in subQuestionList) {
    questionI.displayQuestion(questionItem);

    questionI.computeQuestion(questionItem);
  }

  questionI.printEndGameScore();
}

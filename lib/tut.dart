import 'dart:io';
import 'package:tut/question_data.dart' as quiz_data;
import 'dart:math';

// Class for question
class Question {
  late int userChoiceIndex; //Is in index
  late Object questionAnswer;
  late List options; // options list of option
  late List<Map<String, dynamic>> questionList;
  final List<String> _optionsType = const ['A', 'B', 'C', 'D'];
  int _numOfQuestions = 0;
  int _point = 0;
  int _questionCount = 0;

  // Methods
  // compare user input with question answer
  bool compareAnswer() {
    var userAnswer = options[userChoiceIndex];
    bool isCorrect = userAnswer == questionAnswer ? true : false;
    return isCorrect;
  }

  int promptNumberOfQuestion() {
    while (_numOfQuestions < 5 || _numOfQuestions > 30) {
      // Get user input on number of questions
      stdout.write('Enter number of question you want from 5 - 30:  ');
      String? userInput = stdin.readLineSync();

      if (int.tryParse(userInput!) != null) {
        _numOfQuestions = int.parse(userInput);
      }
    }

    return _numOfQuestions;
  }

  List<Map<String, dynamic>> getRandomQuestions() {
    Random random = Random();
    List<Map<String, dynamic>> questionList = List.from(quiz_data.questions);

    // Shuffle
    questionList.shuffle(random);

    List<Map<String, dynamic>> subQuestionList =
        questionList.sublist(0, _numOfQuestions);

    return subQuestionList;
  }

  void displayQuestion(questionItem) {
    _questionCount++;

    print('\n\n ====== Question $_questionCount =====');

    stdout.write("\n\n _points: $_point ");

    stdout.write("\n${questionItem['question']} \n\n");

    var optionIndex = 0;

    questionItem['options'].forEach((option) {
      stdout.write("${_optionsType[optionIndex]}: $option \n");
      optionIndex++;
    });
  }

  void computeQuestion(questionItem) {
    String? userAnswer;

    while (userAnswer == null) {
      // Get user input
      stdout.write("\n Select an option from A to D:  ");
      String? userAnswerInput = stdin.readLineSync();

      var isLetter = int.tryParse(userAnswerInput!);

      // Check if input is letter
      if (isLetter == null &&
          _optionsType.contains(userAnswerInput.toString().toUpperCase())) {
        //It is not  a number
        userAnswer = userAnswerInput.toString().toUpperCase();

        // Get index of userAnswer
        var index = _optionsType.indexOf(userAnswer);

        setParams(index, questionItem['answer'], questionItem['options']);

        var isCorrect = compareAnswer();

        isCorrect ? _point++ : _point;
        isCorrect ? print('Correct!!!') : print('Wrong!!!');
      }
    }
  }

  void printEndGameScore() {
    print('Your Final score is $_point/$_numOfQuestions');
  }

  void setParams(int userChoiceIndex, Object questionAnswer, List options) {
    this.userChoiceIndex = userChoiceIndex;
    this.questionAnswer = questionAnswer;
    this.options = options;
  }
}

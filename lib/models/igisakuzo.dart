class Igisakuzo {
  final String question;
  final String option1;
  final String option2;
  final String option3;
  final String option4;
  final String correctAnswer;
  Igisakuzo.fromMap(Map<String, dynamic> map)
      : question = map['question'] ?? '-',
        option1 = map['option_1'] ?? '-',
        option2 = map['option_2'] ?? '-',
        option3 = map['option_3'] ?? '-',
        option4 = map['option_4'] ?? '-',
        correctAnswer = map['correct_answer'] ?? '-';
}

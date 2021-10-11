class NtibavugaBavuga {
  final String question;
  final String answer;

  NtibavugaBavuga.fromMap(Map<String, dynamic> map)
      : question = map['question'] ?? '-',
        answer = map['answer'] ?? '-';
}

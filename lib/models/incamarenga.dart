class Incamarega {
  final String statement;
  final String explaination;
  Incamarega.fromMap(Map<String, dynamic> map)
      : statement = map['incamarenga'] ?? '-',
        explaination = map['igisobanuro'] ?? '-';
}

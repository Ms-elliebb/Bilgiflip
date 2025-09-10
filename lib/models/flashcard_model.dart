class Flashcard {
  final String question;
  final String answer;
  final bool isKnown;

  Flashcard({
    required this.question,
    required this.answer,
    this.isKnown = false,
  });

  factory Flashcard.fromJson(Map<String, dynamic> json) {
    return Flashcard(
      question: json['question'],
      answer: json['answer'],
    );
  }

  String get id => question;

  Flashcard copyWith({
    String? question,
    String? answer,
    bool? isKnown,
  }) {
    return Flashcard(
      question: question ?? this.question,
      answer: answer ?? this.answer,
      isKnown: isKnown ?? this.isKnown,
    );
  }
}

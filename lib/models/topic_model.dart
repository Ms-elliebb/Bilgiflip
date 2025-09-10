import 'flashcard_model.dart';

class Topic {
  final String id;
  final String name;
  final List<Flashcard> flashcards;

  Topic({required this.id, required this.name, required this.flashcards});

  factory Topic.fromJson(Map<String, dynamic> json) {
    var flashcardsList = json['flashcards'] as List;
    List<Flashcard> flashcards =
        flashcardsList.map((i) => Flashcard.fromJson(i)).toList();

    return Topic(
      id: json['id'],
      name: json['name'],
      flashcards: flashcards,
    );
  }
}

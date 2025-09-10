import 'topic_model.dart';

class Category {
  final String id;
  final String name;
  final int iconCode;
  final List<Topic> topics;

  Category({
    required this.id,
    required this.name,
    required this.iconCode,
    required this.topics,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    var topicsList = json['topics'] as List;
    List<Topic> topics = topicsList.map((i) => Topic.fromJson(i)).toList();

    return Category(
      id: json['id'],
      name: json['name'],
      iconCode: json['icon_code'],
      topics: topics,
    );
  }
}

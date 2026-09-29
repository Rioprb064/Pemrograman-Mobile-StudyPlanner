class Activity {
  String id;
  String title;
  String category;
  DateTime dueDate;
  String description;
  bool isDone;
  bool isFavorite;

  Activity({
    required this.id,
    required this.title,
    required this.category,
    required this.dueDate,
    required this.description,
    required this.isDone,
    required this.isFavorite,
  });
}

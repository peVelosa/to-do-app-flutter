class ToDo {
  ToDo({required this.title, required this.isDone, required this.id});

  final String title;
  final String id;
  bool isDone;

  factory ToDo.fromMap(Map<String, dynamic> json) {
    return ToDo(
      title: json['title'],
      isDone: json['isDone'],
      id: json['id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'isDone': isDone,
      'id': id,
    };
  }

  @override
  String toString() => '{title: $title, isDone: $isDone, id: $id}';
}

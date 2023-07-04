class TodoModel {
  int? id;
  String? title;
  String? description;
  String? date;

  TodoModel({this.id, this.title, this.description, this.date});

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'date': date,
    };
  }

  factory TodoModel.fromJson(Map<String, dynamic> json) {
    return TodoModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      date: json['date'],
    );
  }
}

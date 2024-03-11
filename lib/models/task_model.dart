

class TaskModel {
  String? title;
  String? description;
  int? date;
  String? id;
  bool? isDone;
  TaskModel(
      {this.id,
      required this.title,
      required this.description,
      required this.date,
      this.isDone = false});

  TaskModel.fromFirestore(Map<String, dynamic> data) {
    id = data["id"];
    title = data["title"];
    description = data["description"];
    date = data["date"];
    isDone = data["isDone"];
  }
  Map<String, dynamic> toFirestore() {
    return {
      if (title != null) "title": title,
      if (description != null) "description": description,
      if (date != null) "date": date,
      if (id != null) "id": id,
      if (isDone != null) "isDone": isDone,
    };
  }

}

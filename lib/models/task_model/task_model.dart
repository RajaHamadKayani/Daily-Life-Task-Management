class TaskModel {
  var title;
  DateTime dateTime;
  var description;
  int? id;
  String dateTimeString; // Added this line

  TaskModel({
    required this.description,
    required this.dateTime,
    required this.title,
    this.id,
  }) : dateTimeString = dateTime.toIso8601String(); // Added this line

  TaskModel.jsonMap(Map<String, dynamic> res)
      : id = res["id"],
        description = res["description"],
        dateTime = DateTime.parse(res["dateTime"]), // Parse the stored string back to DateTime
        title = res['title'],
        dateTimeString = res["dateTime"]; // Added this line

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "description": description,
      "title": title,
      "dateTime": dateTimeString, // Updated this line
    };
  }
}


class Task {
  int? id;
  String? title;
  String? note;
  String? repeat;
  String? date;
  String? startTime;
  String? endTime;
  int? isCompleted;
  int? color;
  int? remind;
  Task(
      {this.color,
      this.date,
      this.endTime,
      this.id,
      this.isCompleted,
      this.note,
      this.remind,
      this.repeat,
      this.startTime,
      this.title});
  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = new Map<String, dynamic>();
    data["id"] = this.id;
    data["title"] = this.title;
    data['note'] = this.note;
    data['repeat'] = this.repeat;
    data["remind"] = this.remind;
    data["startTime"] = this.startTime;
    data["endTime"] = this.endTime;
    data["isCompleted"] = this.isCompleted;
    data['color'] = this.color;
    data['date'] = this.date;
    return data;
  }

  Task.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    note = json["note"];
    remind = json["remind"];
    repeat = json["repeat"];
    isCompleted = json["isCompleted"];
    color = json['color'];
    endTime = json['endTime'];
    startTime = json['startTime'];
    title = json['title'];
    date = json['date'];
  }
}

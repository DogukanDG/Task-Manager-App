class Task {
  late int? id;
  late String? title;
  late String? note;
  late int? isCompleted;
  late String? date;
  late String? startTime;
  late String? endTime;
  late int? color;
  late int? remind;
  late String? repeat;

  Task({
    this.id,
    this.title,
    this.note,
    this.isCompleted,
    this.date,
    this.startTime,
    this.endTime,
    this.color,
    this.remind,
    this.repeat,
  });

  Task.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'].toString();
    note = json['note'].toString();
    isCompleted = json['isCompleted'];
    date = json['date'];
    startTime = json['startTime'];
    endTime = json['endTime'];
    color = json['color'];
    remind = json['remind'];
    repeat = json['repeat'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['date'] = this.date;
    data['note'] = this.note;
    data['isCompleted'] = this.isCompleted;
    data['endTime'] = this.endTime;
    data['color'] = this.color;
    data['remind'] = this.remind;
    data['repeat'] = this.repeat;
    data['startTime'] = this.startTime;
    return data;
  }
}

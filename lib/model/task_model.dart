class Task {
  int? id;
  String taskName;
  String taskDescription;
  String date;
  String time;

  Task(this.taskName,this.taskDescription, this.date, this.time, {this.id});

   Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': taskName,
      'description': taskDescription,
      'date': date,
      'time': time,
    };
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      map['name'],
      map['description'],
      map['date'],
      map['time'],
      id: map['id'],
    );
  }

  Task copyWith({
    int? id,
    String? name,
    String? description,
    String? date,
    String? time,
  }) {
    return Task(
      name ?? taskName,
      description ?? taskDescription,
      date ?? this.date,
      time ?? this.time,
      id: id ?? this.id,
    );
  }
}
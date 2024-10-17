import 'package:flutter/material.dart';
import 'package:to_do_app_mvvm/model/task_model.dart';
import 'package:to_do_app_mvvm/service/Repository/task_repository.dart';

class TaskViewmodel extends ChangeNotifier {
  final TaskRepository taskRepository;
  List<Task> tasks = [];
  TaskViewmodel(this.taskRepository);

  String? taskName;
  String? taskDescription;
  final dateCont = TextEditingController();
  final timeCont = TextEditingController();

  bool get isValid => taskName != null && dateCont.text.isNotEmpty && timeCont.text.isNotEmpty;

  setTaskName(String? value) {
    taskName = value;
    notifyListeners();
  }

  setTaskDescription(String? value) {  
    taskDescription = value;
    notifyListeners();
  }

  setDate(DateTime? date) {
    if (date == null) {
      return;
    }

    DateTime currentDate = DateTime.now();
    DateTime now = DateTime(currentDate.year, currentDate.month, currentDate.day);
    int diff = date.difference(now).inDays;

    if (diff == 0) {
      dateCont.text = "Today";
    } else if (diff == 1) {
      dateCont.text = "Tomorrow";
    } else {
      dateCont.text = "${date.day}-${date.month}-${date.year}";
    }
    notifyListeners();
  }

  setTime(TimeOfDay? time) {
    if (time == null) {
      return;
    }

    if (time.hour == 0) {
      timeCont.text = "12:${time.minute.toString().padLeft(2, '0')} AM";
    } else if (time.hour < 12) {
      timeCont.text = "${time.hour}:${time.minute.toString().padLeft(2, '0')} AM";
    } else if (time.hour == 12) {
      timeCont.text = "${time.hour}:${time.minute.toString().padLeft(2, '0')} PM";
    } else {
      timeCont.text = "${time.hour - 12}:${time.minute.toString().padLeft(2, '0')} PM";
    }
    notifyListeners();
  }

  Future<void> loadTasks() async {
    tasks = await taskRepository.getTasks();
    notifyListeners();
  }

  addTask() async {
    if (!isValid) {
      return;
    }
    final task = Task(taskName!, taskDescription!, dateCont.text, timeCont.text);
    await taskRepository.insertTask(task);
    timeCont.clear();
    dateCont.clear();
    await loadTasks();
    sortTasks(); 
    notifyListeners();
  }

  Future<void> deleteTask(int id) async {
    await taskRepository.deleteTask(id);
    await loadTasks();
    sortTasks(); 
    notifyListeners();
  }

  Future<void> updateTask(Task task) async {
    await taskRepository.updateTask(task);
    await loadTasks();
    sortTasks(); 
    notifyListeners();
  }
 
  DateTime? _parseDateTime(String date, String time) {
    DateTime now = DateTime.now();
    DateTime? parsedDate;
    if (date == "Today") {
      parsedDate = DateTime(now.year, now.month, now.day);
    } else if (date == "Tomorrow") {
      parsedDate = DateTime(now.year, now.month, now.day).add(const Duration(days: 1));
    } else {
      List<String> dateParts = date.split('-');
      if (dateParts.length == 3) {
        int day = int.parse(dateParts[0]);
        int month = int.parse(dateParts[1]);
        int year = int.parse(dateParts[2]);
        parsedDate = DateTime(year, month, day);
      }
    }

    List<String> timeParts = time.split(' ');
    List<String> hourMinute = timeParts[0].split(':');
    int hour = int.parse(hourMinute[0]);
    int minute = int.parse(hourMinute[1]);
    if (timeParts[1] == "PM" && hour != 12) {
      hour += 12;
    } else if (timeParts[1] == "AM" && hour == 12) {
      hour = 0;
    }
    return parsedDate != null ? DateTime(parsedDate.year, parsedDate.month, parsedDate.day, hour, minute) : null;
  }

  void sortTasks() {
    tasks.sort((a, b) {
      DateTime? aDateTime = _parseDateTime(a.date, a.time);
      DateTime? bDateTime = _parseDateTime(b.date, b.time);
      if (aDateTime != null && bDateTime != null) {
        return aDateTime.compareTo(bDateTime);
      }
      return 0;
    });
  }
}

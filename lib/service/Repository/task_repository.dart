import 'package:to_do_app_mvvm/model/task_model.dart';

abstract class TaskRepository {
  Future<List<Task>> getTasks();
  Future<void> insertTask(Task task);
  Future<void> updateTask(Task task);
  Future<void> deleteTask(int id);
}

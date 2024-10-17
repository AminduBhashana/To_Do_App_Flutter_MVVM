import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app_mvvm/constants/constants.dart';
import 'package:to_do_app_mvvm/model/task_model.dart';
import 'package:to_do_app_mvvm/viewmodel/task_view_model.dart';
import 'package:to_do_app_mvvm/widgets/custom_dialog.dart';

class TaskWidget extends StatelessWidget {
  const TaskWidget({super.key, required this.task});
  final Task task;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: secondary,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.calendar_today, size: 16, color: Colors.grey[600]),
              const SizedBox(width: 4),
              Text(
                task.date,
                style: TextStyle(
                  color: Colors.grey[800],
                  fontSize: 14,
                ),
              ),
              const SizedBox(width: 16),
              Icon(Icons.access_time, size: 16, color: Colors.grey[600]),
              const SizedBox(width: 4),
              Text(
                task.time,
                style: TextStyle(
                  color: Colors.grey[800],
                  fontSize: 14,
                ),
              ),
            ],
          ),
          Column(
            crossAxisAlignment:
                CrossAxisAlignment.start, 
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      task.taskName,
                      style: const TextStyle(
                        color: textColor2,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      overflow: TextOverflow.ellipsis, 
                    ),
                  ),
                  const SizedBox(width: 10),
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit, color: primary),
                        onPressed: () {
                          showDialog(
                          context: context,
                          builder: (context) {
                            return const CustomDialog();
                          },
                        );
                        },
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          Provider.of<TaskViewmodel>(context, listen: false).deleteTask(task.id!);
                        },
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 5), 
              Text(
                task.taskDescription, 
                style:  TextStyle(
                  color: Colors.grey[700],
                  fontSize: 16,
                ),
                overflow:TextOverflow.ellipsis, 
                maxLines: 2, 
              ),
            ],
          )
        ],
      ),
    );
  }
}

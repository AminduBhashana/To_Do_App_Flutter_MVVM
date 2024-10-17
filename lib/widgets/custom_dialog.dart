import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app_mvvm/viewmodel/task_view_model.dart';
import 'package:to_do_app_mvvm/widgets/custom_textfield.dart';
import '../constants/constants.dart';
import '../model/task_model.dart';

class CustomDialog extends StatefulWidget {
  final Task? existingTask;

  const CustomDialog({
    Key? key,
    this.existingTask,
  }) : super(key: key);

  @override
  State<CustomDialog> createState() => _CustomDialogState();
}

class _CustomDialogState extends State<CustomDialog> {
  late TextEditingController taskNameController;
  late TextEditingController taskDescriptionController;
  late TextEditingController dateController;
  late TextEditingController timeController;

  @override
  void initState() {
    super.initState();
    final taskProvider = Provider.of<TaskViewmodel>(context, listen: false);

    taskNameController = TextEditingController(text: widget.existingTask?.taskName ?? '');
    taskDescriptionController = TextEditingController(text: widget.existingTask?.taskDescription ?? '');
    dateController = TextEditingController(text: widget.existingTask?.date ?? '');
    timeController = TextEditingController(text: widget.existingTask?.time ?? '');

    if (widget.existingTask != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        taskProvider.setTaskName(widget.existingTask!.taskName);
        taskProvider.setTaskDescription(widget.existingTask!.taskDescription);
        taskProvider.dateCont.text = widget.existingTask!.date;
        taskProvider.timeCont.text = widget.existingTask!.time;
      });
    }
  }

  @override
  void dispose() {
    taskNameController.dispose();
    taskDescriptionController.dispose();
    dateController.dispose();
    timeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.sizeOf(context).height;
    double screenWidth = MediaQuery.sizeOf(context).width;
    final taskProvider = Provider.of<TaskViewmodel>(context, listen: false);

    return Dialog(
      backgroundColor: backgroundColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(23)),
      child: SizedBox(
        height: screenHeight * 0.6,
        width: screenWidth * 0.8,
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: screenWidth * 0.05, vertical: screenHeight * 0.02),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.center,
                child: Text(
                  widget.existingTask != null ? "Edit existing Task" : "Add a new task",
                  style: const TextStyle(
                      color: primary,
                      fontSize: 22,
                      fontWeight: FontWeight.w600),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                "What is your task?",
                style: TextStyle(color: textColor2),
              ),
              CustomTextfield(
                hint: "Enter a Task",
                textEditingController: taskNameController,
                onChanged: (value) {
                  taskProvider.setTaskName(value);
                },
              ),
              const SizedBox(height: 20),
              const Text(
                "Task Description",
                style: TextStyle(color: textColor2),
              ),
              CustomTextfield(
                hint: "Enter a Description",
                textEditingController: taskDescriptionController,
                onChanged: (value) {
                  taskProvider.setTaskDescription(value);
                },
              ),
              const SizedBox(height: 20),
              const Text(
                "Due Date",
                style: TextStyle(color: textColor2),
              ),
              CustomTextfield(
                hint: "Enter a Date",
                readOnly: true,
                icon: Icons.calendar_month,
                textEditingController: dateController,
                onTap: () async {
                  DateTime? date = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2024),
                      lastDate: DateTime(2030));
                  taskProvider.setDate(date);
                  dateController.text = taskProvider.dateCont.text;
                },
              ),
              const SizedBox(height: 10),
              CustomTextfield(
                hint: "Enter a Time",
                readOnly: true,
                icon: Icons.timer,
                textEditingController: timeController,
                onTap: () async {
                  TimeOfDay? time = await showTimePicker(
                      context: context, initialTime: TimeOfDay.now());
                  taskProvider.setTime(time);
                  timeController.text = taskProvider.timeCont.text;
                },
              ),
              const SizedBox(height: 30),
              Align(
                alignment: Alignment.center,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: primary),
                  onPressed: () async {
                    if (widget.existingTask != null) {
                      await taskProvider.updateTask(widget.existingTask!.copyWith(
                        name: taskProvider.taskName!,
                        description: taskProvider.taskDescription!,
                        date: taskProvider.dateCont.text,
                        time: taskProvider.timeCont.text,
                      ));
                    } else {
                      await taskProvider.addTask();
                    }

                    if (context.mounted) {
                      Navigator.pop(context);
                    }
                  },
                  child: Text(
                    widget.existingTask != null ? "Update" : "Create",
                    style: const TextStyle(color: textColor1),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

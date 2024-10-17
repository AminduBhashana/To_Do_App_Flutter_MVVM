import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app_mvvm/viewmodel/task_view_model.dart';
import 'package:to_do_app_mvvm/widgets/custom_textfield.dart';
import '../constants/constants.dart';

class CustomDialog extends StatelessWidget { 
  const CustomDialog({
    super.key,
  });


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
               const Align(
                alignment: Alignment.center,
                child: Text(
                   "Add a new task" ,
                  style: TextStyle(
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
                textEditingController: taskProvider.dateCont,
                onTap: () async {
                  DateTime? date = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2024),
                      lastDate: DateTime(2030));
                  taskProvider.setDate(date);
                },
              ),
              const SizedBox(height: 10),
              CustomTextfield(
                hint: "Enter a Time",
                readOnly: true,
                icon: Icons.timer,
                textEditingController: taskProvider.timeCont,
                onTap: () async {
                  TimeOfDay? time = await showTimePicker(
                      context: context, initialTime: TimeOfDay.now());
                  taskProvider.setTime(time);
                },
              ),
              const SizedBox(height: 30),
              Align(
                alignment: Alignment.center,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: primary),
                    onPressed: () async {
                      await taskProvider.addTask();
                      if (context.mounted) {
                        Navigator.pop(context);
                      }
                    },
                    child: const Text(
                      "Create",
                      style: TextStyle(color: textColor1),
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}



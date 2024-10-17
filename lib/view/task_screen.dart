import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app_mvvm/constants/constants.dart';
import 'package:to_do_app_mvvm/viewmodel/task_view_model.dart';
import 'package:to_do_app_mvvm/widgets/custom_float_button.dart';
import 'package:to_do_app_mvvm/widgets/exit_banner.dart';
import 'package:to_do_app_mvvm/widgets/task_widget.dart';

class TaskScreen extends StatefulWidget {
  const TaskScreen({super.key});

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {

@override
  void initState() {
    super.initState();
    TaskViewmodel taskViewmodel = Provider.of<TaskViewmodel>(context, listen: false);
    taskViewmodel.loadTasks();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => onExitPop(context),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: primary,
          title: const Row(
            children: [
              CircleAvatar(
                radius: 14,
                backgroundColor: Colors.white,
                child: Icon(
                  Icons.check,
                  size: 20,
                ),
              ),
              SizedBox(width: 10,),
              Text(
                "To Do List",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold,color: textColor1),
              ),
            ],
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.exit_to_app, color: Colors.white,size: 32,), 
              onPressed: () {
                onExitPop(context);
              },
            ),
            const SizedBox(width: 10), 
          ],
        ),
        body: Consumer<TaskViewmodel>(builder: (context, taskProvider, child) {
          return ListView.builder(
              itemBuilder: (context, index) {
                final task = taskProvider.tasks[index];
                return TaskWidget(
                  task: task,
                );
              },          
              itemCount: taskProvider.tasks.length);
        }),
        floatingActionButton: const CustomFAB(),
      ),
    );
  }
}






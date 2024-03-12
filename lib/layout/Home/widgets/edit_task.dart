import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo/layout/Home/provider/home_provider.dart';
import 'package:todo/models/task_model.dart';
import 'package:todo/shared/providers/auth_provider.dart';
import 'package:todo/shared/remote/firebase/firestore_helper.dart';
import 'package:todo/shared/reusable_componenets/task_text_field.dart';

class EditTask extends StatelessWidget {
  EditTask({super.key});
  static const String routeName = "editTask";
  final GlobalKey<FormState> formkey = GlobalKey();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var hight = MediaQuery.of(context).size.height;
    final TaskModel task =
        ModalRoute.of(context)?.settings.arguments as TaskModel;
    MyAuthProvider provider = Provider.of<MyAuthProvider>(context);
    HomeProvider homeProvider = Provider.of<HomeProvider>(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Theme.of(context).colorScheme.secondary,
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          SizedBox(
            height: hight * 0.2,
            width: double.infinity,
            child: AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: Theme.of(context).primaryColor,
              leading: IconButton(
                onPressed: () {
                  homeProvider.selectNewTime(null);
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back),
              ),
              title: Text(
                'To Do List',
                style: Theme.of(context).textTheme.labelLarge,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: hight * 0.13),
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              margin: EdgeInsets.only(
                  bottom: hight * 0.14,
                  top: hight * 0.025,
                  left: hight * 0.05,
                  right: hight * 0.05),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Edit title",
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                    TaskTextField(
                      controller: titleController,
                      val: (value) {
                        if (value == null || value.isEmpty) {
                          return "title can't be empty";
                        }
                        return null;
                      },
                      label: 'edit task',
                    ),
                    TaskTextField(
                        controller: descController,
                        val: (value) {
                          if (value == null || value.isEmpty) {
                            return "description can't be empty";
                          }
                          return null;
                        },
                        label: 'edit description'),
                    Row(
                      children: [
                        Text("Select Date",
                            style: Theme.of(context).textTheme.bodyMedium),
                      ],
                    ),
                    TextButton(
                        onPressed: () async {
                          DateTime? selectedDate = await showDatePicker(
                            context: context,
                            firstDate: DateTime.now(),
                            lastDate: DateTime.now().add(
                              const Duration(days: 365),
                            ),
                          );
                          homeProvider.selectNewDate(selectedDate);
                        },
                        child: Text(
                            homeProvider.selectedDate == null
                                ? 'Select Date'
                                : DateFormat('dd/MM/yyyy')
                                    .format(homeProvider.selectedDate!),
                            // DateFormat('dd/MM/yyyy').format(
                            // DateTime.fromMillisecondsSinceEpoch(
                            //     task.date!))
                            style: Theme.of(context).textTheme.bodyLarge)),
                    Row(
                      children: [
                        Text(
                          "select time",
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextButton(
                        onPressed: () async {
                          TimeOfDay? selectedTime = await showTimePicker(
                              context: context,
                              initialTime:
                                  const TimeOfDay(hour: 12, minute: 00));
                          homeProvider.selectNewTime(selectedTime);
                        },
                        child: Text(
                          homeProvider.selectedTime == null
                              ? task.time!
                              : DateFormat.jm().format(DateTime(
                                  homeProvider.selectedDate!.year,
                                  homeProvider.selectedDate!.month,
                                  homeProvider.selectedDate!.day,
                                  homeProvider.selectedTime!.hour,
                                  homeProvider.selectedTime!.minute)),
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.primary,
                              fontSize: 20,
                              fontWeight: FontWeight.w400),
                        )),
                    ElevatedButton(
                      onPressed: () async {
                        await FirestoreHelper.updateTasks(
                            userID: provider.fireBaseUserAuth!.uid,
                            taskID: task.id ?? "",
                            task: TaskModel(
                              title: titleController.text,
                              description: descController.text,
                              date: DateTime(
                                      homeProvider.selectedDate!.year,
                                      homeProvider.selectedDate!.month,
                                      homeProvider.selectedDate!.day)
                                  .millisecondsSinceEpoch,
                              time: DateFormat.jm().format(
                                DateTime(
                                    homeProvider.selectedDate!.year,
                                    homeProvider.selectedDate!.month,
                                    homeProvider.selectedDate!.day,
                                    homeProvider.selectedTime!.hour,
                                    homeProvider.selectedTime!.minute),
                              ),
                            ));
                        homeProvider.selectNewTime(null);
                        Navigator.pop(context);
                      },
                      child: const Text("Save Changes"),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

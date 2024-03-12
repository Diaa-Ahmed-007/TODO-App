import 'package:flutter/material.dart';
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
    final TaskModel details =
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
                        Text("Select time",
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
                                : '${homeProvider.selectedDate!.day} / ${homeProvider.selectedDate!.month} / ${homeProvider.selectedDate!.year}',
                            style: Theme.of(context).textTheme.bodyLarge)),
                    ElevatedButton(
                        onPressed: () {
                          FirestoreHelper.updateTasks(
                              userID: provider.fireBaseUserAuth!.uid,
                              taskID: details.id ?? "",
                              task: TaskModel(
                                  title: titleController.text,
                                  description: descController.text,
                                  date: DateTime(
                                          homeProvider.selectedDate!.year,
                                          homeProvider.selectedDate!.month,
                                          homeProvider.selectedDate!.day)
                                      .millisecondsSinceEpoch,
                                  time: ""));
                          Navigator.pop(context);
                        },
                        child: const Text("Save Changes")),
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

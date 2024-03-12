import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo/layout/Home/provider/home_provider.dart';
import 'package:todo/shared/reusable_componenets/task_text_field.dart';

class AddTaskSheet extends StatelessWidget {
  const AddTaskSheet(
      {super.key,
      required this.ontap,
      required this.formkey,
      required this.titleController,
      required this.descController});
  final Function() ontap;
  final GlobalKey<FormState> formkey;
  final TextEditingController titleController;
  final TextEditingController descController;
  @override
  Widget build(BuildContext context) {
    HomeProvider provider = Provider.of<HomeProvider>(context);
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Form(
        key: formkey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Add New Task',
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  IconButton(
                      onPressed: ontap, icon: const Icon(Icons.cancel_outlined))
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              TaskTextField(
                controller: titleController,
                val: (value) {
                  if (value == null || value.isEmpty) {
                    return "title can't be empty";
                  }
                  return null;
                },
                label: 'enter your task',
              ),
              const SizedBox(
                height: 10,
              ),
              TaskTextField(
                  controller: descController,
                  val: (value) {
                    if (value == null || value.isEmpty) {
                      return "description can't be empty";
                    }
                    return null;
                  },
                  label: 'description'),
              const SizedBox(
                height: 10,
              ),
              Text(
                "select time",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(
                height: 10,
              ),
              TextButton(
                  onPressed: () async {
                    TimeOfDay? selectedTime = await showTimePicker(

                        context: context,
                        initialTime: const TimeOfDay(hour: 12, minute: 00));
                    provider.selectNewTime(selectedTime);
                  },
                  child: Text(
                    provider.selectedTime == null
                        ? DateFormat.jm().format(DateTime(
                            provider.selectedDate!.year,
                            provider.selectedDate!.month,
                            provider.selectedDate!.day,
                            24,
                            0))
                        : DateFormat.jm().format(DateTime(
                            provider.selectedDate!.year,
                            provider.selectedDate!.month,
                            provider.selectedDate!.day,
                            provider.selectedTime!.hour,
                            provider.selectedTime!.minute)),
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontSize: 20,
                        fontWeight: FontWeight.w400),
                  )),
              const SizedBox(
                height: 60,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo/layout/Home/provider/home_provider.dart';
import 'package:todo/layout/Home/provider/settings_provider.dart';
import 'package:todo/layout/Home/widgets/edit_task.dart';
import 'package:todo/models/task_model.dart';
import 'package:todo/shared/providers/auth_provider.dart';
import 'package:todo/shared/remote/firebase/firestore_helper.dart';

class TaskWidget extends StatelessWidget {
  const TaskWidget({super.key, required this.task});
  final TaskModel task;

  @override
  Widget build(BuildContext context) {
    var hight = MediaQuery.of(context).size.height;
    MyAuthProvider provider = Provider.of<MyAuthProvider>(context);
    HomeProvider homeProvider = Provider.of<HomeProvider>(context);
    SettingsProvider settingsProvider = Provider.of<SettingsProvider>(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
      child: Slidable(
        direction: Axis.horizontal,
        startActionPane: ActionPane(motion: const BehindMotion(), children: [
          CustomSlidableAction(
            onPressed: (_) {
              FirestoreHelper.deleteTask(
                  userID: provider.fireBaseUserAuth!.uid,
                  taskID: task.id ?? "");
            },
            backgroundColor: const Color(0xFFFE4A49),
            foregroundColor: Colors.white,
            autoClose: true,
            borderRadius: settingsProvider.selectedLanguage == 'en'
                ? const BorderRadius.only(
                    topLeft: Radius.circular(15),
                    bottomLeft: Radius.circular(15),
                  )
                : const BorderRadius.only(
                    topRight: Radius.circular(15),
                    bottomRight: Radius.circular(15),
                  ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.delete,
                  size: 30,
                ),
                Text(
                  AppLocalizations.of(context)!.delete,
                  style: const TextStyle(
                      fontSize: 14, fontWeight: FontWeight.w400),
                )
              ],
            ),
          ),
          CustomSlidableAction(
            onPressed: (_) {
              homeProvider.selectNewTime(TimeOfDay.fromDateTime(
                  DateFormat().add_jm().parse(task.time!)));
              Navigator.pushNamed(context, EditTask.routeName, arguments: task);
            },
            backgroundColor:
                Theme.of(context).colorScheme.outline.withOpacity(0.8),
            foregroundColor: Colors.white,
            autoClose: true,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.edit,
                  size: 30,
                ),
                Text(
                  AppLocalizations.of(context)!.edit,
                  style: const TextStyle(
                      fontSize: 14, fontWeight: FontWeight.w400),
                ),
              ],
            ),
          ),
        ]),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.onPrimary,
            borderRadius: settingsProvider.selectedLanguage == 'en'
                ? const BorderRadius.only(
                    topRight: Radius.circular(15),
                    bottomRight: Radius.circular(15))
                : const BorderRadius.only(
                    topLeft: Radius.circular(15),
                    bottomLeft: Radius.circular(15)),
          ),
          child: Row(
            children: [
              const SizedBox(
                width: 16,
              ),
              Container(
                height: hight * 0.08,
                margin: const EdgeInsets.symmetric(vertical: 8),
                width: 5,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: task.isDone!
                      ? Theme.of(context).colorScheme.outline
                      : Theme.of(context).colorScheme.primary,
                ),
              ),
              const SizedBox(
                width: 30,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    task.title ?? "",
                    style: TextStyle(
                        color: task.isDone!
                            ? Theme.of(context).colorScheme.outline
                            : Theme.of(context).colorScheme.primary,
                        fontSize: 20),
                  ),
                  SizedBox(
                    height: hight * 0.014,
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.watch_later_outlined,
                        color: Theme.of(context).colorScheme.onSecondary,
                        size: 20,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text("${task.time}",
                          style: Theme.of(context).textTheme.labelSmall)
                    ],
                  )
                ],
              ),
              const Spacer(),
              task.isDone!
                  ? TextButton(
                      onPressed: () async {
                        await FirestoreHelper.getIsDoneValue(
                            userID: provider.fireBaseUserAuth!.uid,
                            taskID: task.id!,
                            newValue: !task.isDone!);
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          AppLocalizations.of(context)!.done,
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.outline,
                              fontSize: 22,
                              fontWeight: FontWeight.w700),
                        ),
                      ))
                  : Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                Theme.of(context).colorScheme.primary,
                            elevation: 3,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onPressed: () async {
                            await FirestoreHelper.getIsDoneValue(
                                userID: provider.fireBaseUserAuth!.uid,
                                taskID: task.id!,
                                newValue: !task.isDone!);
                          },
                          child: const Icon(Icons.done)),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}

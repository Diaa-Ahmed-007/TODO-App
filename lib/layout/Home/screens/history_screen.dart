import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:todo/layout/Home/widgets/task_widget.dart';
import 'package:todo/models/task_model.dart';
import 'package:todo/shared/providers/auth_provider.dart';
import 'package:todo/shared/remote/firebase/firestore_helper.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    MyAuthProvider provider = Provider.of<MyAuthProvider>(context);
    DateTime focusDate =
        DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
    var hight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: hight * 0.1,
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text(AppLocalizations.of(context)?.history ?? ""),
      ),
      body: StreamBuilder(
        stream: FirestoreHelper.historyTask(
            UserID: provider.dataBaseUser!.userID!,
            date: focusDate.millisecondsSinceEpoch),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasError) {
            return Center(
              child: Column(
                children: [
                  Text(
                    'oops,there is an error try again',
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontSize: 16,
                        fontWeight: FontWeight.w400),
                  ),
                ],
              ),
            );
          }
          List<TaskModel> tasks = snapshot.data ?? [];
          return ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: tasks.length,
            itemBuilder: (context, index) => TaskWidget(task: tasks[index]),
          );
        },
      ),
    );
  }
}

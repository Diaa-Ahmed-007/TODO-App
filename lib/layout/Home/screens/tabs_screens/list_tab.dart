import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/layout/Home/widgets/task_widget.dart';
import 'package:todo/layout/login/login_screen.dart';
import 'package:todo/models/task_model.dart';
import 'package:todo/shared/providers/auth_provider.dart';
import 'package:todo/shared/remote/firebase/firestore_helper.dart';

class ListTab extends StatefulWidget {
  const ListTab({super.key});

  @override
  State<ListTab> createState() => _ListTabState();
}

DateTime _focusDate = DateTime.now();

class _ListTabState extends State<ListTab> {
  @override
  Widget build(BuildContext context) {
    MyAuthProvider provider = Provider.of<MyAuthProvider>(context);
    var hight = MediaQuery.of(context).size.height;
    return Column(
      children: [
        Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: hight * 0.05),
              child: AppBar(
                automaticallyImplyLeading: false,
                backgroundColor: Theme.of(context).primaryColor,
                toolbarHeight: hight * 0.2,
                title: Text(
                  'Hello ${provider.dataBaseUser!.fullName ?? 'user'}',
                  style: Theme.of(context).textTheme.labelLarge,
                ),
                actions: [
                  IconButton(
                    onPressed: () {
                      provider.signOut();
                      Navigator.pushReplacementNamed(
                          context, LoginScreen.routeName);
                    },
                    icon: const Icon(Icons.exit_to_app),
                  )
                ],
              ),
            ),
            EasyInfiniteDateTimeLine(
              firstDate: DateTime.now(),
              focusDate: _focusDate,
              lastDate: DateTime.now().add(const Duration(days: 365)),
              timeLineProps: const EasyTimeLineProps(),
              showTimelineHeader: false,
              dayProps: EasyDayProps(
                  dayStructure: DayStructure.dayStrDayNum,
                  height: hight * 0.1,
                  inactiveDayStyle: DayStyle(
                    decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.onPrimary,
                        borderRadius: BorderRadius.circular(10)),
                    dayStrStyle: Theme.of(context).textTheme.displayMedium,
                    dayNumStyle: Theme.of(context).textTheme.displayMedium,
                  ),
                  activeDayStyle: DayStyle(
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    dayNumStyle: Theme.of(context).textTheme.displaySmall,
                    dayStrStyle: Theme.of(context).textTheme.displaySmall,
                  ),
                  todayStyle: DayStyle(
                    decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.onPrimary,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                            color: Theme.of(context).colorScheme.primary,
                            width: 3)),
                    dayNumStyle: Theme.of(context).textTheme.displayLarge,
                    dayStrStyle: Theme.of(context).textTheme.displayLarge,
                  )),
              onDateChange: (selectedDate) {
                setState(() {
                  _focusDate = DateTime(
                      selectedDate.year, selectedDate.month, selectedDate.day);
                });
              },
            ),
          ],
        ),
        StreamBuilder(
          stream: FirestoreHelper.listenToTasks(
              UserID: provider.dataBaseUser!.userID!,
              date: _focusDate.millisecondsSinceEpoch),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Expanded(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
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
            return Expanded(
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: tasks.length,
                itemBuilder: (context, index) => TaskWidget(task: tasks[index]),
              ),
            );
          },
        )
      ],
    );
  }
}

import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:todo/layout/Home/provider/home_provider.dart';
import 'package:todo/layout/Home/provider/settings_provider.dart';
import 'package:todo/layout/Home/screens/history_screen.dart';
import 'package:todo/layout/Home/widgets/task_widget.dart';
import 'package:todo/layout/games/game_lobby.dart';
import 'package:todo/models/task_model.dart';
import 'package:todo/shared/providers/auth_provider.dart';
import 'package:todo/shared/remote/firebase/firestore_helper.dart';

class ListTab extends StatefulWidget {
  const ListTab({super.key});

  @override
  State<ListTab> createState() => _ListTabState();
}

class _ListTabState extends State<ListTab> {
  DateTime focusDate =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);

  @override
  Widget build(BuildContext context) {
    MyAuthProvider provider = Provider.of<MyAuthProvider>(context);
    HomeProvider homeProvider = Provider.of<HomeProvider>(context);
    SettingsProvider settingsProvider = Provider.of<SettingsProvider>(context);
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
                backgroundColor: Theme.of(context).colorScheme.primary,
                toolbarHeight: hight * 0.2,
                title: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const GameLoobyScreen(),
                      ),
                    );
                  },
                  child: Center(
                    child: Material(
                      elevation: 20,
                      color: Colors.transparent,
                      child: Container(
                        decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.primary,
                            borderRadius: BorderRadius.circular(100)),
                        padding: const EdgeInsets.all(16),
                        child: Text(
                          AppLocalizations.of(context)!.letsplay,
                          style: const TextStyle(
                              color: Colors.white, fontSize: 18),
                        ),
                      ),
                    ),
                  ),
                ),
                centerTitle: false,
                actions: [
                  const SizedBox(
                    width: 170,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: IconButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ChangeNotifierProvider(
                                  create: (context) => HomeProvider(),
                                  child: const HistoryScreen()),
                            ));
                      },
                      icon: const Icon(
                        Icons.history,
                        size: 33,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Material(
              elevation: 10,
              color: Colors.transparent,
              child: EasyInfiniteDateTimeLine(
                locale: settingsProvider.getLanguage(),
                firstDate: DateTime.now(),
                focusDate: focusDate,
                lastDate: DateTime.now().add(const Duration(days: 365)),
                timeLineProps: const EasyTimeLineProps(),
                showTimelineHeader: false,
                dayProps: EasyDayProps(
                    dayStructure: DayStructure.monthDayNumDayStr,
                    height: hight * 0.1,
                    inactiveDayStyle: DayStyle(
                      decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.onPrimary,
                          borderRadius: BorderRadius.circular(10)),
                      dayStrStyle: Theme.of(context).textTheme.displayMedium,
                      dayNumStyle: Theme.of(context).textTheme.displayMedium,
                      monthStrStyle: Theme.of(context).textTheme.displayMedium,
                    ),
                    activeDayStyle: DayStyle(
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primary,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      dayNumStyle: Theme.of(context).textTheme.displaySmall,
                      dayStrStyle: Theme.of(context).textTheme.displaySmall,
                      monthStrStyle: Theme.of(context).textTheme.displaySmall,
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
                      monthStrStyle: Theme.of(context).textTheme.displayLarge,
                    )),
                onDateChange: (selectedDate) {
                  setState(() {
                    homeProvider.selectNewDate(selectedDate);
                    focusDate = DateTime(selectedDate.year, selectedDate.month,
                        selectedDate.day);
                  });
                },
              ),
            ),
          ],
        ),
        StreamBuilder(
            stream: FirestoreHelper.listenToTasks(
                UserID: provider.dataBaseUser!.userID!,
                date: focusDate.millisecondsSinceEpoch),
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
                  itemBuilder: (context, index) =>
                      TaskWidget(task: tasks[index]),
                ),
              );
            })
      ],
    );
  }
}

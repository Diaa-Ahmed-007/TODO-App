import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo/layout/Home/provider/home_provider.dart';
import 'package:todo/layout/Home/screens/tabs_screens/list_tab.dart';
import 'package:todo/layout/Home/screens/tabs_screens/settings_tab.dart';
import 'package:todo/layout/Home/widgets/add_task_sheet.dart';
import 'package:todo/models/task_model.dart';
import 'package:todo/shared/providers/auth_provider.dart';
import 'package:todo/shared/remote/firebase/firestore_helper.dart';

// ignore: must_be_immutable
class HomeScreen extends StatelessWidget {
  static const routeName = "HomeScreen";

  HomeScreen({super.key});

  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  GlobalKey<FormState> globalKey = GlobalKey();
  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    bool isKeyboardOpened = MediaQuery.of(context).viewInsets.bottom != 0;
    List<Widget> tabsList = [const ListTab(), const SettingsTab()];

    HomeProvider homeProvider = Provider.of<HomeProvider>(context);
    MyAuthProvider provider = Provider.of<MyAuthProvider>(context);
    return Scaffold(
      extendBody: true,
      body: Scaffold(
        key: scaffoldKey,
        body: tabsList[homeProvider.currentNavIndex],
      ),
      bottomNavigationBar: BottomAppBar(
        clipBehavior: Clip.hardEdge,
        color: Colors.transparent,
        elevation: 0,
        shape: const CircularNotchedRectangle(),
        notchMargin: 10,
        child: BottomNavigationBar(
          elevation: 10,
          backgroundColor: Theme.of(context).colorScheme.onPrimary,
          currentIndex: homeProvider.currentNavIndex,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          onTap: (value) {
            homeProvider.changeTab(value);
            if (value == 0) {
              homeProvider.changeFloatingActionButtonVisable(true);
            } else {
              homeProvider.changeFloatingActionButtonVisable(false);
            }
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.list),
              label: "Notes List",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings_outlined),
              label: "settings",
            )
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: isKeyboardOpened
          ? null
          : homeProvider.visableFloatingActionButton
              ? FloatingActionButton(
                  onPressed: () async {
                    if (homeProvider.isBottomSheetOpened) {
                      if ((globalKey.currentState?.validate() ?? false) &&
                          homeProvider.selectedDate != null) {
                        await FirestoreHelper.addNewTask(
                          task: TaskModel(
                            title: titleController.text,
                            description: descController.text,
                            date: DateTime(
                              homeProvider.selectedDate!.year,
                              homeProvider.selectedDate!.month,
                              homeProvider.selectedDate!.day,
                            ).millisecondsSinceEpoch,
                            time: homeProvider.selectedTime == null
                                ? DateFormat.jm().format(DateTime(
                                    homeProvider.selectedDate!.year,
                                    homeProvider.selectedDate!.month,
                                    homeProvider.selectedDate!.day,
                                    24,
                                    0))
                                : DateFormat.jm().format(DateTime(
                                    homeProvider.selectedDate!.year,
                                    homeProvider.selectedDate!.month,
                                    homeProvider.selectedDate!.day,
                                    homeProvider.selectedTime!.hour,
                                    homeProvider.selectedTime!.minute)),
                          ),
                          userID: provider.fireBaseUserAuth!.uid,
                        );

                        titleController.text = '';
                        descController.text = '';
                        Navigator.pop(context);
                        homeProvider.changeBootomSheetValue();
                      }
                    } else {
                      showAddTaskBottomSheet(context, homeProvider);
                      homeProvider.changeBootomSheetValue();
                    }
                  },
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  shape: RoundedRectangleBorder(
                      side: BorderSide(
                          width: 3,
                          color: Theme.of(context).colorScheme.onPrimary),
                      borderRadius: BorderRadius.circular(100)),
                  child: homeProvider.isBottomSheetOpened
                      ? Icon(
                          Icons.check,
                          color: Theme.of(context).colorScheme.onPrimary,
                        )
                      : Icon(
                          Icons.add,
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                )
              : null,
    );
  }

  void showAddTaskBottomSheet(BuildContext context, HomeProvider homeProvider) {
    scaffoldKey.currentState?.showBottomSheet(
      enableDrag: false,
      elevation: 0,
      backgroundColor: Colors.transparent,
      (context) {
        return AddTaskSheet(
          ontap: () {
            homeProvider.changeBootomSheetValue();
            Navigator.pop(context);
          },
          formkey: globalKey,
          titleController: titleController,
          descController: descController,
        );
      },
    );
  }
}

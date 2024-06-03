import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:todo/layout/Home/provider/home_provider.dart';

typedef OnMenuItemClick = void Function(MenuItem item);

class HomeDrawerWidget extends StatelessWidget {
  const HomeDrawerWidget({super.key, required this.itemClick});
  final OnMenuItemClick itemClick;
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<HomeProvider>(context);
    return Drawer(
      child: Column(
        children: [
          Container(
            alignment: Alignment.center,
            color: Theme.of(context).colorScheme.primary,
            width: double.infinity,
            padding: const EdgeInsets.symmetric(
              vertical: 50,
            ),
            child: Text(""
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          GestureDetector(
            onTap: () {
            },
            child: Row(
              children: [
                const Icon(
                  Icons.list,
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                   "",
                  style: Theme.of(context).textTheme.labelMedium,
                )
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          GestureDetector(
            onTap: () {
            },
            child: Row(
              children: [
                const Icon(
                  Icons.settings,
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  AppLocalizations.of(context)?.settings ?? "",
                  style: Theme.of(context).textTheme.labelMedium,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

enum MenuItem { categories, settings }

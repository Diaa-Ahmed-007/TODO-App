import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:todo/layout/Home/provider/settings_provider.dart';
import 'package:todo/layout/login/screen/login_screen.dart';
import 'package:todo/shared/providers/auth_provider.dart';

class SettingsTab extends StatelessWidget {
  const SettingsTab({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> theme = [
      AppLocalizations.of(context)!.light,
      AppLocalizations.of(context)!.dark
    ];

    List<String> language = [
      AppLocalizations.of(context)!.english,
      AppLocalizations.of(context)!.arabic
    ];

    var hight = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    var provider = Provider.of<SettingsProvider>(context);
    MyAuthProvider myAuthProvider = Provider.of<MyAuthProvider>(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: hight * 0.05),
          child: AppBar(
            elevation: 0,
            automaticallyImplyLeading: false,
            backgroundColor: Theme.of(context).colorScheme.primary,
            toolbarHeight: hight * 0.2,
            title: Text(
              AppLocalizations.of(context)!.settings,
              style: Theme.of(context).textTheme.labelLarge,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                AppLocalizations.of(context)!.language,
                style: Theme.of(context)
                    .textTheme
                    .displayMedium
                    ?.copyWith(fontSize: 18),
              ),
              const SizedBox(
                height: 16,
              ),
              Container(
                height: 60,
                width: double.infinity,
                margin: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.onPrimary,
                  border: Border.all(
                      color: Theme.of(context).colorScheme.primary, width: 1),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: DropdownButton<String>(
                    dropdownColor: Theme.of(context).colorScheme.onPrimary,
                    value: provider.selectedLanguage == 'en'
                        ? AppLocalizations.of(context)!.english
                        : AppLocalizations.of(context)!.arabic,
                    enableFeedback: false,
                    itemHeight: 100,
                    underline: const Text(""),
                    isExpanded: true,
                    iconEnabledColor: Theme.of(context).colorScheme.primary,
                    items: language
                        .map((e) => DropdownMenuItem<String>(
                            value: e,
                            child: Text(
                              e,
                              style: TextStyle(
                                  color: Theme.of(context).colorScheme.primary,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500),
                            )))
                        .toList(),
                    onChanged: (value) {
                      provider.changeSelectedLanguage(
                          value == AppLocalizations.of(context)!.english
                              ? 'en'
                              : 'ar');
                    },
                  ),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Text(
                AppLocalizations.of(context)!.mode,
                style: Theme.of(context)
                    .textTheme
                    .displayMedium
                    ?.copyWith(fontSize: 18),
              ),
              const SizedBox(
                height: 16,
              ),
              Container(
                height: 60,
                width: double.infinity,
                margin: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.onPrimary,
                  border: Border.all(
                      color: Theme.of(context).colorScheme.primary, width: 1),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: DropdownButton<String>(
                    dropdownColor: Theme.of(context).colorScheme.onPrimary,
                    value: provider.currentTheme == "Light" ||
                            provider.currentTheme == "ساطع"
                        ? AppLocalizations.of(context)!.light
                        : AppLocalizations.of(context)!.dark,
                    underline: const Text(""),
                    enableFeedback: false,
                    itemHeight: 100,
                    isExpanded: true,
                    iconEnabledColor: Theme.of(context).colorScheme.primary,
                    items: theme
                        .map((e) => DropdownMenuItem<String>(
                            value: e,
                            child: Text(
                              e,
                              style: TextStyle(
                                  color: Theme.of(context).colorScheme.primary,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500),
                            )))
                        .toList(),
                    onChanged: (value) {
                      provider.changeTheme(
                          value == AppLocalizations.of(context)!.light
                              ? 'Light'
                              : 'Dark');
                    },
                  ),
                ),
              ),
              SizedBox(
                height: hight * 0.2,
              ),
              Align(
                alignment: Alignment.center,
                child: SizedBox(
                  width: width * 0.5,
                  height: hight * 0.05,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    onPressed: () {
                      myAuthProvider.signOut();
                      Navigator.pushReplacementNamed(
                          context, LoginScreen.routeName);
                    },
                    child: Text(AppLocalizations.of(context)!.logout),
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}

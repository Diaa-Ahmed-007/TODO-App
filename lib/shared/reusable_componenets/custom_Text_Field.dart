import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:todo/layout/Home/provider/settings_provider.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    required this.labelWord,
    super.key,
    required this.controller,
    required this.val,
    this.iconbuttoneye,
    required this.passwordVisible,
    required this.preIcon,
  });
  final String labelWord;
  final TextEditingController controller;
  final String? Function(String?) val;
  final Widget? iconbuttoneye;
  final bool passwordVisible;
  final String preIcon;
  @override
  Widget build(BuildContext context) {
    SettingsProvider settingsProvider = Provider.of<SettingsProvider>(context);

    return Padding(
      padding: const EdgeInsets.all(16),
      child: TextFormField(
        clipBehavior: Clip.hardEdge,
        validator: val,
        controller: controller,
        cursorColor: settingsProvider.getThemeMode() == ThemeMode.light
            ? Colors.black
            : Colors.white,
        style: TextStyle(
            color: settingsProvider.getThemeMode() == ThemeMode.light
                ? Colors.black
                : Colors.white),
        obscureText: passwordVisible,
        decoration: InputDecoration(
            prefixIcon: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: SvgPicture.asset(
                preIcon,
                colorFilter: ColorFilter.mode(
                    settingsProvider.getThemeMode() == ThemeMode.light
                        ? Colors.grey[700]!
                        : Colors.white,
                    BlendMode.srcIn),
              ),
            ),
            suffixIcon: iconbuttoneye,
            suffixIconColor: settingsProvider.getThemeMode() == ThemeMode.light
                ? Colors.black54
                : Colors.white54,
            hintText: labelWord,
            hintStyle: TextStyle(
                color: settingsProvider.getThemeMode() == ThemeMode.light
                    ? Colors.grey[700]
                    : Colors.white),
            hintMaxLines: 1,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide(
                color: Colors.grey[700]!,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: const BorderSide(
                  color: Colors.white, style: BorderStyle.solid),
            ),
            focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: const BorderSide(color: Colors.red)),
            errorStyle: const TextStyle(color: Colors.red),
            errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: const BorderSide(color: Colors.red)),
            fillColor: settingsProvider.getThemeMode() == ThemeMode.light
                ? Colors.white
                : Colors.transparent,
            filled: true),
      ),
    );
  }
}

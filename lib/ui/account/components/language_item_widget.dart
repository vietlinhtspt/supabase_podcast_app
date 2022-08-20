import 'package:flutter/material.dart';

class LanguageItemWidget extends StatelessWidget {
  const LanguageItemWidget({
    Key? key,
    required this.title,
    this.isSelected = false,
    required this.onTap,
  }) : super(key: key);

  final String title;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Container(
        decoration: BoxDecoration(
            border: isSelected
                ? null
                : Border.all(color: Theme.of(context).primaryColor),
            gradient: isSelected
                ? LinearGradient(colors: [
                    Theme.of(context).colorScheme.secondary,
                    Theme.of(context).colorScheme.primary,
                  ])
                : null,
            borderRadius: BorderRadius.circular(15)),
        child: TextButton(
          onPressed: onTap,
          child: Container(
            height: 50,
            width: MediaQuery.of(context).size.width > 342
                ? 342
                : MediaQuery.of(context).size.width,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                FittedBox(
                  child: Text(
                    title,
                    style: TextStyle(
                      color: isSelected
                          ? Theme.of(context).colorScheme.surface
                          : Theme.of(context).colorScheme.onSurface,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

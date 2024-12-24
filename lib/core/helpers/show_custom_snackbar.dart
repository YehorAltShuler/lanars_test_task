import 'package:flutter/material.dart';

void showCustomSnackBar({
  required BuildContext context,
  required String message,
  Color? backgroundColor,
  Duration duration = const Duration(seconds: 3),
  SnackBarAction? action,
  bool showCloseIcon = false,
}) {
  final snackBar = SnackBar(
    behavior: SnackBarBehavior.floating,
    margin: EdgeInsets.symmetric(horizontal: 8, vertical: 15),
    content: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
          child: Text(
            message,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onInverseSurface,
                ),
          ),
        ),
        if (showCloseIcon)
          GestureDetector(
            onTap: () {
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
            },
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              child: Icon(Icons.close, color: Colors.white, size: 20),
            ),
          ),
      ],
    ),
    backgroundColor: backgroundColor,
    duration: duration,
    action: action,
  );

  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar() // Скрыть текущий SnackBar, если он есть
    ..showSnackBar(snackBar); // Показать новый SnackBar
}

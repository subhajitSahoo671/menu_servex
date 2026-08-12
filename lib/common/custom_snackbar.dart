import 'package:flutter/material.dart';

extension SnackbarExtension on BuildContext {
  void showSnackBar({
    required String message,
    Color backgroundColor = Colors.black,
    Duration duration = const Duration(seconds: 3),
  }) {
    // Clear any existing snackbars before showing a new one
    ScaffoldMessenger.of(this).clearSnackBars();

    // Display the snackbar
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: backgroundColor,
        duration: duration,
        behavior: SnackBarBehavior.floating, // Makes it float above the bottom
      ),
    );
  }
}

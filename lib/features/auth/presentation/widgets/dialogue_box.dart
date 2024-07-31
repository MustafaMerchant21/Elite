import 'package:elite/core/constants.dart';
import 'package:flutter/material.dart';
import 'package:elite/core/theme/palette.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class CustomDialogue extends StatelessWidget {
  final String title;
  final String content;
  final VoidCallback onConfirm;
  final VoidCallback? onCancel;
  final String confirmText;
  final String cancelText;
  final bool showCancelButton;
  final bool isLoading;
  static _buttonStyle() => ButtonStyle(
    overlayColor: WidgetStateProperty.all<Color>(AppPalette.primaryColor.withAlpha(20)),
  );

  const CustomDialogue({
    super.key,
    required this.title,
    required this.content,
    required this.onConfirm,
    this.onCancel,
    this.confirmText = "Confirm",
    this.cancelText = "Cancel",
    this.showCancelButton = true,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    return isLoading
    ?  Center(
      child: LoadingAnimationWidget.horizontalRotatingDots(
        color: Theme.of(context).primaryColor,
        size: 50,
      ),
    )
    : AlertDialog(
      backgroundColor: AppPalette.backgroundColor,
      title: Text(title, style: const TextStyle(
          color: AppPalette.primaryColor,
          fontFamily: "$font Expanded Heavy"
      )),
      content: Text(content, style: const TextStyle(
          color: AppPalette.primaryColor,
          fontFamily: "$font Semi Expanded Black"
      )),
      actions: [
        if (showCancelButton)
          TextButton(
            style: _buttonStyle(),
            onPressed: onCancel ?? () => Navigator.of(context).pop(),
            child: Text(cancelText, style: const TextStyle(
                color: AppPalette.textColor,
                fontFamily: "$font Semi Expanded Black"
            )),
          ),
        TextButton(
          style: _buttonStyle(),
          onPressed: onConfirm,
          child: Text(confirmText, style: const TextStyle(
              color: AppPalette.primaryColor,
              fontFamily: "$font Semi Expanded Black"
          )),
        ),
      ],
    );
  }
}

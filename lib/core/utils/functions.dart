import 'package:flutter/material.dart';
import 'package:task/core/utils/app_router.dart';

import '../widget/loading_dialog.dart';

class Functions {
  static void showLoadingDialog({bool dismissible = false}) {
    showDialog(
      context: AppRouter.navigatorKey.currentContext!,
      barrierDismissible: dismissible,
      builder: (BuildContext context) {
        return PopScope(canPop: dismissible, child: const LoadingDialog());
      },
    );
  }

  static void showCustomDialog(
    Widget widget, {
    bool dismissible = true,
    BuildContext? context,
  }) {
    showDialog(
      context: context ?? AppRouter.navigatorKey.currentContext!,
      barrierDismissible: dismissible,
      builder: (BuildContext context) {
        return PopScope(canPop: dismissible, child: widget);
      },
    );
  }

  static Future<T?> showCustomBottomSheet<T>(
    Widget child, {
    bool isScrollControlled = true,
    BuildContext? context,
    VoidCallback? onDismissed,
  }) {
    return showModalBottomSheet<T>(
      context: context ?? AppRouter.navigatorKey.currentContext!,
      isScrollControlled: isScrollControlled,
      useSafeArea: true,
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: child,
        );
      },
    ).then((result) {
      // Call onDismissed callback when bottom sheet is dismissed
      if (onDismissed != null) {
        onDismissed();
      }
      return result;
    });
  }

  static void showSnackBar(
    String text, {
    BuildContext? context,
    int duration = 3,
    Function()? onHide,
  }) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ScaffoldMessenger.of(
        context ?? AppRouter.navigatorKey.currentState!.context,
      ).showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          content: Text(text),
          duration: Duration(seconds: duration),
        ),
      );
    });
    if (onHide != null) {
      Future.delayed(Duration(seconds: duration), onHide);
    }
  }

  static getCurrentMillisecondsTimeStampUtc() {
    return DateTime.now().toUtc().millisecondsSinceEpoch;
  }

  static void showAlerDialog({
    bool dismissible = true,
    required String title,
    required String message,
    required String buttonOneText,
    String? buttonTwoText,
    String? buttonThreeText,
    void Function()? onButtonOnePressed,
    void Function()? onButtonTwoPressed,
    void Function()? onButtonThreePressed,
  }) {
    showDialog(
      context: AppRouter.navigatorKey.currentContext!,
      barrierDismissible: dismissible,
      builder: (BuildContext context) {
        return PopScope(
          canPop: dismissible,
          child: AlertDialog(
            title: Text(title),
            content: Text(message),
            actions: <Widget>[
              TextButton(
                child: Text(buttonOneText),
                onPressed: () {
                  Navigator.of(context).pop();
                  onButtonOnePressed?.call();
                },
              ),
              buttonTwoText != null
                  ? TextButton(
                      child: Text(buttonTwoText),
                      onPressed: () {
                        Navigator.of(context).pop();
                        onButtonTwoPressed?.call();
                      },
                    )
                  : Container(),
              buttonThreeText != null
                  ? TextButton(
                      child: Text(buttonThreeText),
                      onPressed: () {
                        Navigator.of(context).pop();
                        onButtonThreePressed?.call();
                      },
                    )
                  : Container(),
            ],
          ),
        );
      },
    );
  }
}

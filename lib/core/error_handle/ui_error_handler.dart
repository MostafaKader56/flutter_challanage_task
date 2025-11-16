import 'package:flutter/material.dart';
import 'package:task/core/error_handle/error_type.dart';

import '../../generated/l10n.dart';

class UIErrorHandler {
  static String getLocalizedMessage(ErrorType errorType, BuildContext context) {
    switch (errorType) {
      default:
        return S.of(context).unexpectedError;
    }
  }
}

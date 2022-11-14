import 'package:domain/exceptions/date_validation_exception.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:presentation/screens/payment/data/payment_data.dart';

abstract class PaymentViewMapper {
  factory PaymentViewMapper() => _PaymentViewMapperImpl();

  String? stateToDateErrorMessage(
    PaymentData state,
    BuildContext context,
  );
}

class _PaymentViewMapperImpl implements PaymentViewMapper {
  @override
  String? stateToDateErrorMessage(
    PaymentData state,
    BuildContext context,
  ) {
    final appLocalizations = AppLocalizations.of(context)!;

    switch (state.dateValidationStatus) {
      case DateValidationExceptionStatus.emptyMonth:
        return appLocalizations.dateValidationEmptyMonthMessage;
      case DateValidationExceptionStatus.emptyYear:
        return appLocalizations.dateValidationEmptyYearMessage;
      case DateValidationExceptionStatus.outRangeMonth:
        return appLocalizations.dateValidationMonthOutOfRange;
      case DateValidationExceptionStatus.dateExpired:
        return appLocalizations.dateValidationDateExpired;
      case null:
        return null;
    }
  }
}

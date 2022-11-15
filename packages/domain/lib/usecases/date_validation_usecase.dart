import 'package:domain/exceptions/date_validation_exception.dart';
import 'package:domain/usecases/usecase.dart';

class DateValidationUseCase implements UseCaseParams<String, void> {
  @override
  void call(String params) {
    if (params.isEmpty) {
      throw DateValidationException(DateValidationExceptionStatus.emptyMonth);
    }

    final monthAndYear = params.split('/');

    final month = int.tryParse(monthAndYear.first);

    if (month == null) {
      throw DateValidationException(DateValidationExceptionStatus.invalidMonth);
    }

    if (month > 12) {
      throw DateValidationException(
        DateValidationExceptionStatus.outRangeMonth,
      );
    }

    if (monthAndYear.length == 2) {
      final year = int.tryParse(monthAndYear.last);

      if (year == null) {
        throw DateValidationException(
          DateValidationExceptionStatus.invalidYear,
        );
      }

      final todaysDate = DateTime.now();
      final currentYear = int.parse(todaysDate.year.toString().substring(2));
      final currentMonth = todaysDate.month;

      if (currentYear > year || (currentYear <= year && currentMonth > month)) {
        throw DateValidationException(
          DateValidationExceptionStatus.dateExpired,
        );
      }
    } else {
      throw DateValidationException(DateValidationExceptionStatus.emptyYear);
    }
  }
}

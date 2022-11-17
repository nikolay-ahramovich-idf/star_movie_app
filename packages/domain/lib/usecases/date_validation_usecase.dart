import 'package:domain/exceptions/date_validation_exception.dart';
import 'package:domain/usecases/usecase.dart';

class DateModel {
  final int? month;
  final int? year;

  const DateModel(
    this.month,
    this.year,
  );
}

class DateValidationUseCase implements UseCaseParams<DateModel, void> {
  @override
  void call(DateModel params) {
    final month = params.month;

    if (month == null) {
      throw DateValidationException(DateValidationExceptionStatus.emptyMonth);
    }

    if (month > 12) {
      throw DateValidationException(
        DateValidationExceptionStatus.outRangeMonth,
      );
    }

    final year = params.year;

    if (year == null) {
      throw DateValidationException(DateValidationExceptionStatus.emptyYear);
    }

    final todaysDate = DateTime.now();
    final currentYear = int.parse(todaysDate.year.toString().substring(2));
    final currentMonth = todaysDate.month;

    if (currentYear > year || (currentYear <= year && currentMonth > month)) {
      throw DateValidationException(DateValidationExceptionStatus.dateExpired);
    }
  }
}

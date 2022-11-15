enum DateValidationExceptionStatus {
  emptyMonth,
  invalidMonth,
  emptyYear,
  invalidYear,
  outRangeMonth,
  dateExpired,
}

class DateValidationException implements Exception {
  final DateValidationExceptionStatus? dateValidationStatus;

  DateValidationException(
    this.dateValidationStatus,
  );
}

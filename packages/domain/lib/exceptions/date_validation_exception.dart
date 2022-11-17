enum DateValidationExceptionStatus {
  emptyMonth,
  emptyYear,
  outRangeMonth,
  dateExpired,
}

class DateValidationException implements Exception {
  final DateValidationExceptionStatus? dateValidationStatus;

  DateValidationException(
    this.dateValidationStatus,
  );
}

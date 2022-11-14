import 'package:domain/exceptions/date_validation_exception.dart';

class PaymentData {
  final DateValidationExceptionStatus? dateValidationStatus;

  PaymentData(this.dateValidationStatus);

  const PaymentData.init() : dateValidationStatus = null;
}

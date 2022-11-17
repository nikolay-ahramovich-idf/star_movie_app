import 'package:domain/exceptions/date_validation_exception.dart';
import 'package:domain/usecases/date_validation_usecase.dart';
import 'package:flutter/material.dart';
import 'package:presentation/bloc/base/bloc.dart';
import 'package:presentation/bloc/base/bloc_impl.dart';
import 'package:presentation/navigation/base_arguments.dart';
import 'package:presentation/screens/payment/data/payment_data.dart';

abstract class PaymentBloc implements Bloc<BaseArguments, PaymentData> {
  factory PaymentBloc(DateValidationUseCase dateValidationUseCase) =>
      _PaymentBloc(
        dateValidationUseCase,
      );

  GlobalKey<FormState> get formStateGlobalKey;

  TextEditingController get phoneNumberController;

  TextEditingController get cardNumberController;

  TextEditingController get dateController;

  TextEditingController get cvvController;

  void onSubmit();
}

class _PaymentBloc extends BlocImpl<BaseArguments, PaymentData>
    implements PaymentBloc {
  final DateValidationUseCase _dateValidationUseCase;

  final _formStateGlobalKey = GlobalKey<FormState>();
  final _phoneNumberController = TextEditingController();
  final _cardNumberController = TextEditingController();
  final _dateController = TextEditingController();
  final _cvvController = TextEditingController();

  _PaymentBloc(this._dateValidationUseCase)
      : super(
          initState: const PaymentData.init(),
        );

  @override
  GlobalKey<FormState> get formStateGlobalKey => _formStateGlobalKey;

  @override
  TextEditingController get phoneNumberController => _phoneNumberController;

  @override
  TextEditingController get cardNumberController => _cardNumberController;

  @override
  TextEditingController get dateController => _dateController;

  @override
  TextEditingController get cvvController => _cvvController;

  @override
  void onSubmit() {
    try {
      final date = _parseDate(_dateController.text);

      _dateValidationUseCase(date);

      if (state.dateValidationStatus != null) {
        add(PaymentData(null));
      }
    } on DateValidationException catch (e) {
      add(PaymentData(e.dateValidationStatus));
    }

    formStateGlobalKey.currentState?.validate();
  }

  @override
  void dispose() {
    _phoneNumberController.dispose();
    _cardNumberController.dispose();
    _dateController.dispose();
    _cvvController.dispose();

    super.dispose();
  }

  DateModel _parseDate(String date) {
    final dateRegExp = RegExp(r'^(\d{2})?\/?(\d{2})?$');

    final matches = dateRegExp.firstMatch(date);

    final month = int.tryParse(matches?.group(1) ?? '');
    final year = int.tryParse(matches?.group(2) ?? '');

    return DateModel(
      month,
      year,
    );
  }
}

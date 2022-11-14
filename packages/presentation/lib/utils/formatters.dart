import 'package:flutter/services.dart';

class PhoneInputFormatter implements TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text.length < oldValue.text.length) {
      return TextEditingValue(
        text: newValue.text,
        selection: TextSelection.collapsed(
          offset: newValue.text.length,
        ),
      );
    }

    final phoneRegExp = RegExp(
        r'^(\+375|\+37|\+3|\+)?\s?\(?(\d{1,2})?\)?\s?(\d{1,3})?[-]?(\d{1,2})?[-]?(\d{1,2})?');

    final matches = phoneRegExp.firstMatch(newValue.text);

    final phoneNumber = _formatPhone(
      countryCode: matches?.group(1) ?? '',
      providerCode: matches?.group(2) ?? '',
      firstPart: matches?.group(3) ?? '',
      secondPart: matches?.group(4) ?? '',
      thirdPart: matches?.group(5) ?? '',
    );

    return TextEditingValue(
      text: phoneNumber,
      selection: TextSelection.collapsed(
        offset: phoneNumber.length,
      ),
    );
  }

  String _formatPhone({
    required String countryCode,
    required String providerCode,
    required String firstPart,
    required String secondPart,
    required String thirdPart,
  }) {
    if (providerCode.length == 1) {
      providerCode = '($providerCode';
      countryCode = '+375 ';
    } else if (providerCode.length > 1) {
      providerCode = ' ($providerCode) ';
    }

    if (firstPart.length == 3) {
      firstPart = '$firstPart-';
    }

    if (secondPart.length == 2) {
      secondPart = '$secondPart-';
    }

    return '$countryCode$providerCode$firstPart$secondPart$thirdPart';
  }
}

class CardNumberInputFormatter implements TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.length < oldValue.text.length) {
      return TextEditingValue(
        text: newValue.text,
        selection: TextSelection.collapsed(
          offset: newValue.text.length,
        ),
      );
    } else if (newValue.text.length == 20) {
      return TextEditingValue(
        text: oldValue.text,
        selection: TextSelection.collapsed(
          offset: oldValue.text.length,
        ),
      );
    }

    final cardNumberRegExp =
        RegExp(r'^(\d{1,4})?\s?(\d{1,4})?\s?(\d{1,4})?\s?(\d{1,4})?$');

    final matches = cardNumberRegExp.firstMatch(newValue.text);

    final cardNumber = _formatCardNumber(
      firstPart: matches?.group(1) ?? '',
      secondPart: matches?.group(2) ?? '',
      thirdPart: matches?.group(3) ?? '',
      fourthPart: matches?.group(4) ?? '',
    );

    return TextEditingValue(
      text: cardNumber,
      selection: TextSelection.collapsed(
        offset: cardNumber.length,
      ),
    );
  }

  String _formatCardNumber({
    required String firstPart,
    required String secondPart,
    required String thirdPart,
    required String fourthPart,
  }) {
    if (firstPart.length == 4) {
      firstPart = '$firstPart ';
    }

    if (secondPart.length == 4) {
      secondPart = '$secondPart ';
    }

    if (thirdPart.length == 4) {
      thirdPart = '$thirdPart ';
    }

    return '$firstPart$secondPart$thirdPart$fourthPart';
  }
}

class DateInputFormatter implements TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.length < oldValue.text.length) {
      return TextEditingValue(
        text: newValue.text,
        selection: TextSelection.collapsed(
          offset: newValue.text.length,
        ),
      );
    } else if (newValue.text.length == 6) {
      return TextEditingValue(
        text: oldValue.text,
        selection: TextSelection.collapsed(
          offset: oldValue.text.length,
        ),
      );
    }

    final dateRegExp = RegExp(r'^(\d{2})?\/?(\d{1,2})?$');

    final matches = dateRegExp.firstMatch(newValue.text);

    final date = _formatDate(
      month: matches?.group(1) ?? '',
      day: matches?.group(2) ?? '',
    );

    return TextEditingValue(
      text: date,
      selection: TextSelection.collapsed(
        offset: date.length,
      ),
    );
  }

  String _formatDate({
    required String month,
    required String day,
  }) {
    if (month.length == 2) {
      month = '$month/';
    }

    return '$month$day';
  }
}

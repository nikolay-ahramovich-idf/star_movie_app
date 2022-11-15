import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get_it/get_it.dart';
import 'package:presentation/bloc/base/bloc_screen.dart';
import 'package:presentation/const.dart';
import 'package:presentation/navigation/base_page.dart';
import 'package:presentation/screens/payment/payment_bloc.dart';
import 'package:presentation/screens/payment/payment_view_mapper.dart';
import 'package:presentation/utils/colors.dart';
import 'package:presentation/utils/dimensions.dart';
import 'package:presentation/utils/formatters.dart';

class PaymentScreen extends StatefulWidget {
  final paymentViewMapper = GetIt.I.get<PaymentViewMapper>();

  PaymentScreen({super.key});

  static const _routeName = '/PaymentScreen';

  static String get routeName => _routeName;

  static BasePage page() => BasePage(
        key: const ValueKey(_routeName),
        name: _routeName,
        builder: (_) => PaymentScreen(),
      );

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends BlocScreenState<PaymentScreen, PaymentBloc> {
  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.primaryColor,
        title: Text(appLocalizations.paymentScreenLabel),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSizes.screensHorizontalPadding,
        ),
        child: Center(
          child: Form(
            key: bloc.formStateGlobalKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  appLocalizations.phoneNumberFieldLabel,
                  style: const TextStyle(color: AppColors.white),
                ),
                const SizedBox(height: AppSizes.size4),
                TextFormField(
                  controller: bloc.phoneNumberController,
                  inputFormatters: [PhoneInputFormatter()],
                  keyboardType: TextInputType.phone,
                  decoration: const InputDecoration(
                    disabledBorder: InputBorder.none,
                    filled: true,
                    fillColor: LoginScreenColors.inputFieldBackgroundColor,
                  ),
                  style: const TextStyle(
                    color: AppColors.transparentWhite50,
                  ),
                ),
                const SizedBox(height: AppSizes.size24),
                Text(
                  appLocalizations.cardNumberFieldLabel,
                  style: const TextStyle(color: AppColors.white),
                ),
                const SizedBox(height: AppSizes.size4),
                TextFormField(
                  controller: bloc.cardNumberController,
                  inputFormatters: [CardNumberInputFormatter()],
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    disabledBorder: InputBorder.none,
                    filled: true,
                    fillColor: LoginScreenColors.inputFieldBackgroundColor,
                  ),
                  style: const TextStyle(
                    color: AppColors.transparentWhite50,
                  ),
                ),
                const SizedBox(height: AppSizes.size24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: AppSizes.size131,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            appLocalizations.validThruFieldLabel,
                            style: const TextStyle(color: AppColors.white),
                          ),
                          const SizedBox(height: AppSizes.size4),
                          TextFormField(
                            controller: bloc.dateController,
                            validator: (_) => widget.paymentViewMapper
                                .stateToDateErrorMessage(
                              bloc.state,
                              context,
                            ),
                            inputFormatters: [DateInputFormatter()],
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              disabledBorder: InputBorder.none,
                              filled: true,
                              fillColor:
                                  LoginScreenColors.inputFieldBackgroundColor,
                            ),
                            style: const TextStyle(
                              color: AppColors.transparentWhite50,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: AppSizes.size24),
                    SizedBox(
                      width: AppSizes.size80,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            appLocalizations.cvvFieldLabel,
                            style: const TextStyle(color: AppColors.white),
                          ),
                          const SizedBox(
                            height: AppSizes.size4,
                          ),
                          TextFormField(
                            controller: bloc.cvvController,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              LengthLimitingTextInputFormatter(
                                PaymentScreenConfig.cvvLength,
                              )
                            ],
                            keyboardType: TextInputType.number,
                            obscureText: true,
                            decoration: const InputDecoration(
                              disabledBorder: InputBorder.none,
                              filled: true,
                              fillColor:
                                  LoginScreenColors.inputFieldBackgroundColor,
                            ),
                            style: const TextStyle(
                              color: AppColors.transparentWhite50,
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
                const SizedBox(height: AppSizes.size45),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.red,
                    ),
                    onPressed: bloc.onSubmit,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: AppSizes.size15,
                      ),
                      child: Text(
                        appLocalizations.paymentButtonLabel,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

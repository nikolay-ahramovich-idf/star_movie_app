import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:presentation/bloc/base/bloc_screen.dart';
import 'package:presentation/const.dart';
import 'package:presentation/navigation/base_page.dart';
import 'package:presentation/screens/login/data/login_data.dart';
import 'package:presentation/screens/login/login_bloc.dart';
import 'package:presentation/screens/login/widgets/auth_icon_button_widget.dart';
import 'package:presentation/utils/colors.dart';
import 'package:presentation/utils/dimensions.dart';
import 'package:presentation/utils/styles.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  static const _routeName = '/LoginScreen';

  static BasePage page() => BasePage(
        key: const ValueKey(_routeName),
        name: _routeName,
        builder: (_) => const LoginScreen(),
      );

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends BlocScreenState<LoginScreen, LoginBloc> {
  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.primaryColor,
        centerTitle: false,
        title: Text(
          appLocalizations.profileLabel,
          style: AppStyles.appBarStyle,
        ),
        actions: [
          Center(
            child: Padding(
              padding: const EdgeInsets.only(
                right: AppSizes.screensHorizontalPadding,
              ),
              child: Text(
                appLocalizations.signUpButtonLabel,
                style: LoginScreenStyles.signUpButtonStyle,
              ),
            ),
          ),
        ],
      ),
      body: StreamBuilder<LoginData?>(
          stream: bloc.stream,
          builder: (context, snapshot) {
            return Container(
              decoration: const BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: AppColors.dividersColor,
                    width: AppSizes.size1,
                  ),
                ),
                color: AppColors.primaryColor,
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSizes.screensHorizontalPadding,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: AppSizes.size1),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          appLocalizations.userNameInputLabel.toUpperCase(),
                          style: LoginScreenStyles.inputLabelsStyle,
                        ),
                        const SizedBox(height: AppSizes.size12),
                        TextField(
                          keyboardType: TextInputType.emailAddress,
                          style: const TextStyle(
                            color: AppColors.transparentWhite50,
                          ),
                          decoration: InputDecoration(
                              disabledBorder: InputBorder.none,
                              filled: true,
                              fillColor:
                                  LoginScreenColors.inputFieldBackgroundColor,
                              prefixIcon: Image.asset(
                                  AssetsImagesPaths.usernameIconPath)),
                          onChanged: bloc.updateLogin,
                        ),
                        const SizedBox(height: AppSizes.size16),
                        Text(
                          appLocalizations.passwordInputLabel.toUpperCase(),
                          style: LoginScreenStyles.inputLabelsStyle,
                        ),
                        const SizedBox(height: AppSizes.size12),
                        TextField(
                          obscureText: true,
                          style: const TextStyle(
                            color: AppColors.transparentWhite50,
                          ),
                          decoration: InputDecoration(
                              disabledBorder: InputBorder.none,
                              filled: true,
                              fillColor:
                                  LoginScreenColors.inputFieldBackgroundColor,
                              prefixIcon: Image.asset(
                                  AssetsImagesPaths.passwordIconPath)),
                          onChanged: bloc.updatePassword,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: AppSizes.size32,
                          ),
                          child: Center(
                            child: Text(
                              appLocalizations.forgotPasswordButtonLabel,
                              style: LoginScreenStyles.forgotPasswordLabelStyle,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.red,
                            ),
                            onPressed: bloc.onLogin,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: AppSizes.size15,
                              ),
                              child: Text(
                                appLocalizations.loginButtonLabel,
                                style: LoginScreenStyles.loginButtonTextStyle,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: AppSizes.size35),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const AuthIconButtonWidget(
                            AssetsImagesPaths.twitterIconPath,
                            color: AppColors.twitterColor,
                            onPressAction: null,
                          ),
                          const SizedBox(width: AppSizes.size24),
                          AuthIconButtonWidget(
                            AssetsImagesPaths.facebookIconPath,
                            color: AppColors.facebookColor,
                            onPressAction: () => print('Implement Faceboock'),
                          ),
                          const SizedBox(width: AppSizes.size24),
                          AuthIconButtonWidget(
                            AssetsImagesPaths.googleIconPath,
                            color: AppColors.googleColor,
                            onPressAction: () => print('Implement Google'),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}

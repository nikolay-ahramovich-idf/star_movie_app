import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get_it/get_it.dart';
import 'package:presentation/bloc/base/bloc_screen.dart';
import 'package:presentation/const.dart';
import 'package:presentation/navigation/base_page.dart';
import 'package:presentation/screens/login/data/login_data.dart';
import 'package:presentation/screens/login/login_bloc.dart';
import 'package:presentation/screens/login/login_view_mapper.dart';
import 'package:presentation/screens/login/widgets/auth_icon_button_widget.dart';
import 'package:presentation/utils/colors.dart';
import 'package:presentation/utils/dimensions.dart';
import 'package:presentation/utils/responsive.dart';
import 'package:presentation/utils/styles.dart';

class LoginScreen extends StatefulWidget {
  final loginViewMapper = GetIt.I.get<LoginViewMapper>();

  LoginScreen({super.key});

  static const _routeName = '/LoginScreen';

  static String get routeName => _routeName;

  static BasePage page() => BasePage(
        key: const ValueKey(_routeName),
        name: _routeName,
        builder: (_) => LoginScreen(),
      );

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends BlocScreenState<LoginScreen, LoginBloc> {
  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;

    return Scaffold(
      resizeToAvoidBottomInset: false,
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
            final data = snapshot.data;

            final isDesktop = Responsive.isDesktop(context);

            if (data != null) {
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
                  child: Form(
                    key: bloc.formStateGlobalKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const SizedBox(height: AppSizes.size1),
                        Column(
                          crossAxisAlignment: !isDesktop
                              ? CrossAxisAlignment.start
                              : CrossAxisAlignment.center,
                          children: [
                            Text(
                              appLocalizations.userNameInputLabel,
                              style: LoginScreenStyles.inputLabelsStyle,
                            ),
                            const SizedBox(height: AppSizes.size12),
                            ConstrainedBox(
                              constraints: const BoxConstraints(
                                maxWidth: LoginScreenSizes.maxFieldSize,
                              ),
                              child: TextFormField(
                                autovalidateMode: AutovalidateMode.disabled,
                                validator: (_) => widget.loginViewMapper
                                    .stateToLoginErrorMessage(
                                  bloc.state,
                                  context,
                                ),
                                controller: bloc.loginController,
                                keyboardType: TextInputType.emailAddress,
                                style: const TextStyle(
                                  color: AppColors.transparentWhite50,
                                ),
                                decoration: InputDecoration(
                                  disabledBorder: InputBorder.none,
                                  filled: true,
                                  fillColor: LoginScreenColors
                                      .inputFieldBackgroundColor,
                                  prefixIcon: Image.asset(
                                    AssetsImagesPaths.usernameIconPath,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: AppSizes.size16),
                            Text(
                              appLocalizations.passwordInputLabel,
                              style: LoginScreenStyles.inputLabelsStyle,
                            ),
                            const SizedBox(height: AppSizes.size12),
                            ConstrainedBox(
                              constraints: const BoxConstraints(
                                maxWidth: LoginScreenSizes.maxFieldSize,
                              ),
                              child: TextFormField(
                                autovalidateMode: AutovalidateMode.disabled,
                                validator: (_) => widget.loginViewMapper
                                    .stateToPasswordErrorMessage(
                                  bloc.state,
                                  context,
                                ),
                                controller: bloc.passwordController,
                                obscureText: true,
                                style: const TextStyle(
                                  color: AppColors.transparentWhite50,
                                ),
                                decoration: InputDecoration(
                                  disabledBorder: InputBorder.none,
                                  filled: true,
                                  fillColor: LoginScreenColors
                                      .inputFieldBackgroundColor,
                                  prefixIcon: Image.asset(
                                    AssetsImagesPaths.passwordIconPath,
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: AppSizes.size32,
                              ),
                              child: Center(
                                child: Text(
                                  appLocalizations.forgotPasswordButtonLabel,
                                  style: LoginScreenStyles
                                      .forgotPasswordLabelStyle,
                                ),
                              ),
                            ),
                            ConstrainedBox(
                              constraints: const BoxConstraints(
                                maxWidth: LoginScreenSizes.maxButtonSize,
                              ),
                              child: SizedBox(
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
                                      style: LoginScreenStyles
                                          .loginButtonTextStyle,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.only(bottom: AppSizes.size35),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              AuthIconButtonWidget(
                                AssetsImagesPaths.twitterIconPath,
                                color: LoginScreenColors.twitterColor,
                                size: Responsive.adaptiveSize44(context),
                                onPressAction: null,
                              ),
                              const SizedBox(width: AppSizes.size24),
                              AuthIconButtonWidget(
                                AssetsImagesPaths.facebookIconPath,
                                color: LoginScreenColors.facebookColor,
                                size: Responsive.adaptiveSize44(context),
                                onPressAction: bloc.authByFacebook,
                              ),
                              const SizedBox(width: AppSizes.size24),
                              AuthIconButtonWidget(
                                AssetsImagesPaths.googleIconPath,
                                color: LoginScreenColors.googleColor,
                                size: Responsive.adaptiveSize44(context),
                                onPressAction: bloc.authByGoogle,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            } else {
              return Container();
            }
          }),
    );
  }
}

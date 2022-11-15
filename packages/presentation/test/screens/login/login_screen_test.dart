import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';
import 'package:presentation/screens/login/data/login_data.dart';
import 'package:presentation/screens/login/login_bloc.dart';
import 'package:presentation/screens/login/login_screen.dart';
import 'package:presentation/screens/login/login_view_mapper.dart';
import 'package:presentation/screens/login/widgets/auth_icon_button_widget.dart';

class MockLoginViewMapper extends Mock implements LoginViewMapper {}

class MockLoginBloc extends Mock implements LoginBloc {}

class MockLoginData extends Mock implements LoginData {}

void main() {
  GetIt.I.registerSingleton<LoginViewMapper>(MockLoginViewMapper());

  final mockLoginBloc = MockLoginBloc();

  GetIt.I.registerSingleton<LoginBloc>(mockLoginBloc);

  final loginScreen = MaterialApp(
    localizationsDelegates: AppLocalizations.localizationsDelegates,
    home: LoginScreen(),
  );

  setUp(() => WidgetsFlutterBinding.ensureInitialized());

  testWidgets(
      'LoginScreen widget has to display Container widget if data is null',
      (tester) async {
    when(() => mockLoginBloc.stream).thenAnswer((_) => Stream.value(null));

    await tester.pumpWidget(loginScreen);

    final container = find.byType(Container);

    expect(
      container,
      findsOneWidget,
    );
  });

  testWidgets(
    'LoginScreen takes login and password from facebook auth if facebook auth button is clicked',
    (tester) async {
      const validLogin = 'validLogin';
      const validPassword = 'validPassword';

      final mockLoginController = TextEditingController();
      when(() => mockLoginBloc.loginController).thenReturn(mockLoginController);

      final mockPasswordController = TextEditingController();
      when(() => mockLoginBloc.passwordController)
          .thenReturn(mockPasswordController);

      final mockGlobalKey = GlobalKey<FormState>();
      when((() => mockLoginBloc.formStateGlobalKey)).thenReturn(mockGlobalKey);

      final streamController = StreamController<LoginData?>();

      when(() => mockLoginBloc.initState()).thenAnswer((_) {
        streamController.add(const LoginData.init());
      });

      when(() => mockLoginBloc.stream)
          .thenAnswer((_) => streamController.stream);

      await tester.pumpWidget(loginScreen);
      await tester.pumpAndSettle();

      when(() => mockLoginBloc.authByFacebook()).thenAnswer((invocation) async {
        mockLoginController.text = validLogin;
        mockPasswordController.text = validPassword;
      });

      final authByFacebookIconButton = find.byType(AuthIconButtonWidget).at(1);

      await tester.tap(authByFacebookIconButton);
      await tester.pumpAndSettle();

      expect(
        mockLoginController.text,
        validLogin,
      );

      expect(
        mockPasswordController.text,
        validPassword,
      );

      mockLoginController.dispose();
      mockPasswordController.dispose();
      streamController.close();
    },
  );
}

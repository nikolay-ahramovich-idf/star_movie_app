import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:star_movie_app/main_sandbox.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  const splashScreenDelay = Duration(seconds: 3);

  group('Login Test', () {
    const validLogin = 'test@mail.ru';
    const validPassword = 'test1234';

    testWidgets('login auth test', (tester) async {
      app.main();

      await tester.pumpAndSettle(splashScreenDelay);

      final loginTabBarItem = find.text('Single');
      await tester.tap(loginTabBarItem);
      await tester.pumpAndSettle();

      final formFields = find.byType(TextFormField);
      final loginFormField = formFields.first;
      final passwordFormField = formFields.last;

      await tester.enterText(
        loginFormField,
        validLogin,
      );

      await tester.enterText(
        passwordFormField,
        validPassword,
      );

      await tester.pumpAndSettle();

      final loginButton = find.text('Login');
      await tester.tap(loginButton);
      await tester.pumpAndSettle();

      final nextScreenTextWidget = find.text('Login is success');

      expect(
        nextScreenTextWidget,
        findsOneWidget,
      );
    });
  });
}

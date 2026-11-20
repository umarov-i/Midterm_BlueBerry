import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';

import 'package:blueberry/app.dart';
import 'package:blueberry/screens/home_shell.dart';
import 'package:blueberry/screens/login_screen.dart';

void main() {
  group('login validators', () {
    test('email must be a @newuu.uz address', () {
      expect(validateNewuuEmail(''), isNotNull);
      expect(validateNewuuEmail('student@gmail.com'), isNotNull);
      expect(validateNewuuEmail('a b@newuu.uz'), isNotNull);
      expect(validateNewuuEmail('e.xushvaqtov@newuu.uz'), isNull);
      expect(validateNewuuEmail('  E.Xushvaqtov@NewUU.uz '), isNull);
    });

    test('password needs at least 6 characters', () {
      expect(validatePassword(''), isNotNull);
      expect(validatePassword('12345'), isNotNull);
      expect(validatePassword('123456'), isNull);
    });
  });

  Future<void> signIn(WidgetTester tester, {required bool asProfessor}) async {
    await tester.pumpWidget(const ProviderScope(child: BlueBerryApp()));
    if (asProfessor) {
      await tester.tap(find.text('Professor'));
      await tester.pump();
    }
    await tester.enterText(
      find.byKey(const Key('emailField')),
      'e.xushvaqtov@newuu.uz',
    );
    await tester.enterText(find.byKey(const Key('passwordField')), 'secret1');
    await tester.ensureVisible(find.text('Sign in'));
    await tester.tap(find.text('Sign in'));
    await tester.pumpAndSettle();
  }

  testWidgets('invalid form shows errors and stays on Login', (tester) async {
    await tester.pumpWidget(const ProviderScope(child: BlueBerryApp()));
    await tester.enterText(find.byKey(const Key('emailField')), 'me@gmail.com');
    await tester.ensureVisible(find.text('Sign in'));
    await tester.tap(find.text('Sign in'));
    await tester.pump();

    expect(find.text('Use your @newuu.uz email'), findsOneWidget);
    expect(find.text('At least 6 characters'), findsOneWidget);
    expect(find.byType(LoginScreen), findsOneWidget);
  });

  testWidgets('student signs in, sees 3 tabs and no + button', (tester) async {
    await signIn(tester, asProfessor: false);

    expect(find.byType(HomeShell), findsOneWidget);
    expect(find.byType(LoginScreen), findsNothing);
    expect(find.text('Signed in as E Xushvaqtov (student)'), findsOneWidget);
    expect(find.byType(NavigationDestination), findsNWidgets(3));
    expect(find.byType(FloatingActionButton), findsNothing);
  });

  testWidgets('professor gets the + button, which opens Post update', (
    tester,
  ) async {
    await signIn(tester, asProfessor: true);

    await tester.tap(find.byType(FloatingActionButton));
    await tester.pumpAndSettle();
    expect(find.text('Post update · Elshod is building this'), findsOneWidget);
  });

  testWidgets('routes pass their argument to the screen', (tester) async {
    await signIn(tester, asProfessor: false);

    await tester.tap(find.text('Open CS301'));
    await tester.pumpAndSettle();
    expect(find.widgetWithText(AppBar, 'CS301'), findsOneWidget);

    await tester.pageBack();
    await tester.pumpAndSettle();
    await tester.tap(find.text('Rooms'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Open B-204'));
    await tester.pumpAndSettle();
    expect(find.widgetWithText(AppBar, 'B-204'), findsOneWidget);
  });
}

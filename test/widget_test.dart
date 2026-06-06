import 'package:flutter_test/flutter_test.dart';

import 'package:chatbot_app/main.dart';

void main() {
  testWidgets('App starts on login screen', (WidgetTester tester) async {
    await tester.pumpWidget(const ChatBotApp());

    expect(find.text('Sign in'), findsOneWidget);
    expect(find.text('Sign In'), findsOneWidget);
  });
}

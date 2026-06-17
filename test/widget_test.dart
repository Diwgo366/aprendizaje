import 'package:flutter_test/flutter_test.dart';
import 'package:aprendizaje/main.dart';

void main() {
  testWidgets('App loads and shows navigation', (WidgetTester tester) async {
    await tester.pumpWidget(const AprendizajeApp());
    expect(find.text('Inicio'), findsWidgets);
    expect(find.text('Comer bien es aprender mejor'), findsOneWidget);
  });
}

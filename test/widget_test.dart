import 'package:flutter_test/flutter_test.dart';
import 'package:laundry_management/main.dart';

void main() {
  testWidgets('Laundry Management app loads', (tester) async {
    await tester.pumpWidget(
      const LaundryManagementApp(),
    );

    expect(find.text('Laundry Management'), findsOneWidget);
  });
}
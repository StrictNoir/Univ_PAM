import 'package:flutter_test/flutter_test.dart';

import 'package:shop_ui/src/app.dart';

void main() {
  testWidgets('Home page renders sale and new sections', (tester) async {
    await tester.pumpWidget(const ShopUiApp());
    await tester.pumpAndSettle();

    expect(find.text('Sale'), findsOneWidget);
    expect(find.text('New'), findsOneWidget);
    expect(find.text('Shop now'), findsOneWidget);
  });
}
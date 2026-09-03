import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_demo/features/dashboard/presentation/pages/dashboard_page.dart';

void main() {
  group('DashboardPage Widget Tests', () {
    testWidgets('Dashboard renders mobile layout on narrow screens', (WidgetTester tester) async {
      tester.view.physicalSize = const Size(400, 800);
      tester.view.devicePixelRatio = 1.0;

      await tester.pumpWidget(
        const MaterialApp(
          home: DashboardPage(),
        ),
      );

      // Verify basic elements
      expect(find.text('Responsive Dashboard'), findsOneWidget);
      expect(find.text('Total Sales'), findsOneWidget);
      expect(find.text('Active Users'), findsOneWidget);
      
      // Cleanup
      tester.view.resetPhysicalSize();
      tester.view.resetDevicePixelRatio();
    });

    testWidgets('Dashboard renders desktop layout on wide screens', (WidgetTester tester) async {
      tester.view.physicalSize = const Size(1200, 800);
      tester.view.devicePixelRatio = 1.0;

      await tester.pumpWidget(
        const MaterialApp(
          home: DashboardPage(),
        ),
      );

      // Verify desktop specific elements or structure
      expect(find.text('Chart Placeholder'), findsOneWidget);
      expect(find.text('Recent Activity'), findsOneWidget);
      
      // Cleanup
      tester.view.resetPhysicalSize();
      tester.view.resetDevicePixelRatio();
    });
  });
}

// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter_adaptive_scaffold_example/adaptive_scaffold_demo.dart'
    as example;
import 'package:flutter_test/flutter_test.dart';

void main() {
  final Finder smallBody = find.byKey(const Key('smallBody'));
  final Finder body = find.byKey(const Key('body'));
  final Finder expandedBody = find.byKey(const Key('expandedBody'));
  final Finder largeBody = find.byKey(const Key('largeBody'));
  final Finder extraLargeBody = find.byKey(const Key('extraLargeBody'));
  final Finder bnav = find.byKey(const Key('bottomNavigation'));
  final Finder pnav = find.byKey(const Key('primaryNavigation'));
  final Finder pnav1 = find.byKey(const Key('primaryNavigation1'));
  final Finder pnav2 = find.byKey(const Key('primaryNavigation2'));
  final Finder pnav3 = find.byKey(const Key('primaryNavigation3'));

  Future<void> updateScreen(double width, WidgetTester tester,
      {int transitionDuration = 1000}) async {
    await tester.binding.setSurfaceSize(Size(width, 2000));
    await tester.pumpWidget(
      MaterialApp(
        home: MediaQuery(
            data: MediaQueryData(size: Size(width, 2000)),
            child: example.MyHomePage(
              transitionDuration: transitionDuration,
            )),
      ),
    );
  }

  testWidgets('displays correct item of config based on screen width',
      (WidgetTester tester) async {
    await updateScreen(300, tester);
    await tester.pumpAndSettle();
    expect(smallBody, findsOneWidget);
    expect(bnav, findsOneWidget);
    expect(tester.getTopLeft(smallBody), Offset.zero);
    expect(tester.getTopLeft(bnav), const Offset(0, 1920));
    expect(body, findsNothing);
    expect(expandedBody, findsNothing);
    expect(largeBody, findsNothing);
    expect(extraLargeBody, findsNothing);
    expect(pnav, findsNothing);
    expect(pnav1, findsNothing);
    expect(pnav2, findsNothing);
    expect(pnav3, findsNothing);

    await updateScreen(800, tester);
    await tester.pumpAndSettle();
    expect(body, findsOneWidget);
    expect(pnav, findsOneWidget);
    expect(tester.getTopLeft(body), const Offset(88, 0));
    expect(tester.getTopLeft(pnav), Offset.zero);
    expect(smallBody, findsNothing);
    expect(expandedBody, findsNothing);
    expect(largeBody, findsNothing);
    expect(extraLargeBody, findsNothing);
    expect(bnav, findsNothing);
    expect(pnav1, findsNothing);
    expect(pnav2, findsNothing);
    expect(pnav3, findsNothing);

    await updateScreen(1200, tester);
    await tester.pumpAndSettle();
    expect(expandedBody, findsOneWidget);
    expect(pnav1, findsOneWidget);
    expect(tester.getTopLeft(expandedBody), const Offset(100, 0));
    expect(tester.getTopLeft(pnav1), Offset.zero);
    expect(smallBody, findsNothing);
    expect(body, findsNothing);
    expect(largeBody, findsNothing);
    expect(extraLargeBody, findsNothing);
    expect(bnav, findsNothing);
    expect(pnav, findsNothing);
    expect(pnav2, findsNothing);
    expect(pnav3, findsNothing);

    await updateScreen(1400, tester);
    await tester.pumpAndSettle();
    expect(body, findsOneWidget);
    expect(expandedBody, findsNothing);
    expect(largeBody, findsOneWidget);
    expect(tester.getTopLeft(largeBody), const Offset(288, 0));
    expect(largeBody, findsOneWidget);
    expect(bnav, findsNothing);
    expect(extraLargeBody, findsNothing);
    expect(pnav, findsNothing);
    expect(pnav1, findsNothing);
    expect(pnav2, findsOneWidget);
    expect(tester.getTopLeft(pnav2), Offset.zero);
    expect(tester.getBottomRight(pnav2), const Offset(288, 800));
    expect(pnav3, findsNothing);

    await updateScreen(1700, tester);
    await tester.pumpAndSettle();
    expect(body, findsOneWidget);
    expect(expandedBody, findsNothing);
    expect(largeBody, findsNothing);
    expect(extraLargeBody, findsOneWidget);
    expect(tester.getTopLeft(extraLargeBody), const Offset(400, 0));
    expect(extraLargeBody, findsOneWidget);
    expect(bnav, findsNothing);
    expect(pnav, findsNothing);
    expect(pnav1, findsNothing);
    expect(pnav2, findsNothing);
    expect(pnav3, findsOneWidget);
    expect(tester.getTopLeft(pnav3), Offset.zero);
    expect(tester.getBottomRight(pnav3), const Offset(400, 800));
  });

  testWidgets('adaptive scaffold animations work correctly',
      (WidgetTester tester) async {
    final Finder b = find.byKey(const Key('body'));
    final Finder sBody = find.byKey(const Key('sBody'));

    await updateScreen(400, tester);
    await updateScreen(800, tester);

    await tester.pump();
    await tester.pump(const Duration(milliseconds: 200));

    expect(tester.getTopLeft(b), const Offset(17.6, 0));
    expect(tester.getBottomRight(b),
        offsetMoreOrLessEquals(const Offset(778.2, 736), epsilon: 1.0));
    expect(tester.getTopLeft(sBody),
        offsetMoreOrLessEquals(const Offset(778.2, 0), epsilon: 1.0));
    expect(tester.getBottomRight(sBody),
        offsetMoreOrLessEquals(const Offset(1178.2, 736), epsilon: 1.0));

    await tester.pump();
    await tester.pump(const Duration(milliseconds: 600));

    expect(tester.getTopLeft(b), const Offset(70.4, 0));
    expect(tester.getBottomRight(b),
        offsetMoreOrLessEquals(const Offset(416.0, 784), epsilon: 1.0));
    expect(tester.getTopLeft(sBody),
        offsetMoreOrLessEquals(const Offset(416, 0), epsilon: 1.0));
    expect(tester.getBottomRight(sBody),
        offsetMoreOrLessEquals(const Offset(816, 784), epsilon: 1.0));

    await tester.pump();
    await tester.pump(const Duration(milliseconds: 200));

    expect(tester.getTopLeft(b), const Offset(88, 0));
    expect(tester.getBottomRight(b), const Offset(400, 800));
    expect(tester.getTopLeft(sBody), const Offset(400, 0));
    expect(tester.getBottomRight(sBody), const Offset(800, 800));
  });

  testWidgets('animation plays correctly in declared duration',
      (WidgetTester tester) async {
    final Finder b = find.byKey(const Key('body'));
    final Finder sBody = find.byKey(const Key('sBody'));

    await updateScreen(400, tester, transitionDuration: 500);
    await updateScreen(800, tester, transitionDuration: 500);

    await tester.pump();
    await tester.pump(const Duration(milliseconds: 500));

    expect(tester.getTopLeft(b), const Offset(88, 0));
    expect(tester.getBottomRight(b), const Offset(400, 800));
    expect(tester.getTopLeft(sBody), const Offset(400, 0));
    expect(tester.getBottomRight(sBody), const Offset(800, 800));
  });

  testWidgets(
      'when view in large screen, navigation rail must be visible as per theme data values.',
      (WidgetTester tester) async {
    await updateScreen(1200, tester);
    await tester.pumpAndSettle();

    final Finder primaryNavigationLarge = find.byKey(
      const Key('primaryNavigation2'),
    );
    expect(primaryNavigationLarge, findsOneWidget);

    final Finder navigationRailFinder = find.descendant(
      of: primaryNavigationLarge,
      matching: find.byType(NavigationRail),
    );
    expect(navigationRailFinder, findsOneWidget);

    final NavigationRail navigationRailView = tester.firstWidget(
      navigationRailFinder,
    );
    expect(navigationRailView, isNotNull);
    expect(
      navigationRailView.backgroundColor,
      Colors.white,
    );
    expect(
      navigationRailView.selectedIconTheme?.size,
      32.0,
    );
    expect(
      navigationRailView.selectedIconTheme?.color,
      Colors.red,
    );
    expect(
      navigationRailView.unselectedIconTheme?.size,
      24.0,
    );
    expect(
      navigationRailView.unselectedIconTheme?.color,
      Colors.black,
    );
  });

  testWidgets(
      'when view in extra large screen, navigation rail must be visible as per theme data values.',
      (WidgetTester tester) async {
    await updateScreen(1600, tester);
    await tester.pumpAndSettle();

    final Finder primaryNavigationExtraLarge = find.byKey(
      const Key('primaryNavigation3'),
    );
    expect(primaryNavigationExtraLarge, findsOneWidget);

    final Finder navigationRailFinder = find.descendant(
      of: primaryNavigationExtraLarge,
      matching: find.byType(NavigationRail),
    );
    expect(navigationRailFinder, findsOneWidget);

    final NavigationRail navigationRailView = tester.firstWidget(
      navigationRailFinder,
    );
    expect(navigationRailView, isNotNull);
    expect(
      navigationRailView.backgroundColor,
      Colors.white,
    );
    expect(
      navigationRailView.selectedIconTheme?.size,
      32.0,
    );
    expect(
      navigationRailView.selectedIconTheme?.color,
      Colors.red,
    );
    expect(
      navigationRailView.unselectedIconTheme?.size,
      24.0,
    );
    expect(
      navigationRailView.unselectedIconTheme?.color,
      Colors.black,
    );
  });
}
